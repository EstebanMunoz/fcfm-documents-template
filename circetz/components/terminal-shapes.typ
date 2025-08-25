#import "/circetz/component.typ": component
#import "/circetz/dependencies.typ": cetz

#import cetz.draw: *

#let circ(..inputs) = component(
  "circ",
  (style) => {
    circle(
      (0, 0),
      radius: style.nodes-width,
      stroke: if style.stroke.paint != none { style.stroke },
      fill: style.fill
    )
  },
  (
    stroke: none,
    fill: black,
    scale: auto,
    nodes-width: auto
  ),
  ..inputs
)

#let ocirc(..inputs) = component(
  "ocirc",
  (style) => {
    circle(
      (0, 0),
      radius: style.nodes-width,
      stroke: style.stroke,
      fill: style.fill
    )
  },
  (
    stroke: auto,
    fill: white,
    scale: auto,
    nodes-width: auto
  ),
  ..inputs
)

#let sqr(..inputs) = component(
  "sqr",
  (style) => {
    rect(
      (-style.nodes-width/2, style.nodes-width/2),
      (style.nodes-width/2, -style.nodes-width/2),
      stroke: if style.stroke.paint != none { style.stroke },
      fill: style.fill
    )
  },
  (
    stroke: auto,
    fill: black,
    scale: auto,
    nodes-width: auto,
  ),
  ..inputs
)