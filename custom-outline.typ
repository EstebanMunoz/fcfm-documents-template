// Función que genera un outline de acuerdo al target entregado
#let custom-outline(
  title: auto,
  target: heading.where(outlined: true)
) = context {
  
  // Busca todos los elementos que concuerden con el target
  let queried = query(selector(target))

  // Si no existe ningún elemento, outline no entrega nada y no se continua con la ejecución
  if queried.len() == 0 {return}

  // Tipo de datos que se están buscando
  let queried-type = queried.at(0).func()
  
  // En caso de buscar headings, se usan algunas variables extras para ese caso particular
  let (depths, max-depth) = if queried-type == heading {
    (
      queried.map(h => h.depth),
      calc.max(..queried.map(h => h.depth))
    )
  } else {(none, none)}

  // Body de cada elemento encontrado
  let bodies = if queried-type == heading {
    queried.map(h => h.body)
  } else {
    queried.map(q => q.caption.body)
  }
  
  // Número de columnas de la grilla
  let num-cols = if queried-type == heading {
    max-depth + 2
  } else {
    3
  }
  
  // Array con los numberings de todos los elementos encontrados
  let queried-numbering = queried.map(q => {
    if q.numbering != none {
      numbering(q.numbering, ..counter(target).at(q.location()))
    }
  })

  // Array con los números de página de los elementos encontrados
  let page-numbers = queried.map(q => {
    let loc = q.location()
    numbering(loc.page-numbering(), ..counter(page).at(loc))
  })

  // Ancho máximo de un numering antes de hacer un merge con el contenido
  let max-numb-width = 43pt

  // Función auxiliar que maneja el llenado de cada celda
  let populate-cells() = {

    // Array que contendrá todas las celdas a utilizar en la en grilla
    let cells = ()

    // Por cada elemento encontrado se agrega una fila
    for (i, body) in bodies.enumerate() {

      // Si el tipo de dato es un heading, se necesita saber el nivel que posee
      let current-depth = if queried-type == heading {depths.at(i)}

      // Numbering y número de página del elemento
      let current-numbering = queried-numbering.at(i)
      let current-page = page-numbers.at(i)

      // Llenado entre el contenido y el número de página. En caso de ser un heading de nivel 1 el valor en `none`
      let fill = if current-depth != 1 {box(width: 1fr, repeat[~~.])}

      // Contenido que se usará en el outline
      let content = [#body #fill]

      // Inset que se agreagrá a los heading de nivel 1
      let inset = auto

      // Los headings de nivel 1 tienen su información en negrita
      if current-depth == 1 {
        content = strong(content)
        current-numbering = strong(current-numbering)
        current-page = strong(current-page)
        inset = (top: 10pt)
      }

      // Si un numbering excede el límite, se hace un merge con el contenido
      let exceeds-numb-width = measure(current-numbering).width > max-numb-width
      if exceeds-numb-width {
        content = [#current-numbering #h(5pt) #content]
      }

      // Se guarda el valor de si un elemento no posee una celda para numbering
      let has-no-number-cell = queried-numbering.at(i) == none or exceeds-numb-width

      // Cantidad de columnas que ocupa el contenido
      let colspan = if queried-type == heading {
        max-depth - current-depth + 1 + int(has-no-number-cell)
      } else {
        1 + int(has-no-number-cell)
      }

      // Columna en la que se coloca el numbering
      let numb-x-pos = if queried-type == heading {
        current-depth - 1
      } else {
        0
      }
      
      // Columna en la que comienza en contenido
      let x-pos = if queried-type == heading {
        current-depth - int(has-no-number-cell)
      } else {
        1 - int(has-no-number-cell)
      }

      // Si el elemento tiene una celda para numbering, se agrega dicho numbering a la grilla
      if not has-no-number-cell {
        cells.push(grid.cell(y: i, x: numb-x-pos, inset: inset, current-numbering))
      }

      // Se agrega la celda de contenido al array
      cells.push(grid.cell(y: i, colspan: colspan, x: x-pos, inset: inset, content))

      // Se agrega la celda de número de página al array
      cells.push(grid.cell(y: i, x: num-cols - 1, align: right + bottom, inset: inset, current-page))
    }

    // Se retorna el array de celdas
    return cells
  }

  // Contenido entregado por el outline: un heading y una grilla
  heading(numbering: none)[#title]
  
  grid(
    columns: (auto,) * (num-cols - 1) + (1fr,), 
    column-gutter: (10pt,) * (num-cols - 2) + (20pt,),
    row-gutter: 6pt,
    ..populate-cells(),
  )
}
