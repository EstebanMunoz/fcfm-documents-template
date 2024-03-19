#import "@local/fcfm-informe:0.1.0": conf, today

// Parámetros para la configuración del documento. Descomentar aquellas que se quieran usar
#let document-params = (
  // "include-title-page": false,
  "title": "Título del documento",
  "subject": "Tema del documento",
  // "course-name": "",
  // "course-code": "",
  "students": ("Esteban Muñoz",),
  // "teachers": (),
  // "auxiliaries": (),
  // "assistants": (),
  // "lab-assistants": (),
  // "semester": "",
  "due-date": today,
  "place": "Santiago de Chile",
  "university": "Universidad de Chile",
  "faculty": "Facultad de Ciencias Físicas y Matemáticas",
  "department": "Departamento de Ingeniería Eléctrica",
  "logo": box(height: 1.57cm, image("assets/logos/die.svg")),
)

// Aplicación de la configuración del documento
#show: doc => conf(..document-params, doc)

// Índices de contenidos
// #{
//   set page(numbering: "i")
//   outline(title: "Índice de Contenidos")
//   pagebreak()

//   outline(title: "Índice de Figuras", target: figure.where(kind: image))

//   outline(title: "Índice de Tablas", target: figure.where(kind: table))

//   outline(title: "Índice de Códigos", target: figure.where(kind: raw))
// }

// #counter(page).update(1)


////////// COMIENZO DEL DOCUMENTO //////////
