#let place-people-in-grid(people, single-people-str, multiple-people-str) = {
  let num-people = people.len()
  if num-people == 0 {()}
  else if num-people == 1 {(single-people-str,)}
  else {(grid.cell(rowspan: num-people, multiple-people-str),)}
}

#let title-page(
  title: none,
  subject: none,
  students: (),
  teachers: (),
  auxiliaries: (),
  assistants: (),
  lab-assistants: (),
  semester: none,
  date: none,
  place: none,
  university: none,
  faculty: none,
  department: none,
  logo: none
) = {
  let first-page-header = [
    #set align(left)
    #set text(11pt)
    #grid(
      align: (left + bottom, right),
      columns: (auto, auto),
      column-gutter: 1fr,
      inset: (bottom: 4.5pt),
      [
        #university \
        #faculty \
        #department
      ],
      logo,
      grid.hline(stroke: 0.4pt)
    )
  ]

  set page(margin: (top: 4.46cm, bottom: 2.7cm), header: first-page-header, footer: "")
  align(center + horizon, text(24.24pt)[
    #title \
    #text(12pt)[#subject]
  ])


  align(right + bottom)[
    #block(width: 270pt)[
      #grid(
        columns: (75pt, auto),
        align: top + left,
        row-gutter: 7pt,
        
        ..place-people-in-grid(students, "Integrante:", "Integrantes:"),
        ..students,

        ..place-people-in-grid(teachers, "Profesor:", "Profesores:"),
        ..teachers,

        ..place-people-in-grid(auxiliaries, "Auxiliar:", "Auxiliares:"),
        ..auxiliaries,

        ..place-people-in-grid(assistants, "Ayudante:", "Ayudantes:"),
        ..assistants,

        ..place-people-in-grid(lab-assistants, [Ayudante de \ laboratorio:], [Ayudantes de \ laboratorio:]),
        ..lab-assistants,

        ..if semester != none {(
          grid.cell("Semestre:"),
          grid.cell(semester)
        )},

        grid.cell(colspan: 2, v(5pt)),
        
        ..if date != none {(
          grid.cell(colspan: 2)[Fecha de entrega: #date],
        )},

        ..if place != none {(
          grid.cell(colspan: 2, place),
        )}
      )
    ]
  ]
  counter(page).update(0)
}

