#import "@preview/tablex:0.0.5": tablex, rowspanx, colspanx

#let title-page(
  title: none,
  subject: none,
  students: (),
  teachers: (),
  auxiliaries: (),
  assistants: (),
  lab-assistants: (),
  semester: none,
  due-date: none,
  location: none,
  university: none,
  faculty: none,
  department: none,
  logo: none
) = {
  let first-page-header = [
    #set align(left)
    #set text(11pt)
    #stack(
      dir: ttb,
      spacing: 4pt,
      [#stack(
        dir: ltr,
        spacing: 1fr,
        [#stack(
          dir: ttb,
          spacing: 6pt,
          [#university],
          [#faculty],
          [#department]
        )],
        logo
      )],
      [#line(length: 100%, stroke: 0.4pt)]
    )
  ]

  set page(margin: (top: 4.46cm, bottom: 2.7cm), header: first-page-header, footer: "")
  align(center + horizon, text(24.24pt)[
    #title \
    #text(12pt)[#subject]
  ])


  align(right + bottom)[
    #block(width: 260pt)[
      #tablex(
        columns: (75pt, auto),
        row-gutter: -2pt,
        auto-lines: false,

        {
          let num-int = students.len()
          if num-int == 0 {()}
          else if num-int == 1 [Integrante:]
          else {rowspanx(num-int)[Integrantes:]}
        },
        ..students,

        {
          let num-prof = teachers.len()
          if num-prof == 0 {()}
          else if num-prof == 1 [Profesor:]
          else {rowspanx(num-prof)[Profesores:]}
        },
        ..teachers,
        
        {
          let num-aux = auxiliaries.len()
          if num-aux == 0 {()}
          else if num-aux == 1 [Auxiliar:]
          else {rowspanx(num-aux)[Auxiliares:]}
        },
        ..auxiliaries,
        
        {
          let num-ayu = assistants.len()
          if num-ayu == 0 {()}
          else if num-ayu == 1 [Ayudante:]
          else {rowspanx(num-ayu)[Ayudantes:]}
        },
        ..assistants,

        {
          let num-lab = lab-assistants.len()
          if num-lab == 0 {()}
          else if num-lab == 1 [Ayudante de \ laboratorio:]
          else {rowspanx(num-lab)[Ayudantes de  laboratorio:]}
        },
        ..lab-assistants,

        if semester != none {
          [Semestre:]
        },
        semester,

        colspanx(2)[#v(5pt)],

        if due-date != none {
          colspanx(2)[Fecha de entrega: #due-date]
        },
        
        if location != none {
          colspanx(2)[#location]
        }
      )
    ]
  ]
  counter(page).update(0)
}

