#import "title-page.typ": title-page
#import "custom-outline.typ": custom-outline

#import "@preview/codly:0.2.0": *

#let conf(
  include-title-page: true,
  title: none,
  subject: none,
  students: (),
  teachers: (),
  auxiliaries: (),
  assistants: (),
  lab-assistants: (),
  semester: none,
  due-date: none,
  place: none,
  university: none,
  faculty: none,
  department: none,
  logo: none,
  course-code: none,
  course-name: none,
  doc
) = {
  // Función que entrega el heading que debe ir en el header
  let get-heading-for-header() = context {
    let headings = query(
      selector(heading.where(level: 1))
    ).filter(it => it.location().page() <= here().page())
  
    return if headings.len() > 0 {
      headings.last().body
    }
  }

  // Seteo general del documento
  set document(title: title, author: students)
  
  set page(
    "us-letter",
    margin: (top: 3.37cm, bottom: 3.07cm, right: 2.54cm, left: 2.54cm),
    header: [#stack(
      dir: ttb,
      spacing: 4.5pt,
      [#smallcaps(title) #h(1fr) #emph(get-heading-for-header())],
      line(length: 100%, stroke: 0.4pt)
    )],
    footer: [#stack(
      dir: ttb,
      spacing: 4.5pt,
      line(length: 100%, stroke: 0.4pt),
      [#emph([#course-code #course-name]) #h(1fr) #context counter(page).display(here().page-numbering())]
    )],
    numbering: "1"
  )
  
  set par(leading: 0.55em, justify: true)
  set heading(numbering: "1.")
  set text(size: 11pt, font: "New Computer Modern", lang: "es")
  set raw(syntaxes: "template/assets/syntaxes/Arduino.sublime-syntax")
  show raw: set text(size: 11pt, font: "New Computer Modern Mono")
  show bibliography: set par(justify: false)
  set bibliography(style: "institute-of-electrical-and-electronics-engineers")


  // Introduce la portada
  if include-title-page {
    title-page(
      title: title,
      subject: subject,
      students: students,
      teachers: teachers,
      auxiliaries: auxiliaries,
      assistants: assistants,
      lab-assistants: lab-assistants,
      semester: semester,
      due-date: due-date,
      place: place,
      university: university,
      faculty: faculty,
      department: department,
      logo: logo
    )
  }

  
  // Resize de títulos y subtítulos
  let font-sizes = (17.28pt, 14.4pt, 12pt)
  show heading: it => block(above: 1.4em, below: 1em)[
    #let new-size = font-sizes.at(it.level - 1, default: 11pt)
    #set text(size: new-size)
    #if it.numbering == none {
      it.body
    } else [
      #context counter(it.func()).display() #h(10pt) #it.body
    ]
  ]

  
  // Referencia de forma apropiada
  show ref: it => {
    let el = it.element
    if el != none {
      if el.func() == figure and el.kind == "subfigure" {
        let fig-counter = counter(figure.where(kind: image)).at(el.location()).first()
        let subfig-numbering = numbering(el.numbering, el.counter.at(el.location()).first())
        link(el.location(), [#el.supplement #fig-counter.#subfig-numbering])
      } else if el.func() == heading and el.supplement == [Anexo] and el.level == 1 {
        numbering(el.numbering, ..counter(heading).at(el.location()))
      } else {
        it
      }
    } else {
      it
    }
  }


  // Counter para subfigures
  show figure.where(kind: "subfigure"): set figure(supplement: "Figura", numbering: "a")

  show figure.caption.where(kind: "subfigure"): it => [
    (#it.counter.display()) #it.body
    #v(5pt)
  ]
  
  // Actualiza el contador de subfigure de forma apropiada
  show figure.where(kind: image): it => {
    counter(figure.where(kind:"subfigure")).update(0)
    it
  }


  // Modifica apariencia de índices
  show outline: it => custom-outline(title: it.title, target: it.target)


  // Usa el paquete Codly para modificar la apariencia de códigos
  show figure.where(kind: raw): set figure(supplement: "Código")
  
  let icon(codepoint) = {
    box(
      height: 0.8em,
      baseline: 0.05em,
      image(codepoint)
    )
    h(0.1em)
  }

  show: codly-init.with()
  codly(languages: (
    python: (
      name: "Python",
      icon: icon("template/assets/logos/python.svg"),
      color: rgb("#FFC331")
    ),
    rust: (
      name: "Rust",
      icon: icon("template/assets/logos/rust.svg"),
      color: rgb("#CE412B")
    ),
    arduino: (
      name: "Arduino",
      icon: icon("template/assets/logos/arduino.svg"),
      color: rgb("#00878F")
    )
  ))
  

  // Figuras pueden ser contenidas en múltiples páginas
  show figure: set block(breakable: true)

  
  // Comienzo del documento
  doc
}
