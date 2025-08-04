#import "/circetz/component.typ": component
#import "/circetz/dependencies.typ": cetz

#import cetz.draw: *

#import "/circetz/components/arrows.typ": currarrow

#let isource(..inputs) = component(
  "isource",
  style => {
    style.stroke.thickness *= style.thickness
    circle(
      (0, 0),
      radius: (style.width / 2, style.height / 2),
      name: "c",
      stroke: style.stroke,
      fill: style.fill,
    )
    anchor("a", ("c.west", "|-", "c.south"))
    anchor("b", ("c.east", "|-", "c.north"))
    if style.style.current == "european" {
      line("c.south", "c.north", stroke: style.stroke)
    } else if style.style.current == "american" {
      line(
        ("c.west", 30%, "c.center"),
        ("c.east", 30%, "c.center"),
        stroke: style.stroke,
      )
      currarrow(("c.east", 50%, "c.center"))
    }
  },
  (
    stroke: auto,
    thickness: auto,
    fill: auto,
    style: auto,
    scale: auto,
    width: 0.6,
    height: 0.6,
  ),
  ..inputs,
)


#let vsource(..inputs) = component(
  "vsource",
  style => {
    style.stroke.thickness *= style.thickness
    circle(
      (0, 0),
      radius: (style.width / 2, style.height / 2),
      name: "v",
      stroke: style.stroke,
      fill: style.fill,
    )
    anchor("a", ("v.west", "|-", "v.south"))
    anchor("b", ("v.east", "|-", "v.north"))
    if style.style.voltage == "european" {
      line("v.west", "v.east", stroke: style.stroke)
    } else if style.style.voltage == "american" {
      content(("v.east", 50%, "v.center"), $+$)
      content(("v.west", 50%, "v.center"), $-$)
    }
  },
  (
    stroke: auto,
    thickness: auto,
    fill: auto,
    style: auto,
    scale: auto,
    width: 0.6,
    height: 0.6,
  ),
  ..inputs,
)

#let battery(..inputs) = component(
  "battery",
  style => {
    style.stroke.thickness *= style.thickness
    line(
      (style.width / 2, style.height / 2,),
      (style.width / 2, -style.height / 2),
      name: "upper",
      stroke: style.stroke,
      fill: style.fill
    )
    line(
      (-style.width / 2, style.height / 4),
      (-style.width / 2, -style.height / 4),
      name: "lower",
      stroke: style.stroke,
      fill: style.fill
    )
    anchor("a", (-style.width * 0.5, -style.height * 0.5))
    anchor("b", (style.width * 0.5, style.height * 0.5))
  },
  (
    stroke: auto,
    thickness: auto,
    fill: auto,
    style: auto,
    scale: auto,
    width: 0.1,
    height: 0.8,
  ),
  ..inputs,
)