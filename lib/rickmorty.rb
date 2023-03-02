# Este archivo es el que almacenará toda la información de Rick&Morty, como episodios, localizacion, personajes
# Sería como el equivalente a un libro de cocina, el cual contiene todas las recetas

require_relative 'models/character'
require_relative 'models/episode'
require_relative 'models/location'
require 'json'
require 'rest-client'

class Rickmorty
  attr_reader :characters, :locations, :episodes

  def initialize
    @characters = []
    @locations = []
    @episodes = []
    load_characters # Las funciones load dentro del initialize es para que se cargue automaticamente la info desde la API para cuando instanciemos a Rickmorty
    load_locations
    load_episodes
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

# ---------------------------------------

# rickmortycheck = Rickmorty.new
# # p rickmortycheck.characters
# rickmortycheck.count_letter("a", rickmortycheck.characters)
