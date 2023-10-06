// Definir indentación en tabla de contenidos
#let indent-space = 5pt

#let indentation(n) = {
  let nums = ()
  for i in range(n) {
    nums.push([1.] * (i+1))
  }

  let body = if nums.len() == 1 {
    strong(nums.at(0)) + h(indent-space) + sym.space
  } else if nums.len() > 1 {
    strong(nums.at(0)) + h(indent-space) + sym.space + nums.slice(1).join(sym.space) + sym.space
  }
  
  return hide[#body]
}

// Definir ancho del counter y número de página en el índice
#let outline-counter-width = state("outline-counter-width", 0pt)
#let outline-page-number-width = state("outline-page-number-width", 0pt)


// Header
#let current-header = state("current-header", "")
#let get-heading-for-header() = {
  locate(loc => {
    let next-headings = query(
      selector(heading.where(level: 1)).after(loc),
      loc
    ).filter(head => {head.location().page() == loc.page()})

    let last-heading = if next-headings.len() != 0 {
      next-headings.last()
    }

    if last-heading != none {
      current-header.update(last-heading.body)
    }
  })
  current-header.display()
}


#let header-content() = [
  #locate(loc => [
  #set align(left)
  #set text(11pt)
  #stack(
    dir: ttb,
    spacing: 4.5pt,
    stack(
      dir: ltr,
      spacing: 1fr,
      [#get-heading-for-header()],
      [#numbering(loc.page-numbering(), ..counter(page).at(loc))]
    ),
    [#line(length: 100%, stroke: 0.4pt)]
  )
  ])
]


// Footer
#let footer-content(title, course-code, course-name) = [
  #locate(loc => [
  #set align(left)
  #set text(11pt)
  #stack(
    dir: ttb,
    spacing: 4.5pt,
    [#line(length: 100%, stroke: 0.4pt)],
    [#stack(
     dir: ltr,
     spacing: 1fr,
     [#emph(title)],
     [#emph([#course-code #course-name])]
    )]
  )
  ])
]


// Random: Escribir latex en Typst. Falta referenciar al autor
#let latex = text([L#h(-0.35em)#text(size: 0.725em, baseline: -0.25em)[A]#h(-0.125em)T#h(-0.175em)#text(baseline: 0.225em)[E]#h(-0.125em)X])


// Definición de Subfigure
#let subfigure = figure.with(
  kind: "subfigure",
  supplement: "",
  numbering: "a"
)


// Definición de Apéndice
#let letters = ("A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z")

#let appendix = heading.with(
  supplement: [Anexo],
  numbering: (first, ..next) => {
    let numb = letters.at(first - 1) + "."
    if next.pos().len() == 0 {return "Anexo " + numb}
    return numb + next.pos().map(str).join(".") + "."
  }
)


// datetime.today() en español
#let en2es-month = ("January": "Enero", "February": "Febrero", "March": "Marzo", "April": "Abril", "May": "Mayo", "June": "Junio", "July": "Julio", "August": "Agosto", "September": "Septiembre", "October": "Octubre", "November": "Noviembre", "December": "Diciembre")

#let month = datetime.today().display("[month repr:long]")
#let today = datetime.today().display("[day] de [month repr:long] de [year]").replace(month, en2es-month.at(month))
