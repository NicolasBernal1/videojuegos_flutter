# Guía de implementación en vivo · Movies
## Diseño azul con cambios pequeños

Objetivo: llegar al diseño del proyecto usando componentes sencillos, modificando una sola parte a la vez. La guía está dividida en acciones cortas para escribir y explicar frente al grupo.

Tiempo sugerido: dos bloques de 50–60 minutos, incluyendo preguntas y comprobaciones. Puedes detenerte al terminar el detalle y continuar la lista en la siguiente sesión.

## Cómo usar esta versión

Cada paso indica archivo, ancla exacta, acción, código breve, explicación y comprobación. Los bloques son fragmentos para insertar en el lugar indicado, no archivos completos. Cuando se indica «reemplaza», elimina la versión anterior; cuando dice «agrega», conserva lo demás.

Para envolver un widget, selecciónalo completo, usa la acción del editor «Wrap with widget» y escribe el contenedor indicado. El widget seleccionado se conserva en child. Si lo haces manualmente, abre el nuevo contenedor antes del widget y cierra su paréntesis después. No sustituyas el contenido por puntos suspensivos o comentarios.

No pegues toda una clase ni reemplaces todo build. Guarda y haz hot reload al completar cada paso. En el paso 7.2 hay tres cambios que deben hacerse juntos antes de ejecutar para mantener los índices correctos.

Punto de partida: lista con MovieCard, detalle con Column y SingleChildScrollView, navegación y favorito funcionando. Si una mejora ya existe, revísala y continúa; no la dupliques.

## 0 · Verifica la base (5 minutos)

1. Ejecuta el proyecto y abre dos videojuegos diferentes.
2. Comprueba que la estrella cambia de favorita y permite desmarcarla.
3. Verifica que Movie tenga id, title, genre, watched, description e imagePath.
4. Revisa assets/images/ en pubspec.yaml y los nombres de las imágenes.
5. Conserva la URL funcional, MovieService, fromJson, initState y los métodos de persistencia.

No cambies HTTP, CORS o puertos durante esta práctica de diseño. Si la carga ya falla, resuélvelo antes de empezar.

Resultado esperado: lista centrada con encabezado, tarjetas de póster y estrella; detalle con póster, etiquetas y sinopsis; colores azules compartidos.

## 1 · Tema azul (5 minutos)

### 1.1 · Permite configurar el tema

Archivo: lib/main.dart.

Busca: return const MaterialApp(...) dentro de MyApp.build.

Haz este cambio: Quita solo const de MaterialApp. En su propiedad home deja const MovieScreen(). No cambies main().

Explica: ThemeData no es una expresión constante; MovieScreen sí puede seguir usando su constructor const.

Comprueba: La aplicación conserva la misma pantalla y compila.

### 1.2 · Agrega la paleta

Archivo: lib/main.dart.

Busca: debugShowCheckedModeBanner: false, dentro de MaterialApp.

Haz este cambio: Inserta después esta propiedad theme:

```dart
theme: ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
),
```

Explica: Una semilla genera colores relacionados. Las pantallas consultarán el mismo tema.

Comprueba: Los controles que usan el tema toman tonos azules.

## 2 · Espacio del detalle (10 minutos)

### 2.1 · Obtén el tema y úsalo como fondo

Archivo: lib/movie_detail.dart.

