require_relative "../models/character"
require_relative "../models/location"
require_relative "../models/episode"
require_relative "../view/view"
require_relative "../rickmorty"

class Controller

  def initialize(rickmorty)
    @rickmorty = rickmorty
    @view = View.new
  end

  # Creamos una funcion char_counter que será la encargada de conectar los input obtenidos por la vista con el rickmorty
  def char_counter
    letters = @view.ask_user_for_letter
    start_time = Time.now
    characters = @rickmorty.characters
    episodes = @rickmorty.episodes
    locations = @rickmorty.locations
    finish_time = Time.now
    total_time = finish_time - start_time
    result_character = { "time" => total_time, "character_result" => @rickmorty.count_letter(letters[2], characters), "episode_result" => @rickmorty.count_letter(letters[1], episodes), "location_result" => @rickmorty.count_letter(letters[0], locations)}
    return @view.char_counter_results(result_character, letters)
  end

  def episode_counter
    episode_id = @view.ask_user_for_id
    start_time = Time.now
    episode = @rickmorty.episodes[episode_id - 1]
    finish_time = Time.now
    total_time = finish_time - start_time
    return @view.episode_locations(episode, total_time)
  end
end
