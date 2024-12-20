#import "title-page.typ": title-page
#import "custom-outline.typ": custom-outline

#import "@preview/codly:1.0.0": *
#import "@preview/subpar:0.1.1"

#let conf(
  include-title-page: true,
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

  let get-subject-for-header() = {
    if is-subtitle-in-header { return subtitle }
    return title
  }

  // Seteo general del documento
  set document(title: title, author: students)
  
  set page(
    "us-letter",
    margin: (top: 3.37cm, bottom: 3.07cm, right: 2.54cm, left: 2.54cm),
    header: [#stack(
      dir: ttb,
      spacing: 4.5pt,
      [#smallcaps(get-subject-for-header()) #h(1fr) #emph(get-heading-for-header())],
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
  show figure.where(kind: math.equation): set math.equation(numbering: "(1)")
  // set math.equation(numbering: "(1)")
  set text(size: 11pt, font: "New Computer Modern", lang: "es")
  set raw(
    syntaxes: (
      "template/assets/syntaxes/Arduino.sublime-syntax",
      "template/assets/syntaxes/Cython.sublime-syntax",
    )
  )
  show raw: set text(size: 11pt, font: "New Computer Modern Mono")
  show bibliography: set par(justify: false)
  set bibliography(style: "institute-of-electrical-and-electronics-engineers")
  // show link: it => { if type(it) == str { set text(fill: blue) } else { it } }


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


  // Modifica apariencia de índices
  show outline: it => custom-outline(title: it.title, target: it.target)


  // Modifica apariencia de tablas
  show table.cell.where(y: 0): strong
  set table(
    stroke: (_, y) => (
      left: 0pt,
      right: 0pt,
      top: if y == 1 { 1pt } else { 0pt },
      bottom: 1pt
    ),
    inset: (x, y) => if y == 0 { 8pt } else { 5pt }
  )


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
    cpp: (
      name: "C++",
      icon: icon("template/assets/logos/cpp.svg"),
      color: rgb("#00599C")
    ),
    arduino: (
      name: "Arduino",
      icon: icon("template/assets/logos/arduino.svg"),
      color: rgb("#00878F")
    ),
    cython: (
      name: "Cython",
      icon: icon("template/assets/logos/cython.svg"),
      color: rgb("#FFC331")
    ),
    latex: (
      name: "LaTeX",
      icon: icon("template/assets/logos/latex.svg"),
      color: rgb("#008080")
    )
  ))
  

  // Figuras pueden ser contenidas en múltiples páginas
  show figure: set block(breakable: true)

  
  // Comienzo del documento
  doc
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
