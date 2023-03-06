## Aplicacion Rick&Morty

El siguiente código es una aplicación que se ejecuta en terminal para poder resolver el desafío de Rick&Morty de Chipax!

**ANTES DE EJECUTAR EL PROGRAMA IMPORTANTE -- INSTALAR LIBRERIAS**
Antes de ejecutar el programa se deben instalar ciertas gemas que se utilizaron para su código. ([rest-client](https://www.rubydoc.info/gems/rest-client/1.8.0) para hacer llamado a la API, [rspec](https://rubygems.org/gems/rspec/versions/3.4.0?locale=es) para realizar los testing)
Debes ejecutar las siguientes lineas de código para su instalación: (JSON y Time vienen por default instaladas en ruby)
1. `gem install rest-client`
2. `gem install rspec`

**EJECUCION DEL PROGRAMA**
Para la ejecución del programa se debe ejecutar el archivo **app.rb** para esto debemos hacer lo siguiente:
1. Nos debemos para en la carpeta principal con el comando `cd Rick&Morty`
2. Ejecutamos el archivo app.rb con el comando `ruby lib/app.rb`
3. El programa debiera entregar un mensaje de bienvenida, y dando anuncio a que se están descargando los datos
4. Luego se debe escoger el ejercicio que se desea ejecutar y seguir las instrucciones





**QUÉ HACE EL CÓDIGO**
El programa calculará lo siguiente:

Consultará todos los `character`, `locations` y `episodes` de la API de Rick & Morty [https://rickandmortyapi.com/](https://rickandmortyapi.com/) e indicará:

1. Char counter:
    - cuántas veces aparece la letra **"l"** (case insensitive) en los nombres de todos los `location`
    - cuántas veces aparece la letra **"e"** (case insensitive) en los nombres de todos los `episode`
    - cuántas veces aparece la letra **"c"** (case insensitive) en los nombres de todos los `character`
    - cuánto tardó el programa en total (desde inicio ejecución hasta entrega de resultados)
2. Episode locations:
    - para cada `episode`, indicar la cantidad y un listado con las `location` (`origin`) de todos los `character` que aparecieron en ese `episode` (sin repetir)
    - cuánto tardó el programa en total (desde inicio ejecución hasta entrega de resultados)


**DISEÑO DE CÓDIGO**

La aplicación se creo siguiento un **patron MVC** (MODELO, VISTA, CONTROLADOR)
1. Los **MODELO** representa a los objectos más básicos a manipular, en este caso corresponden a los personajes (character), los episodios (episode) y las localizaciones (location), para las cuales se trabajo con un paradigma de OOP (Object Oriented Programming)
2. La **VISTA** es donde le **mostramos la información** al usuario (`puts`) y también le **pedimos información** (`gets`), en este caso, qué letras se quieren buscar  (el programa quedo diseñado para comparar cualquier letra) y qué capítulo desea analizar
3. El **CONTROLADOR** (Controller) se encarga de recuperar y almacenará datos de los modelo y le dirá a la vista que le muestre al/a la usuario/a datos o que le pida datos a él/ella. En resumen, conecta a la vista con el modelo.
4. El **rickmorty.rb** se encarga de hacer todas las peticiones a la API de Rick & Morty, almacenando esa información para que después la trabaje el controlador.
5. El **router.rb** se encarga de generar el código con las distintas opciones que tendrá el usuario a ejecutar, en este caso, los dos juegos `char_counter` o `episode_locations` o bien detener el programa.
6. El **app.rb** tiene la misión de instanciar las variables del controlador y del router para dar inicio a la aplicación

**OBSERVACIONES**
Para el cálculo del tiempo de ejecución se consideró como punto de partida una vez que las peticiones a la API ya fueron realizadas.

Para ejecutar los **TEST** se debe ejecutar en consola el archivo de test.rb ubicado en la carpeta spec para esto:
1. Nos debemos para en la carpeta principal con el comando `cd Rick&Morty`
2. Ejecutamos el archivo app.rb con el comando `ruby spec/test.rb`

**CONTRIBUCIONES**
A continuación se da una serie de buenas prácticas para poder contribuir en el proyecto de Rick&Morty
1. Realizar siempre commits descriptivos.
2. La rama principal es la rama `master`
3. Para crear/arreglar **SIEMPRE** trabajar desde ramas diferentes a la `master`
3. 1- Para arreglar se debe crear rama bajo el prefijo `fix` (ejemplo: quiero arreglar archivo de test la rama sería: `fix_test`)
2 - Para crear nueva feature se debe crear rama bajo el prefijo `new`(ejemplo: quiero agregar un nuevo modelo `new_model`)

**CHANGELOG**
Se posee un archivo aparte con todos los cambios realizados al programa a partir de su base funcional
