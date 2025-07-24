#import "../utils.typ": grid-header

#let place-people-in-grid(people, single-people-str, multiple-people-str) = {
  let num-people = people.len()
  if num-people == 0 {()}
  else if num-people == 1 {(single-people-str,)}
  else {(grid.cell(rowspan: num-people, multiple-people-str),)}
}

#let report(
  is-subtitle-in-header: false,
  title: none,
  subtitle: none,
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
  logo: none,
  course-code: none,
  course-name: none
) = {
  let include-title-page = true

  let left-side-header = smallcaps(
    if is-subtitle-in-header { subtitle } else { title }
  )

  let right-side-header = context {
    let headings = query(
      selector(heading.where(level: 1))
    ).filter(it => it.location().page() <= here().page())
  
    let target-header = if headings.len() > 0 {
      headings.last().body
    }
    emph(target-header)
  }

  let left-side-footer = emph[#course-code #course-name]

  let right-side-footer = context counter(page).display(here().page-numbering())

  let page-margin = (top: 3.37cm, bottom: 3.07cm, right: 2.54cm, left: 2.54cm)

  let title-page = {
    let left-side-header = [
      #university \
      #faculty \
      #department
    ]

    let right-side-header = logo

    set page(
      margin: (top: 4.46cm, bottom: 2.7cm),
      header: grid-header(left-side-header, right-side-header),
      footer: ""
      )
    
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

  return (
    "left-side-header": left-side-header,
    "right-side-header": right-side-header,
    "left-side-footer": left-side-footer,
    "right-side-footer": right-side-footer,
    "page-margin": page-margin,
    "title-content": title-page
  )
}
