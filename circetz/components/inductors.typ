#import "/circetz/component.typ": component
#import "/circetz/dependencies.typ": cetz

#import cetz.draw: *

#let inductor(..inputs) = component(
  "inductor",
  style => {
    set-style(stroke: (thickness: style.stroke.thickness * style.thickness))

    let height = style.height
    let x = style.width / 2

    if style.style.inductor == "american" {
      let step = style.width / (style.coils * 2)

      anchor("x", (-x, 0))
      arc("x", start: 180deg, delta: -180deg, radius: step)

      for _ in range(style.coils - 1) {
        arc((), start: 180deg, delta: -180deg, radius: step)
      }
    } else if style.style.inductor == "cute" {
      let step = style.width / ((style.coils - 1) * calc.sqrt(2) + 2)
      anchor("x", (-x, 0))

      style.stroke.thickness *= style.thickness

      arc("x", start: 180deg, delta: -225deg, radius: step)

      for _ in range(style.coils - 2) {
        arc((), start: 225deg, delta: -270deg, radius: step)
      }

      arc((), start: 225deg, delta: -225deg, radius: step)
    }


    anchor("a", (-x, -height / 2))
    anchor("b", (x, height / 2))
  },
  (
    stroke: auto,
    thickness: auto,
    scale: auto,
    style: auto,
    width: 0.8,
    height: 0.3,
    coils: 4,
  ),
  ..inputs,
)