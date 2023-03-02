require 'json'

# Esta clase es la encargada en mostrarle y pedirle información al usuario
class View

  # PUTS que se le muestra al usuario del juego char_counter
  def char_counter_results(result, letters)
    my_object = { :exercise_name => "Char counter" , :time => result['time'] , :in_time => "true", :results => [{:char => letters[0], :count => result['location_result'] , :resource => "location"}, {:char => letters[1], :count => result['episode_result'] , :resource => "episode"}, {:char => letters[2], :count => result['character_result'] , :resource => "character"} ] }
    puts JSON.pretty_generate(my_object)
  end

  # PUTS que se le muestra al usuario del juego epísode location
  def episode_locations(episode, time)
    my_object = { :exercise_name => "Episode Locations" , :time => time, :in_time => "true", :results => [{:name => "Picke Rick", :episode => episode.episode_number , :quantity_of_locations => episode.locations.size, :locations => episode.locations }]}
    puts JSON.pretty_generate(my_object)
  end

  # GET que se le pide al usuario
  def ask_user_for_letter
    puts "Escoge una letra para ver cuantas veces repite en los nombres de todos los location (en minuscula)"
    location_letter = gets.chomp
    puts "Escoge una letra para ver cuantas veces repite en los nombres de todos los episode (en minuscula)"
    episode_letter = gets.chomp
    puts "Escoge una letra para ver cuantas veces repite en los nombres de todos los character (en minuscula)"
    character_letter = gets.chomp
    return [location_letter, episode_letter, character_letter]
  end

  # GET que se le pide al usuario
  def ask_user_for_id
    puts "Escoge el id de un capítulo para analizar (del 1 al 51)"
    episode_id = gets.chomp.to_i
    return episode_id
  end
end
