# TheMovieDatabase

### Pods used
#### Alamofire
#### AlamofireImage
#### LPSnackbar
#### YoutubePlayer-in-WKWebView

### Usage
```ruby
pod install
```

# Estructura del proyecto:
### Common -> Clases y recursos generales
#### /Extension -> Extensiones de objectos para su uso más sencillo
#### ServiceManager -> Servicio general para que el resto herede sus funcionalidades
#### ConfigManager -> Clase que lee un .plist y deisponibiliza todas las configuraciones
#### PersistenceManager -> Clase para persistir en core data lo que se requiera
#### BaseViewController -> Controlador básico que agrupa funcionalidades afines

### Main -> Estructura general de la app (TabBar)
#### /Controller

### List -> Listado de peículas, series y buscador
#### /Model
#### /View
#### /Controller
#### /Controller/Delegate
#### /Service
#### /Service/Codable

### Detail -> Detalle de películas y shows
#### /Model
#### /View
#### /Controller
#### /Controller/Delegate
#### /Service
#### /Service/Codable

#### Principio de responsabilidad única:
Consiste en encapsular las funcionalidades de una clase, método o módulo de una aplicación en responsabilidades para no generar código que realice acciones de diferentes unidades de negocio o bien de diferentes entidades. Esto ayuda a organizar cada clase y módulo para que la interacción entre ellas sea completamente entedible y que las mismas solo contengan funcionalidades específicas de su responsabilidad

#### Código limpio:
Un código limpio debe entenderse fácilmente por cualquier otro programador, como así también intentar simplificar la sintaxis para que la legibilidad del mismo sea más sencilla. Las funciones no deben realizar muchas acciones al igual que las clases deben tener definidas sus responsabilidades correctamente para evitar problemas al momento de agregar funcionalidades.

Un beneficio muy importante de programar con mínimas dependecias y de manera límpia es que es fácilmente extendido o utilizado por otros módulos de la aplicación así como por otros desarrolladores.

En resúmen lo más importante al momento de programar en generar un código testeable, símple de comprender, fácilmente extendible o incorporable a otras funcionalidades de una app y evitar siempre la redundancia de código.

## Marcelo Oscar José - 2019