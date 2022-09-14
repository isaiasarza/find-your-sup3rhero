#  Find Your Sup3rhero App

* Autor: Isaías Arza.
* Fecha: 14/09/2022

## Login y Registro

Se implementan en el AuthViewController. El manejo de usuarios y claves está integrado con Firebase Authentication.

## Home

El home consta de un tab bar con dos opciones:

* Personajes: Muestra un listado de personajes de Marvel, con un scroll infinito cada 15 ítems.
* Eventos: Muestra los próximos 25 eventos a disputar.

## Temas a mejorar

* La imagen de background utilizada en AuthViewController no se muestra correctamente en modo portrait.
* Al navegar a HomeTabBarController, no se pudo setear como RootController. Por esta razón, se muestra el Back Button en la barra de estado, y esto permite volver hacia atrás sin cerrar sesión.
* Las imágenes se descargan de forma bloqueante. En el caso del scroll infinito, luego de buscar una nueva página se descargan las imágenes correspondientes. Esto provoca lentitud al interactuar con la app, y se estará corrigiendo en los próximos días. 

## Agradecimientos

Se agradece a Marvel por el uso de la api pública y a IntermediaIt por provisionar íconos.



