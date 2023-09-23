// Importar configuración del documento
#import "definitions.typ": *
#import "conf.typ": conf


// Importar otras bibliotecas que se utilizarán
#import "@preview/tablex:0.0.5": cellx, tablex, hlinex, vlinex, rowspanx, colspanx


// Parámetros para la configuración del documento. Descomentar aquellas que se quieran usar
#let document-params = (
  include-title-page: false,
  // title: none,
  // subject: none,
  // students: (),
  // teachers: (),
  // auxiliaries: (),
  // assistants: (),
  // lab-assistants: (),
  // semester: none,
  // due-date: none,
  // location: none,
  // university: none,
  // faculty: none,
  // department: none,
  // logo: none,
  // course-code: none,
  // course-name: none,
)

// Aplicación de la configuración del documento
#show: doc => conf(..document-params, doc)




////////// COMIENZO DEL DOCUMENTO //////////
