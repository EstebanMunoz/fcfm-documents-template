#import "/circetz/component.typ": component
#import "/circetz/dependencies.typ": cetz

#import cetz.draw: *

#let diodes(
  name,
  func,
  style,
  inputs
) = component(
  ("diodes", name),
  style => {
    set-style(stroke: (thickness: style.stroke.thickness * style.thickness))

    let height = style.height
    let height2 = style.height / 2

    let width2 = style.width / 2

    merge-path(close: true,  {
      line((-width2, -height2), (rel: (0, height)))
      line((), (width2, 0))
      line((), (-width2, -height2))
    }, fill: style.fill)

    func(style)
    
    anchor("a", (-width2, -height2))
    anchor("b", (width2, height2))
  },
  (
    (
      stroke: auto,
      thickness: auto,
      fill: auto,
      style: auto,
      scale: auto,
    ),
    style
  ),
  ..inputs
)

#let diode(..inputs) = diodes(
  "diode",
  style => {
    let height2 = style.height / 2

    let width2 = style.width / 2
    line(
      (width2, -height2),
      (width2, height2)
    )

  },
  (
    width: 0.4,
    height: 0.4,

  ),
  inputs
)

#let schottky-diode(..inputs) = diodes(
  "schottky",
  style => {
    let height = style.height
    let height2 = style.height / 2
    let height4 = style.height / 4

    let width2 = style.width / 2
    let width4 = style.width / 4


    merge-path({
      line((width2+width4, height2 - height4), (rel: (0, height4)))
      line((), (rel: (-width4, 0)))
      line((width2, -height2), (width2, height2))
      line((width2, -height2), (rel: (-width4, 0)))
      line((), (rel: (0, height4)))
    })
  },
  (
    width: 0.4,
    height: 0.4,

  ),
  inputs
)

#let zener-diode(..inputs) = diodes(
  "zener",
  style => {
    let height = style.height
    let height2 = style.height / 2
    let height4 = style.height / 4

    let width2 = style.width / 2
    let width4 = style.width / 4
  

    merge-path({
      line((width2+width4, height2), (rel: (-width4, 0)))
      line((width2, -height2), (width2, height2))
      line((width2, -height2), (rel: (-width4, 0)))
    })
  },
  (
    width: 0.4,
    height: 0.4,

  ),
  inputs
)

#let tunnel-diode(..inputs) = diodes(
  "tunnel",
  style => {
    let height = style.height
    let height2 = style.height / 2
    let height4 = style.height / 4

    let width2 = style.width / 2
    let width4 = style.width / 4

    merge-path({
      line((width2 - width4, height2), (rel: (width4, 0)))
      line((width2, -height2), (width2, height2))
      line((width2, -height2), (rel: (-width4, 0)))
    })
  },
  (
    width: 0.4,
    height: 0.4,

  ),
  inputs
)

#let led-diode(..inputs) = diodes(
  "led",
  style => {
    let height = style.height
    let height2 = style.height / 2
    let height4 = style.height / 4
    let height8 = style.height / 8

    let width2 = style.width / 2
    let width4 = style.width / 4

    line((width2, -height2), (width2, height2))
    line((0, height4 + height4), (rel: (width2, height2 + height8)), mark: (end: ">", scale: 0.2))
    line((width4, height4 + height8), (rel: (width2, height2 + height8)), mark: (end: ">", scale: 0.2))
  },
  (
    width: 0.4,
    height: 0.4,

  ),
  inputs
)

#let photo-diode(..inputs) = diodes(
  "photo",
  style => {
    let height = style.height
    let height2 = style.height / 2
    let height4 = style.height / 4
    let height8 = style.height / 8

    let width2 = style.width / 2
    let width4 = style.width / 4

    line((width2, -height2), (width2, height2))
    line((width2, height + height8), (rel: (-width2, -height2 - height8)), mark: (end: ">", scale: 0.2))
    line((width2 + width4, height), (rel: (-width2, -height2 - height8)), mark: (end: ">", scale: 0.2))
  },
  (
    width: 0.4,
    height: 0.4,
  ),
  inputs
)

#let varcap-diode(..inputs) = diodes(
  "varcap",
  style => {
    let height2 = style.height / 2

    let width2 = style.width / 2
    let width8 = style.width / 8

    line((width2, -height2), (width2, height2))
    line((width2 + width8, -height2), (width2 + width8, height2))
  },
  (
    width: 0.4,
    height: 0.4,

  ),
  inputs
)

#let thyristor(..inputs) = diodes(
  "thyristor",
  style => {
    let height2 = style.height / 2

    let width2 = style.width / 2
    let width8 = style.width / 8

    line((width2, -height2), (width2, height2))

    set-style(stroke: (thickness: style.stroke.thickness))

    merge-path({
      line((width2, 0), (rel: (width2, height2)))
      line((style.width, height2), (rel: (0, height2))) 
    })
    anchor("G", ())   
  },
  (
    width: 0.4,
    height: 0.4,

  ),
  inputs
)

#let put-thyristor(..inputs) = diodes(
  "put",
  style => {
    let height2 = style.height / 2

    let width2 = style.width / 2
    let width8 = style.width / 8

    line((width2, -height2), (width2, height2))

    set-style(stroke: (thickness: style.stroke.thickness))


    merge-path({
      line((-width2, 0), (rel: (-width2, height2)))
      line((-style.width, height2), (rel: (0, height2))) 
    })
    anchor("G", ())   
  },
  (
    width: 0.4,
    height: 0.4,

  ),
  inputs
)

#let gto-thyristor(..inputs) = diodes(
  "gto",
  style => {
    let height2 = style.height / 2
    let height4 = style.height / 4

    let width2 = style.width / 2
    let width8 = style.width / 8

    line((width2, -height2), (width2, height2))

    set-style(stroke: (thickness: style.stroke.thickness))

    line((width2, height4), (rel: (width2, height2)))
    
    merge-path({
      line((width2, 0), (rel: (width2, height2)))
      line((style.width, height2), (rel: (0, height2))) 
    })
    anchor("G", ())   
  },
  (
    width: 0.4,
    height: 0.4,

  ),
  inputs
)

#let gto-bar-thyristor(..inputs) = diodes(
  "gtob",
  style => {
    let height2 = style.height / 2
    let height4 = style.height / 4

    let width2 = style.width / 2
    let width8 = style.width / 8

    line((width2, -height2), (width2, height2))
    
    set-style(stroke: (thickness: style.stroke.thickness))

    line((style.width - 3/2*width8, height2 + height4), (rel: (3*width8, 0)))
    
    merge-path({
      line((width2, 0), (rel: (width2, height2)))
      line((style.width, height2), (rel: (0, height2))) 
    })
    anchor("G", ())   
  },
  (
    width: 0.4,
    height: 0.4,

  ),
  inputs
)