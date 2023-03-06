**CHANGELOG**
El siguiente archivo posee todos los cambios en features/fix que se le han realizado al programa a partir de su base funcional.
Convención: (1. date: changes)

1. 05/03/2023: Incluyó base de datos en forma de csv para optimizar la carga del programa y tener que recurrir a la API solo una vez, o bien cuando se desee carga nueva información.
2. 06/03/2023: Se incluyeron test de `case_insensitive` y se arreglaron los test con el uso de `mocks` para chequear que se cargaron todas los datos de la API. (Se puede agregar un nuevo episodio a la API y el test va a corroborar eso)
