#import "@local/fcfm-documents:0.2.0": conf, subfigures, today

// Parámetros para la configuración del documento. Descomentar aquellas que se quieran usar
#let document-params = (
  "document-type": "report",
  "is-subtitle-in-header": false,
  "title": "Título del documento",
  "subject": "Tema del documento",
  "course-name": "Introducción a Typst",
  "course-code": "CC1234",
  "students": ("Esteban Muñoz",),
  // "teachers": ("",),
  // "auxiliaries": ("",),
  // "assistants": ("",),
  // "semester": "Otoño 2024",
  "date": today,
  "place": "Santiago de Chile",
  "university": "Universidad de Chile",
  "faculty": "Facultad de Ciencias Físicas y Matemáticas",
  "department": "Departamento de Ingeniería Eléctrica",
  "logo": box(height: 1.57cm, image("assets/logos/die.svg")),
)

// Aplicación de la configuración del documento
#show: doc => conf(..document-params, doc)

// Índices de contenidos
#{
  set page(numbering: "i")
  outline(title: "Índice de Contenidos")
  pagebreak()

  outline(title: "Índice de Figuras", target: figure.where(kind: image))

  outline(title: "Índice de Tablas", target: figure.where(kind: table))

  outline(title: "Índice de Códigos", target: figure.where(kind: raw))
}

#counter(page).update(1)


////////// COMIENZO DEL DOCUMENTO //////////

= Sección importante

#lorem(200)

== Subsección importante

#lorem(33)

#subfigures(
  columns: 2,
  label: <fig:rects>,
  caption: "Figura importante",
  [#figure(
    caption: "Un rectángulo muy importante",
    rect(fill: blue)
   ) <fig:blue-rect>],
  [#figure(
    caption: "Rectángulo menos importante",
    rect(fill: yellow)
  ) <fig:yellow-rect>]
)

#lorem(7) According to @fig:blue-rect, is known that #lorem(23) The main objective of @fig:rects is to show the importance of #lorem(40)


#pagebreak()
= Experimentos

== Experimento 1
One way to prove the above statement, is by means of the results of the following computational experiment:

#figure(caption: "Very important experiment",
```python
# This code replicates the important experiment. It has the same
# exact parameters of the results exposed.
print("Hello World!")
```
) <code:experiment>


#pagebreak()
= Resultados

The results of the experiment shown in @code:experiment, can be found in the below table #footnote[More experiments are needed to validate the results.]:

#figure(
  caption: "The experiment results",
  table(
    columns: 3,
    table.header(
      [Experiment],
      [N° experiments],
      [Metrics \[Accuracy\]],
    ),
    [Hello World],
    [1], [92.1],
    [Actual experiment],
    [0], [0]
  )
) <table:results>


#pagebreak()
= Análisis de resultados
The results shown in @table:results, one can understand that the importance of the experiment resides in #lorem(40)

#lorem(100)


#pagebreak()
= Conclusión
#lorem(134)

#lorem(101)

Por lo tanto, se concluye que se cumplieron los objetivos.