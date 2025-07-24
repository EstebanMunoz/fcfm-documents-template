#let auxiliary(
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
  let include-title-page = false

  let left-side-header = [
    #university \
    #department \
    #course-code #course-name
  ]

  let right-side-header = logo

  let left-side-footer = none

  let right-side-footer = context counter(page).display(here().page-numbering())

  let page-margin = (top: 4.46cm, bottom: 2.7cm, right: 2.54cm, left: 2.54cm)

  let place-people-in-grid(people, single-people-str, multiple-people-str) = {
    let num-people = people.len()
    if num-people == 0 {()}
    else if num-people == 1 {(single-people-str,)}
    else {(grid.cell(rowspan: num-people, multiple-people-str),)}
  }

  let title-content = align(center)[
    #heading(numbering: none, title)
    #date
  
    #grid(
      columns: (auto, auto),
      align: (top + left, top + left),
      column-gutter: 10pt,
      row-gutter: 7pt,
      
      ..place-people-in-grid(teachers, "Profesor:", "Profesores:"),
      ..teachers,
  
      ..place-people-in-grid(auxiliaries, "Auxiliar:", "Auxiliares:"),
      ..auxiliaries
    )
  ]

  return (
    "left-side-header": left-side-header,
    "right-side-header": right-side-header,
    "left-side-footer": left-side-footer,
    "right-side-footer": right-side-footer,
    "page-margin": page-margin,
    "title-content": title-content
  )
}
