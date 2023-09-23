#import "definitions.typ": *
#import "title-page.typ": title-page

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
  location: none,
  university: none,
  faculty: none,
  department: none,
  logo: none,
  course-code: none,
  course-name: none,
  doc
) = {

  // Seteo general del documento
  set document(title: title, author: students)
  set page("us-letter", margin: (top: 3.37cm, bottom: 3.07cm, right: 2.54cm, left: 2.54cm), header: header-content(), footer: footer-content(title, course-code, course-name), numbering: "1")
  set par(leading: 0.55em, justify: true)
  set heading(numbering: "1.")
  set text(size: 11pt, font: "New Computer Modern", lang: "es")
  show raw: set text(font: "New Computer Modern Mono")


  // Resize de títulos y subtítulos
  let font-sizes = (17.28pt, 14.4pt, 12pt)
  show heading: it => block(above: 1.4em, below: 1em)[
    #let new-size = font-sizes.at(it.level - 1, default: 11pt)
    #set text(size: new-size)
    #locate(loc => [
      #if it.numbering == none {it.body
    } else [#numbering(it.numbering, ..counter(heading).at(loc)) #h(10pt) #it.body]
    ])
  ]


  // Actualiza el contador de subfigure de forma apropiada
  show figure.where(kind:image): it => {
    counter(figure.where(kind:"subfigure")).update(0)
    it
  }


  // Referencia de forma apropiada
  show ref: it => {
    let el = it.element
    if el != none {
      if el.func() == figure and el.kind == "subfigure" {
        let fig-counter = counter(figure.where(kind: image)).at(el.location()).first()
        let subfig-numbering = numbering(el.numbering, el.counter.at(el.location()).first())
        [Figura #fig-counter.#subfig-numbering]
      } else if el.func() == heading and el.supplement == [Anexo] and el.level == 1 {
        numbering(el.numbering, ..counter(heading).at(el.location()))
      } else {
        it
      }
    }
  }


  // Muestra el caption correcto de subfigures
  show figure.where(kind:"subfigure"): it => align(center)[
    #it.body
    #if it.caption != none {
      v(-5pt)
      [(#it.counter.display(it.numbering)) #it.caption.body]
    }
    #v(5pt)
  ]


  // Modifica el entorno de Códigos
  show raw.where(block: true): (it) => style((st) => {
    let leading = 0.7em
    let gutter = 2 * leading
    let inset = (x: leading * 1.5, y: leading * 0.75)
    let stroke = luma(80%) + 0.75pt
    let num-style(n) = text(0.8em, str(n))
    let fill(i) = luma(if calc.even(i) { 98% } else { 95% })

    let lines = it.text.trim().split("\n")
    let n-lines = calc.max(lines.len(), 1)
    let leaded = { set par(leading: leading); it }
    let line-h = (measure(leaded, st).height - leading * (n-lines - 1)) / n-lines
    let nums-w = inset.x + measure(str(lines.len() + 1), st).width

    let rows = for (i, line) in lines.enumerate() {
      let bg = fill(i)
      let num = block(
        stroke: (left: stroke),
        fill: bg,
        align(right + horizon, num-style(i + 1))
      )
      let gutter = block(fill: bg)
        let text = block(
          stroke: (right: stroke), fill: bg,
          clip: true,
          place(dy: leading / 2 - (line-h + leading) * i, leaded)
        )
        (num, gutter, text)
    }
    
    block(width: 100%, stack(
      block(
        width: 100%, height: inset.y, fill: fill(0),
        radius: (top: inset.y), stroke: (x: stroke, top: stroke)
      ),
      {
        set block(width: 100%, height: line-h + leading)
        grid(columns: (nums-w, gutter, 1fr), ..rows)
      },
      block(
        width: 100%, height: inset.y, fill: fill(lines.len() - 1),
        radius: (bottom: inset.y), stroke: (x: stroke, bottom: stroke)
      )
    ))
  })


  // Cambiar fill predeterminado de índices
  set outline(fill: repeat([.#h(6pt)]))

  
  // Modifica apariencia de índices  
  show outline.entry.where(level: 1): it => {
    let el = it.element
    if el.func() == heading {
      let entry = if el.numbering == none {
        el.body
      } else [
        #numbering(el.numbering, ..counter(heading).at(el.location())) #h(indent-space) #el.body
      ]
      
      strong(link(el.location(), stack(dir: ltr,[#entry], 1fr, [#it.page])))
      v(-1.55em)
    } else{
      link(el.location(), [#el.counter.at(el.location()).first(). #h(15pt) #el.caption #h(5pt) #box(width: 1fr, it.fill) #it.page])
    }
  }


  // Introduce la portada
  if include-title-page {
    title-page(
      title: title,
      subject: subject,
      students: students,
      teachers: teachers,
      auxiliaries: auxiliaries,
      assistants: assistants,
      due-date: due-date,
      location: location,
      university: university,
      faculty: faculty,
      department: department,
      logo: logo
    )
  }


  // Comienzo del documento
  doc
}
