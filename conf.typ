#import "custom-outline.typ": custom-outline
#import "utils.typ": grid-header, grid-footer, subfigures, today

// Document types
#import "document-types/report.typ": report
#import "document-types/assignment.typ": assignment
#import "document-types/auxiliary.typ": auxiliary

// Circetz library
#import "/circetz/lib.typ": components, show-anchor

// Public packages
#import "@preview/codly:1.3.0": *

#let conf(
  document-type: "report",
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
  course-name: none,
  doc
) = {
  // Enum all the document types available in the template
  let document-types = (
    "report": report,
    "assignment": assignment,
    "auxiliary": auxiliary
  )

  let doc-type-args = (
    is-subtitle-in-header: is-subtitle-in-header,
    title: title,
    subtitle: subtitle,
    subject: subject,
    students: students,
    teachers: teachers,
    auxiliaries: auxiliaries,
    assistants: assistants,
    lab-assistants: lab-assistants,
    semester: semester,
    date: date,
    place: place,
    university: university,
    faculty: faculty,
    department: department,
    logo: logo,
    course-code: course-code,
    course-name: course-name)
  let resolve-doc-type = document-types.at(document-type)
  let document-values = resolve-doc-type(..doc-type-args)

  // Seteo general del documento
  set document(title: title, author: students)
  

  set page(
    "us-letter",
    margin: document-values.page-margin,
    header: grid-header(document-values.left-side-header, document-values.right-side-header),
    footer: grid-footer(document-values.left-side-footer, document-values.right-side-footer),
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

  // Introduce la portada
  document-values.title-content

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
