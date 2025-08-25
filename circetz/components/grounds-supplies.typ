#import "/circetz/component.typ": component
#import "/circetz/dependencies.typ": cetz

#import cetz.draw: *

#let common(..inputs) = component(
  "common",
  (style) => {
    style.stroke.thickness *= style.thickness
    line(
      (-0.6 * style.width, 0),
      (0.6 * style.width, 0),
      (0, -0.6 * style.width),
      (-0.6 * style.width, 0),
      stroke: style.stroke
    )
  },
  (
    scale: auto,
    thickness: auto,
    connection-thickness: 1,
    width: .25,
    stroke: auto,
    fill: none
  ),
  ..inputs
)

#let ground(..inputs) = component(
  "ground",
  (style) => {
    style.stroke.thickness *= style.thickness
    line(
      (-0.6 * style.width, 0),
      (0.6 * style.width, 0),
      stroke: style.stroke
    )
    line(
      (-0.4 * style.width, -0.25 * style.width),
      (0.4 * style.width, -0.25 * style.width),
      stroke: style.stroke
    )
    line(
      (-0.25 * style.width, -0.5 * style.width),
      (0.25 * style.width, -0.5 * style.width),
      stroke: style.stroke
    )
  },
  (
    scale: auto,
    thickness: auto,
    connection-thickness: 1,
    width: .25,
    stroke: auto,
    fill: none
  ),
  ..inputs
)

#let chassis(..inputs) = component(
  "chassis",
  style => {
    style.stroke.thickness *= style.thickness
    line(
      (-0.6 * style.width, 0),
      (0.6 * style.width, 0),
      stroke: style.stroke
    )
    line(
      (-0.6 * style.width, 0),
      (rel: (-135deg, 0.6 * style.width)),
      stroke: style.stroke
    )
    line(
      (0, 0),
      (rel: (-135deg, 0.6 * style.width)),
      stroke: style.stroke
    )
    line(
      (0.6 * style.width, 0),
      (rel: (-135deg, 0.6 * style.width)),
      stroke: style.stroke
    )
  },
  (
    scale: auto,
    thickness: auto,
    connection-thickness: 1,
    width: .25,
    stroke: auto,
    fill: none
  ),
  ..inputs
)

#let power-supplies(
  name,
  style,
  inputs
  ) = component(
  ("power-supplies", name),
  style => {
    set-style(stroke: style.stroke)
    anchor("left", (0,0))
    anchor("right", (0,0))
    if name == "vee" {
      // panic()
      scale(y: -1)
    }
    let width = style.width
    anchor("text", (
      0,
      2 * width + style.label.last() * 0.5
    ))
    line(
      (-0.5 * width, 0.8 * width),
      (0, 1.5 * width),
      (0.5 * width, 0.8 * width),
      stroke: (thickness: style.stroke.thickness * style.thickness)
    )
    line((0,0), (0, 1.5 * width))
  },
  (
    (
      scale: auto,
      fill: none,
      thickness: auto,
      stroke: auto,
      width: 0.2
    ),
    style
  ),
  ..inputs
)


#let vcc(..inputs) = power-supplies(
  "vcc",
  (
    width: auto
  ),
  inputs
)

#let vee(..inputs) = power-supplies(
  "vee",
  (
    width: auto
  ),
  inputs
)