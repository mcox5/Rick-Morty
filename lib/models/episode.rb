class Episode
  attr_reader :name, :locations, :episode_number

  def initialize(name, episode_number, locations)
    @name = name
    @episode_number = episode_number
    @locations = locations
  end
end
