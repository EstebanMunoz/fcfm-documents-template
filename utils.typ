#import "@preview/subpar:0.2.2"


#let grid-header(left-side, right-side) = grid(
  align: (left + bottom, right + bottom),
  columns: (auto, auto),
  column-gutter: 1fr,
  inset: (bottom: 4.5pt),
  left-side,
  right-side,
  grid.hline(stroke: 0.4pt) 
)

#let grid-footer(left-side, right-side) = grid(
  align: (left + top, right + top),
  columns: (auto, auto),
  column-gutter: 1fr,
  inset: (top: 4.5pt),
  grid.hline(stroke: 0.4pt),
  left-side,
  right-side
)

// Agrega bloques de colores
#let activity-counter = counter("activity")

#let activity(fill: rgb("#E5F0F4"), activity-name: none, content) = {
  activity-counter.step()
  block(
    fill: fill,
    stroke: (left: rgb("#6EAAC3") + 3pt),
    // stroke: (left: fill.darken(20%) + 2pt),
    width: 100%,
    inset: 10pt
  )[
    #smallcaps[
      *Actividad #context activity-counter.display()* #sym.space #activity-name
    ]

    #content
  ]
}

// Crea función para subfigures
#let subfigures = subpar.grid.with(
  gap: 1em,
  numbering-sub-ref: "1.a",
)


// Misc: configuraciones extra
#let months = ("January": "Enero", "February": "Febrero", "March": "Marzo", "April": "Abril", "May": "Mayo", "June": "Junio", "July": "Julio", "August": "Agosto", "September": "Septiembre", "October": "Octubre", "November": "Noviembre", "December": "Diciembre")

#let month = datetime.today().display("[month repr:long]")
#let today = datetime.today().display("[day] de [month repr:long] de [year]").replace(month, months.at(month))