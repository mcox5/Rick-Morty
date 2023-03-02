require_relative 'rickmorty'    # Requerimos el archivo que carga la información de RickMorty
require_relative 'controller/controller'  # Requerimos del controlador creado
require_relative 'router'

# En este archivo se da inicio a la aplicación instanciando la clase rickmorty para cargar la información, al controlador correspondiente de la app y el router quien es quien observa la acción del usuario
p "Welcome!, wait for information download before get started!"
rickmorty = Rickmorty.new
controller = Controller.new(rickmorty)

router = Router.new(controller)

# Start the app
router.run
