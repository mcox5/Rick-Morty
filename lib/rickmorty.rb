# Este archivo es el que almacenará toda la información de Rick&Morty, como episodios, localizacion, personajes
# Sería como el equivalente a un libro de cocina, el cual contiene todas las recetas

require_relative 'models/character'
require_relative 'models/episode'
require_relative 'models/location'
require 'json'
require 'rest-client'
require 'csv'

class Rickmorty
  attr_reader :characters, :locations, :episodes

  def initialize(csv_file_character_path, csv_file_episode_path, csv_file_location_path)
    @csv_file_character_path = csv_file_character_path
    @csv_file_episode_path = csv_file_episode_path
    @csv_file_location_path = csv_file_location_path
    @characters = []
    @locations = []
    @episodes = []
    # Chequeamos si la base de datos esta cargada (basta con chequear solo una ya que se cargan las tres al mismo tiempo)
    csv_table = CSV.table(@csv_file_character_path)
    if csv_table.count.positive?
      load_csv
    else
      load_characters
      load_locations
      load_episodes
      charge_csv
    end
    # load_characters # Las funciones load dentro del initialize es para que se cargue automaticamente la info desde la API para cuando instanciemos a Rickmorty
    # load_locations
    # load_episodes
    # load_csv
    # charge_csv
  end

  # El método get_request hace la petición get a la API dependiendo de la URL que se le entregue
  def get_request(url)
    array_response = RestClient.get(url)
    ruby_response = JSON.parse(array_response)
    return ruby_response
  end

  # En la siguientes funciones de load hacemos el get request a la API de Rick and Morty con la url correspondiente
  def load_characters
    character_url = 'https://rickandmortyapi.com/api/character'
    pages = get_request(character_url)['info']['pages'] # Utilizaremos esta variable para acceder a las diferentes páginas de la API ya que entrega solo 20 resultados por peticion
    (1..pages).each do |page|
      character_url_with_page = "https://rickandmortyapi.com/api/character?page=#{page}"
      character_array = get_request(character_url_with_page)['results']
      # Ahora recorremos todos los personajes por cada página y los vamos guardando en el array definido en el initialize
      character_array.each do |character|
        @characters.push(Character.new(character['name'], character['origin']['name']))
      end
    end
    # p @characters.first.origin
    return @characters
  end

  def load_locations
    location_url = 'https://rickandmortyapi.com/api/location'
    pages = get_request(location_url)['info']['pages'] # Utilizaremos esta variable para acceder a las diferentes páginas de la API ya que entrega solo 20 resultados por peticion
    (1..pages).each do |page|
      location_url_with_page = "https://rickandmortyapi.com/api/location?page=#{page}"
      location_array = get_request(location_url_with_page)['results']
      # Ahora recorremos todos las localizaciones por cada página y los vamos guardando en el array definido en el initialize
      location_array.each do |location|
        @locations.push(Location.new(location['name']))
      end
    end
    return @locations
  end

  # Para el caso de los episodios, nos interesa guardar tambien todas la localizaciones asociadas a cada episodio
  def load_episodes
    episode_url = 'https://rickandmortyapi.com/api/episode'
    pages = get_request(episode_url)['info']['pages'] # Utilizaremos esta variable para acceder a las diferentes páginas de la API ya que entrega solo 20 resultados por peticion
    (1..pages).each do |page|
      episode_url_with_page = "https://rickandmortyapi.com/api/episode?page=#{page}"
      episode_array = get_request(episode_url_with_page)['results']

      # p episode_array (PARECIERA QUE ESTA BIEN HASTA ESTE PUNTO)
      # Ahora recorremos todos los episodios por cada página y los vamos guardando en el array definido en el initialize
      episode_array.each do |episode|
        # Extraemos las url de todos los personajes de ese episodio
        episode_character_url = (episode['characters']) # Es un array BIEN HASTA AQUI
        # Necesitamos recorrer esas url para poder obtener el id del personaje y de esta manera saber su origin
        episode_characters_origin = []
        episode_character_url.each do |character_url|
          character_id = character_url.delete("^0-9").to_i
          character = @characters[character_id - 1]
          episode_characters_origin.push(character.origin)
        end
        episode_characters_origin = episode_characters_origin.uniq #Eliminamos locations que se repitan dentro de un mismo capitulo
        @episodes.push(Episode.new(episode['name'], episode['episode'], episode_characters_origin))
      end
    end
    return @episodes
  end

  def count_letter(letter, list)
    counter = 0
    #1 ero hacemos que sea case insensitive
    list_downcase = list.map do |element|
      element.name.downcase
    end
    #luego comparamos con la letra seleccionada por el usuario
    list_downcase.each do |name|
      counter += name.count(letter)
    end
    return counter
  end
end
  # Método que se utilizará en caso de que el CSV ya esté cargado (instanciamos a partir del CSV)
  def load_csv
    CSV.foreach(@csv_file_character_path) do |row|
      character = Character.new(row[0], row[1])
      @characters.push(character)
    end
    CSV.foreach(@csv_file_episode_path) do |row|
      episode = Episode.new(row[0], row[1], row[2].split(';'))
      @episodes.push(episode)
    end
    CSV.foreach(@csv_file_location_path) do |row|
      location = Location.new(row[0])
      @locations.push(location)
    end
  end

  # Método que se utilizará para cargar por primera vez el CSV (se ejecuta después del llamado a la APi)
  def charge_csv
    CSV.open(@csv_file_character_path, "w") do |csv|
      @characters.each do |character_to_read|
        csv << [character_to_read.name, character_to_read.origin]
      end
    end
    CSV.open(@csv_file_episode_path, "w") do |csv|
      @episodes.each do |episode_to_read|
        csv << [episode_to_read.name, episode_to_read.episode_number, episode_to_read.locations.join(';')]
      end
    end
    CSV.open(@csv_file_location_path, "w") do |csv|
      @locations.each do |location_to_read|
        csv << [location_to_read.name]
      end
    end
  end