Busca: Widget build(BuildContext context) y return Scaffold(.

Haz este cambio: Justo antes de return Scaffold agrega la primera línea. Dentro de Scaffold agrega la propiedad backgroundColor (segunda línea). Son dos ubicaciones distintas:

```dart
final colors = Theme.of(context).colorScheme;
backgroundColor: colors.surfaceContainerLowest,
```

Explica: colors vive dentro de build. La propiedad de fondo pertenece al Scaffold, no se pega como instrucción suelta.

Comprueba: El detalle tiene un fondo suave. Las dos líneas quedan en sus lugares correspondientes.

### 2.2 · Cambia la barra superior

Archivo: lib/movie_detail.dart.

Busca: appBar: AppBar(...) del detalle.

Haz este cambio: Reemplaza únicamente esa propiedad:

```dart
appBar: AppBar(
  title: const Text('Detalle de la videojuego'),
  centerTitle: true,
),
```

Explica: El título de la barra identifica la pantalla; el nombre de la videojuego permanece en el contenido.

Comprueba: Se ve el título centrado y sigue disponible el botón para volver.

### 2.3 · Protege el contenido

Archivo: lib/movie_detail.dart.

Busca: El SingleChildScrollView que ocupa body.

Haz este cambio: Envuelve SOLO ese SingleChildScrollView en SafeArea usando el editor. El scroll pasa a ser child de SafeArea.

Explica: SafeArea respeta las áreas reservadas del dispositivo. Conservamos el desplazamiento existente.

Comprueba: La pantalla sigue desplazándose y muestra la misma información.

### 2.4 · Aumenta el margen interior

Archivo: lib/movie_detail.dart.

Busca: La propiedad padding del SingleChildScrollView.

Haz este cambio: Cambia su valor; si no existe, agrégala:

```dart
padding: const EdgeInsets.all(24),
```

Explica: El padding separa el contenido de los bordes, no separa cada sección de sus vecinas.

Comprueba: El texto deja espacio a ambos lados.

### 2.5 · Limita el ancho

Archivo: lib/movie_detail.dart.

Busca: La Column principal que es child del scroll.

Haz este cambio: Envuelve esa Column en ConstrainedBox. Dentro del nuevo ConstrainedBox agrega:

```dart
constraints: const BoxConstraints(maxWidth: 600),
```

Explica: 600 es un máximo; en un celular se usa el espacio que haya disponible.

Comprueba: En una ventana ancha el contenido ya no se estira de lado a lado.

### 2.6 · Centra el bloque

Archivo: lib/movie_detail.dart.

Busca: El ConstrainedBox de ancho 600 que acabas de crear.

Haz este cambio: Envuélvelo en Center. Conserva CrossAxisAlignment.start en la Column interna.

Explica: Center centra el bloque completo; CrossAxisAlignment.start mantiene los textos alineados al inicio. Orden: SafeArea → scroll → Center → ConstrainedBox → Column.

Comprueba: En pantalla grande aparecen márgenes a ambos lados del bloque.

## 3 · Construye el póster por capas (10 minutos)

### 3.1 · Muestra la imagen real

Archivo: lib/movie_detail.dart.

Busca: El Container café o gris al principio de children de la Column principal.

Haz este cambio: Reemplaza solo ese Container por:

```dart
Image.asset(
  movie.imagePath,
  fit: BoxFit.cover,
),
```

Explica: La ruta viene de la videojuego seleccionada. cover llena el espacio sin deformar; puede recortar. El tamaño se ajusta en los pasos siguientes.

Comprueba: Cada videojuego intenta cargar su propia imagen; corrige primero cualquier ruta inexistente.

### 3.2 · Define la proporción

Archivo: lib/movie_detail.dart.

Busca: El Image.asset del paso 3.1.

Haz este cambio: Envuélvelo en AspectRatio y agrega esta propiedad al contenedor:

```dart
aspectRatio: 2 / 3,
```

Explica: Por cada dos unidades de ancho habrá tres de alto: formato vertical de póster.

Comprueba: La imagen tiene proporción vertical, aunque todavía puede verse grande.

### 3.3 · Agrega una tarjeta

Archivo: lib/movie_detail.dart.

Busca: El AspectRatio del póster.

Haz este cambio: Envuélvelo en Card y agrega estas propiedades al Card:

```dart
elevation: 4,
margin: EdgeInsets.zero,
clipBehavior: Clip.antiAlias,
shape: RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(20),
),
```

Explica: elevation crea sombra; shape redondea; clipBehavior recorta la imagen para respetar esa forma.

Comprueba: Las esquinas están redondeadas y aparece una sombra.

### 3.4 · Limita el tamaño del póster

Archivo: lib/movie_detail.dart.

Busca: El Card del póster, no el ConstrainedBox de toda la pantalla.

Haz este cambio: Envuelve el Card en otro ConstrainedBox y agrégale:

```dart
constraints: const BoxConstraints(maxWidth: 260),
```

Explica: El contenido general puede medir 600, pero el póster tendrá un máximo de 260.

Comprueba: El póster deja de ocupar todo el ancho.

### 3.5 · Centra el póster

Archivo: lib/movie_detail.dart.

Busca: El ConstrainedBox de ancho 260.

Haz este cambio: Envuélvelo en Center. La cadena del póster debe ser Center → ConstrainedBox → Card → AspectRatio → Image.asset.

Explica: Solo centramos el póster, no los textos que vienen después.

Comprueba: El póster queda centrado sobre el título.

### 3.6 · Muestra una alternativa si falla la imagen

Archivo: lib/movie_detail.dart.

Busca: fit: BoxFit.cover, del Image.asset del póster.

Haz este cambio: Agrega debajo, dentro de Image.asset:

```dart
errorBuilder: (context, error, stackTrace) {
  return ColoredBox(
    color: colors.surfaceContainerHighest,
    child: Center(
      child: Icon(
        Icons.movie_outlined,
        size: 72,
        color: colors.onSurfaceVariant,
      ),
    ),
  );
},
```

Explica: errorBuilder dibuja una alternativa; no repara el archivo faltante.

Comprueba: Si una videojuego no tiene imagen válida se muestra el ícono; las demás conservan su póster.

## 4 · Título, etiquetas y sinopsis (15 minutos)

### 4.1 · Destaca el título

Archivo: lib/movie_detail.dart.

Busca: Text(movie.title) de la Column principal.

Haz este cambio: Reemplaza ese Text por:

```dart
Text(
  movie.title,
  style: const TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
  ),
),
```

Explica: El título necesita mayor énfasis que el género o la descripción.

Comprueba: El nombre se distingue con tamaño y negrita.

### 4.2 · Separa el póster del título

Archivo: lib/movie_detail.dart.

Busca: El espacio entre el Center del póster y Text(movie.title).

Haz este cambio: Ajusta el SizedBox existente a 28 o inserta uno si no hay:

```dart
const SizedBox(height: 28),
```

Explica: SizedBox crea espacio vacío; evita sumar dos separadores en el mismo lugar.

Comprueba: Hay aire entre el póster y el nombre.

### 4.3 · Transforma el género en etiqueta

Archivo: lib/movie_detail.dart.

Busca: El Text(movie.genre) de la Column principal.

Haz este cambio: Reemplázalo por:

```dart
Chip(
  avatar: const Icon(Icons.local_movies_outlined, size: 18),
  label: Text(movie.genre),
  side: BorderSide.none,
  backgroundColor: colors.secondaryContainer,
),
```

Explica: Chip muestra un dato breve con fondo e ícono. No agregamos una acción a esta etiqueta.

Comprueba: El género aparece como una etiqueta.

### 4.4 · Prepara espacio para dos etiquetas

Archivo: lib/movie_detail.dart.

Busca: El Chip de género recién creado.

Haz este cambio: Envuélvelo en Wrap usando children (lista), no child. El Chip debe quedar como primer elemento. Agrega al Wrap:

```dart
spacing: 8,
runSpacing: 8,
```

Explica: Wrap puede distribuir sus hijos en varias líneas. spacing separa elementos y runSpacing separa filas.

Comprueba: La etiqueta sigue visible y el código compila con children: [...].

### 4.5 · Agrega el estado

Archivo: lib/movie_detail.dart.

Busca: children del Wrap, después del Chip de género.

Haz este cambio: Inserta este segundo Chip. Luego elimina el Text antiguo que mostraba Movie watched/Not watched yet o el estado equivalente fuera del Wrap:

```dart
Chip(
  avatar: Icon(
    movie.watched ? Icons.check_circle_outline : Icons.schedule,
    size: 18,
  ),
  label: Text(movie.watched ? 'Vista' : 'Pendiente por ver'),
  side: BorderSide.none,
  backgroundColor: colors.surfaceContainerHighest,
),
```

Explica: El ternario selecciona entre dos valores según watched; no modifica ese dato.

Comprueba: Se muestran dos etiquetas, sin repetir el estado abajo. En una ventana estrecha pueden separarse en dos líneas.

### 4.6 · Separa el título de las etiquetas

Archivo: lib/movie_detail.dart.

Busca: El SizedBox entre Text(movie.title) y Wrap.

Haz este cambio: Déjalo en 12; si no existe, insértalo:

```dart
const SizedBox(height: 12),
```

Explica: La separación menor mantiene relacionadas las etiquetas con el título.

Comprueba: No hay dos SizedBox consecutivos para la misma separación.

### 4.7 · Agrega el encabezado de sinopsis

Archivo: lib/movie_detail.dart.

Busca: El espacio entre Wrap y Text(movie.description).

Haz este cambio: Reemplaza el separador de ese lugar por estos tres elementos (si no hay separador, insértalos):

```dart
const SizedBox(height: 24),
const Text(
  'Sinopsis',
  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
),
const SizedBox(height: 12),
```

Explica: Damos nombre a la sección y distinguimos la separación entre secciones de la separación entre encabezado y contenido.

Comprueba: Sinopsis aparece una sola vez antes de la descripción.

### 4.8 · Facilita la lectura

Archivo: lib/movie_detail.dart.

Busca: Text(movie.description).

Haz este cambio: Reemplázalo por:

```dart
Text(
  movie.description,
  style: TextStyle(
    fontSize: 16,
    height: 1.6,
    color: colors.onSurfaceVariant,
  ),
),
```

Explica: height es un factor de altura de línea. onSurfaceVariant da menor énfasis que al título.

Comprueba: La descripción tiene líneas más separadas y se puede leer sin quedar pegada.

### 4.9 · Cierra el detalle con espacio

Archivo: lib/movie_detail.dart.

Busca: El final de children de la Column principal.

Haz este cambio: Después de la descripción deja un único:

```dart
const SizedBox(height: 24),
```

Explica: Este espacio pertenece al contenido que se desplaza.

Comprueba: Abre dos videojuegos, revisa todos sus datos y reduce el ancho de la ventana.

## 5 · Mejora MovieCard sin reemplazar la clase (15 minutos)

### 5.1 · Obtén los colores de la tarjeta

Archivo: lib/movie_card.dart.

Busca: La primera línea dentro de build, antes de return Card.

Haz este cambio: Agrega:

```dart
final colors = Theme.of(context).colorScheme;
```

Explica: Cada build tiene su propia variable colors; no se comparte la variable local del detalle.

Comprueba: El editor reconoce colors para los siguientes pasos; puede marcarla sin usar hasta 5.2.

### 5.2 · Cambia el exterior

Archivo: lib/movie_card.dart.

Busca: Las propiedades de Card, antes de child: InkWell.

Haz este cambio: Agrega o reemplaza estas propiedades; no dejes dos margin o dos shape:

```dart
margin: const EdgeInsets.only(bottom: 16),
elevation: 1,
color: isFavorite ? colors.primaryContainer : colors.surface,
clipBehavior: Clip.antiAlias,
shape: RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(18),
),
```

Explica: La tarjeta recibe isFavorite de la pantalla. El fondo lo representa, no lo guarda.

Comprueba: La favorita tiene fondo azul suave. La tarjeta normal mantiene otro fondo.

### 5.3 · Ajusta la miniatura

Archivo: lib/movie_card.dart.

Busca: Image.asset de la tarjeta y su ClipRRect.

Haz este cambio: Dentro de Image.asset cambia estas propiedades. En ClipRRect cambia el radio a BorderRadius.circular(12):

```dart
width: 72,
height: 108,
fit: BoxFit.cover,
```

Explica: 72 × 108 conserva proporción 2:3, como el póster del detalle.

Comprueba: Cada miniatura se ve vertical y redondeada.

### 5.4 · Agrega alternativa para la miniatura

Archivo: lib/movie_card.dart.

Busca: fit: BoxFit.cover, dentro de Image.asset.

Haz este cambio: Inserta debajo:

```dart
errorBuilder: (context, error, stackTrace) {
  return Container(
    width: 72,
    height: 108,
    color: colors.surfaceContainerHighest,
    child: const Icon(Icons.movie_outlined, size: 32),
  );
},
```

Explica: El tamaño alternativo coincide con la imagen para no cambiar el espacio de la tarjeta.

Comprueba: Las rutas inválidas muestran un ícono sin cambiar el ancho del texto.

### 5.5 · Destaca el nombre

Archivo: lib/movie_card.dart.

Busca: style de Text(movie.title).

Haz este cambio: Reemplaza solo su TextStyle:

```dart
style: TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.bold,
  color: isFavorite ? colors.onPrimaryContainer : colors.onSurface,
),
```

Explica: El color del texto se elige según el fondo. Conserva Expanded alrededor de la Column de textos.

Comprueba: El título destaca y puede ocupar varias líneas.

### 5.6 · Da menor énfasis al género

Archivo: lib/movie_card.dart.

Busca: Text(movie.genre).

Haz este cambio: Reemplázalo por:

```dart
Text(
  movie.genre,
  style: TextStyle(color: colors.onSurfaceVariant),
),
```

Explica: El género es información secundaria. Ajusta el SizedBox antes del género a 6 y el de después a 10.

Comprueba: Se distinguen nombre, género y estado sin quedar pegados.

### 5.7 · Agrega palabras al estado

Archivo: lib/movie_card.dart.

Busca: El Icon que representa movie.watched dentro de la Column de textos.

Haz este cambio: Reemplaza ese Icon por este Row. Si ya existe un texto de estado separado, elimínalo para no duplicarlo:

```dart
Row(
  children: [
    Icon(
      movie.watched ? Icons.check_circle_outline : Icons.schedule,
      size: 16,
      color: colors.primary,
    ),
    const SizedBox(width: 6),
    Expanded(child: Text(movie.watched ? 'Vista' : 'Pendiente')),
  ],
),
```

Explica: Ícono y palabra comunican juntos el estado; Expanded deja que el texto se ajuste al espacio.

Comprueba: Se ve Vista o Pendiente junto al ícono.

### 5.8 · Mueve la estrella

Archivo: lib/movie_card.dart.

Busca: El IconButton de favorito dentro de la Column de textos.

Haz este cambio: Corta el IconButton completo. Pégalo como último hijo del Row EXTERIOR, justo después del cierre de Expanded que contiene los textos. Si ya está allí, no lo muevas.

Explica: Row exterior: imagen → espacio de 12 → Expanded con textos → IconButton. Conserva InkWell(onTap: onTap) y Padding de 12.

Comprueba: Hay una sola estrella a la derecha; tocar la tarjeta sigue abriendo el detalle.

### 5.9 · Define el aspecto y la acción de la estrella

Archivo: lib/movie_card.dart.

Busca: El IconButton que acabas de mover.

Haz este cambio: Reemplaza solo ese botón:

```dart
IconButton(
  tooltip: isFavorite ? 'Quitar favorita' : 'Marcar como favorita',
  onPressed: onFavoriteTap,
  icon: Icon(isFavorite ? Icons.star : Icons.star_border),
  color: colors.primary,
),
```

Explica: El callback pertenece a la pantalla. Card sigue siendo StatelessWidget porque recibe los valores.

Comprueba: Marca, cambia y desmarca la favorita; solo cambia el estado y no se abre el detalle al tocar la estrella.

## 6 · Contenedor de la pantalla principal (5 minutos)

### 6.1 · Cambia fondo y título

Archivo: lib/movie_screen.dart.

Busca: Scaffold dentro de build.

Haz este cambio: Agrega backgroundColor y reemplaza solo appBar:

```dart
backgroundColor: Theme.of(context).colorScheme.surfaceContainerLowest,
appBar: AppBar(
  title: const Text('Mis videojuegos'),
  centerTitle: true,
),
```

Explica: La paleta es la misma del detalle. _buildBody sigue decidiendo qué contenido se muestra.

Comprueba: La barra dice Mis videojuegos y el fondo es suave.

### 6.2 · Limita y centra la lista

Archivo: lib/movie_screen.dart.

Busca: body: _buildBody(), en Scaffold.

Haz este cambio: Reemplaza únicamente esa propiedad:

```dart
body: SafeArea(
  child: Center(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 680),
      child: _buildBody(),
    ),
  ),
),
```

Explica: La lista tiene máximo 680, ligeramente más ancho que el detalle. No agregues otro scroll alrededor del ListView.

Comprueba: En escritorio la lista queda centrada y conserva su desplazamiento.

## 7 · Encabezado de la lista por partes (10 minutos)

### 7.1 · Da margen a la lista

Archivo: lib/movie_screen.dart.

Busca: return ListView.builder dentro del caso con datos de _buildBody.

Haz este cambio: Agrega esta propiedad al ListView:

```dart
padding: const EdgeInsets.all(20),
```

Explica: El padding es interior al área que se desplaza.

Comprueba: Las tarjetas ya no tocan los bordes de la pantalla.

### 7.2 · Reserva el índice cero

Archivo: lib/movie_screen.dart.

Busca: itemCount y el comienzo de itemBuilder de ese ListView.

Haz este cambio: Haz los tres cambios ANTES de ejecutar: cambia itemCount por la primera línea; agrega el if al inicio de itemBuilder; reemplaza final movie por la última línea. Conserva el resto de itemBuilder:

```dart
itemCount: movies.length + 1,

// Dentro de itemBuilder, antes de acceder a movies:
if (index == 0) {
  return const Text('Tu próxima videojuego');
}
final movie = movies[index - 1];
```

Explica: El código muestra dos ubicaciones. El encabezado usa índice 0 y movies[0] aparece en el índice visual 1. No cambies movie.id.

Comprueba: El encabezado aparece y ninguna videojuego desaparece ni se repite; no debe haber RangeError.

### 7.3 · Prepara el encabezado

Archivo: lib/movie_screen.dart.

Busca: return const Text del if (index == 0) recién agregado.

Haz este cambio: Reemplaza SOLO ese return:

```dart
return Padding(
  padding: const EdgeInsets.only(bottom: 24),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text('Tu próxima videojuego'),
    ],
  ),
);
```

Explica: El encabezado tiene espacio inferior y una Column para agregar más textos.

Comprueba: Se sigue viendo el encabezado y la lista sigue funcionando.

### 7.4 · Da jerarquía al encabezado

Archivo: lib/movie_screen.dart.

Busca: El Text Tu próxima videojuego dentro de la nueva Column.

Haz este cambio: Reemplaza ese Text:

```dart
const Text(
  'Tu próxima videojuego',
  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
),
```

Explica: 28 destaca el encabezado sin cambiar el título de AppBar.

Comprueba: El encabezado destaca sobre los títulos de las tarjetas.

### 7.5 · Agrega el contador

Archivo: lib/movie_screen.dart.

Busca: children de la Column del encabezado, después del título.

Haz este cambio: Inserta estos dos elementos:

```dart
const SizedBox(height: 8),
Text(
  '${movies.length} videojuegos para explorar',
  style: TextStyle(
    fontSize: 16,
    color: Theme.of(context).colorScheme.onSurfaceVariant,
  ),
),
```

Explica: La cantidad usa movies.length; no incluye el encabezado.

Comprueba: La cantidad coincide con las videojuegos visibles en la lista completa.

### 7.6 · Agrega una instrucción

Archivo: lib/movie_screen.dart.

Busca: children del encabezado, después del contador.

Haz este cambio: Inserta:

```dart
const SizedBox(height: 8),
const Text(
  'Toca una tarjeta para ver más o marca tu favorita con la estrella.',
),
```

Explica: La instrucción explica las dos acciones reales. El encabezado se desplaza junto con las tarjetas.

Comprueba: Desplázate hasta la última videojuego y prueba su detalle.

## 8 · Error y vacío sin bloques grandes (10 minutos)

### 8.1 · Prepara el mensaje de error

Archivo: lib/movie_screen.dart.

Busca: Dentro de if (snapshot.hasError), el return con el mensaje antiguo.

Haz este cambio: Reemplaza SOLO ese return; conserva el if y todo lo que viene después:

```dart
return Center(
  child: Padding(
    padding: const EdgeInsets.all(24),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('No pudimos cargar las videojuegos'),
      ],
    ),
  ),
);
```

Explica: mainAxisSize.min hace que la Column ocupe solo su contenido y Center pueda centrarlo.

Comprueba: El código compila. El mensaje se verá cuando haya un fallo; no cambies la URL funcional solo para verlo.

### 8.2 · Agrega ícono al error

Archivo: lib/movie_screen.dart.

Busca: children de la Column del error, antes del Text.

Haz este cambio: Inserta:

```dart
const Icon(Icons.cloud_off_outlined, size: 48),
const SizedBox(height: 16),
```

Explica: El ícono refuerza el mensaje y SizedBox deja separación.

Comprueba: No se duplican children ni Column.

### 8.3 · Destaca el mensaje

Archivo: lib/movie_screen.dart.

Busca: Text No pudimos cargar las videojuegos.

Haz este cambio: Reemplaza ese Text:

```dart
const Text(
  'No pudimos cargar las videojuegos',
  textAlign: TextAlign.center,
  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
),
```

Explica: textAlign centra las líneas del mensaje cuando no cabe en una sola.

Comprueba: El mensaje puede ocupar varias líneas dentro del Padding.

### 8.4 · Agrega Reintentar

Archivo: lib/movie_screen.dart.

Busca: children del error, después del Text.

Haz este cambio: Inserta:

```dart
const SizedBox(height: 16),
ElevatedButton.icon(
  onPressed: () {
    setState(() {
      _futureMovies = _service.getMovies();
    });
  },
  icon: const Icon(Icons.refresh),
  label: const Text('Reintentar'),
),
```

Explica: Asigna una nueva solicitud al Future que observa la UI. Usa llaves en setState: la forma de flecha con esta asignación devuelve un Future y Flutter la rechaza.

Comprueba: Ante un error real o simulado, Reintentar vuelve a consultar y muestra loading. No uses fetchMovies local.

### 8.5 · Prepara el estado vacío

Archivo: lib/movie_screen.dart.

Busca: El return dentro de if (movies.isEmpty).

Haz este cambio: Reemplaza SOLO ese return por el siguiente. Conserva final movies = snapshot.data ?? []; antes del if:

```dart
return const Center(
  child: Padding(
    padding: EdgeInsets.all(24),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Todavía no hay videojuegos disponibles'),
      ],
    ),
  ),
);
```

Explica: Vacío significa que no hay elementos; es diferente a que la consulta haya fallado.

Comprueba: Solo queda una declaración de movies y se conserva el ListView posterior.

### 8.6 · Agrega ícono al vacío

Archivo: lib/movie_screen.dart.

Busca: children de la Column del estado vacío, antes del Text.

Haz este cambio: Inserta:

```dart
Icon(Icons.movie_outlined, size: 48),
SizedBox(height: 16),
```

Explica: El const exterior ya cubre estos widgets; no necesitan repetirlo.

Comprueba: El estado vacío tiene un ícono diferente al error.

### 8.7 · Ajusta el texto del vacío

Archivo: lib/movie_screen.dart.

Busca: Text Todavía no hay videojuegos disponibles.

Haz este cambio: Reemplaza solo ese Text:

```dart
Text(
  'Todavía no hay videojuegos disponibles',
  textAlign: TextAlign.center,
  style: TextStyle(fontSize: 18),
),
```

Explica: Centramos el texto y usamos un tamaño legible.

Comprueba: Con una respuesta de prueba [] se muestra el vacío. Restaura los datos de prueba al terminar.

## 9 · Comprobación final (5 minutos)

1. Lista azul, centrada y con el contador correcto.
2. Todas las videojuegos aparecen una sola vez, incluida la última.
3. Dos videojuegos distintas abren su propio detalle.
4. La estrella marca, cambia y desmarca una única favorita.
5. La favorita tiene fondo destacado y la estrella se mantiene a la derecha.
6. En una ventana pequeña se puede desplazar el contenido y las etiquetas pasan de línea.
7. Las imágenes válidas se ven; el ícono alternativo no sustituye la revisión de rutas.
8. Ejecuta flutter analyze y revisa cualquier aviso relacionado con los cambios.

Para diseño, usa hot reload. Si cambias initState o la URL, usa hot restart. La persistencia se comprueba por separado manteniendo el mismo almacenamiento del navegador.

## Pausas recomendadas para explicar

Después de 3.5: dibuja Center → ConstrainedBox → Card → AspectRatio → Image y pide que expliquen cada capa.

Después de 5.9: pregunta por qué la tarjeta puede ser StatelessWidget si su estrella cambia. Recibe isFavorite; la pantalla controla el estado.

Después de 7.2: escribe en el tablero «índice visual 0 = encabezado; 1 = movies[0]; 2 = movies[1]». No continúes hasta que se entienda el desplazamiento de índices.

Después de 8.4: sigue el flujo botón → nueva solicitud → _futureMovies → FutureBuilder.

## Errores frecuentes

- Propiedad repetida: reemplaza margin, style o padding existentes; no agregues otro con el mismo nombre.
- colors no existe: decláralo dentro del build del archivo correspondiente.
- Error con const: no pongas const en bloques que usan colors o datos de movie.
- RangeError: revisa los tres cambios de 7.2 juntos.
- Dos estrellas o dos textos de estado: se agregó la nueva versión sin retirar o mover la anterior.
- El título desborda: conserva Expanded alrededor de la Column de textos del Row exterior.
- Wrap da error: usa children con una lista; no tiene child.
- Bordes rectos en el póster: verifica clipBehavior del Card.
- Error al reintentar: usa setState con llaves y modifica _futureMovies.
- Sigue fallando la API: esta guía no modifica el servicio; diagnostica la conexión aparte.

## Preguntas para cerrar

1. ¿Qué diferencia hay entre margin y padding?
2. ¿Qué resuelve Wrap que no resuelve un Row?
3. ¿Cómo se relacionan AspectRatio y BoxFit.cover?
4. ¿Por qué se resta uno al índice de movies y no al id?
5. ¿Qué color cambia al seleccionar una favorita y quién decide su valor?
6. ¿Por qué basta modificar la semilla del tema para cambiar varios componentes?

## Archivos de referencia

Los archivos lib/main.dart, lib/movie_detail.dart, lib/movie_card.dart y lib/movie_screen.dart del proyecto contienen el resultado visual de referencia. Consulta el archivo completo solo para revisar el anidamiento; durante la clase aplica un paso a la vez.
