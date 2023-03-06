require_relative 'rickmorty'    # Requerimos el archivo que carga la información de RickMorty
require_relative 'controller/controller'  # Requerimos del controlador creado
require_relative 'router'

# En este archivo se da inicio a la aplicación instanciando la clase rickmorty para cargar la información, al controlador correspondiente de la app y el router quien es quien observa la acción del usuario
p "Welcome!, wait for information download before get started!"
character_csv_file = File.join(__dir__, 'characters.csv')
episode_csv_file = File.join(__dir__, 'episodes.csv')
location_csv_file = File.join(__dir__, 'locations.csv')
rickmorty = Rickmorty.new(character_csv_file, episode_csv_file, location_csv_file)
controller = Controller.new(rickmorty)

router = Router.new(controller)

# Start the app
# router.run

#-------------------------------------------------
p rickmorty.episodes
