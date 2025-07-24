#let assignment(
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

  let place-people(people, single-people-str, multiple-people-str) = {
    let num-people = people.len()
    if num-people == 0 {()}

    let identifier = if num-people == 1 {
      single-people-str
    } else {
      multiple-people-str
    }

    return [*#identifier* #people.join(", ")]  
  }

  let title-content = align(center)[
    #text(size: 20pt)[#title] \
    #if subject != none { text(size: 14pt)[#subject] } else { none }
    
    #place-people(teachers, "Profesor:",   "Profesores:")
    #place-people(auxiliaries, "Auxiliar:", "Auxiliares:") \
    #place-people(assistants, "Ayudante:", "Ayudantes:")

    *Fecha de entrega:* #date
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
