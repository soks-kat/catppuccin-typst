#let background = rgb("#1e1e2e");
#let background-light = rgb("#2d2c3e");
#let background-dark = rgb("#181826");

#let text-color = rgb("#cdd6f4");
#let text-dark = rgb("#181825");

#let primary = rgb("#cba6f7");
#let primary-b = rgb("#a177d1");
#let secondary = rgb("#89b4fa");
#let secondary-b = rgb("#5d8cda");
#let tertiary = rgb("#fab387");
#let four = rgb("#f38ba8");

#let red = rgb("#f38ba8");
#let red-b = rgb("#dd6887");
#let orange = rgb("#fab387");
#let orange-b = rgb("#f58e6a");
#let yellow = rgb("#f9e2af");
#let yellow-b = rgb("#fbd98d");
#let green = rgb("#a6e3a1");
#let green-b = rgb("#83d37d");
#let blue = rgb("#89b4fa");
#let blue-b = rgb("#6c99e2");
#let purple = rgb("#cba6f7");
#let purple-b = rgb("#a177d1");

#let gay = gradient.linear(red, orange, yellow, green, blue, purple)

#let conf(
  doc,
) = {
  set page(height: auto) // This is to only have one page

  set page(fill: background)


  set text(fill: text-color)

  show heading.where(level: 1): it => {
    it
    v(-1em)
    move(line(length: 100% + 3pt, stroke: 2pt + gay), dx: -3pt)
  }
  show heading.where(level: 2): it => {
    underline(it, stroke: 1.5pt + gay, extent: 1pt, offset: 2.5pt, evade: false)
  }
  show heading.where(level: 3): it => {
    underline(it, stroke: 1pt + gay, extent: 0pt, offset: 2.5pt, evade: false)
  }

  show list: it => {
    let n-children = it.children.len()
    let block = block
    if it.tight {
    block = block.with(spacing: 0.65em)
  }

    for (idx, child) in it.children.enumerate() {
    block(pad(left: it.indent)[
      #stack(dir: ltr, spacing: it.body-indent)[
        #let r = (idx/n-children)
        #set text(gay.sample(r*100%))
        •
      ][
        #child.body
      ]
    ])
  }
  }


  show link: set text(fill: gay)

  show table.cell.where(y: 0): strong
  set table(
    stroke: (x, y) => if (y == 1){
    (top: 1pt + gay)
  }else if(y > 1){
    (top: 0.7pt + gay)
  },
    align: (x, y) => (
    if x > 0 { center }
    else { left }
  )
  )

  set raw(theme: "theme.tmTheme")
  show raw: it => block(
    fill: background-light,
    inset: 10pt,
    radius: 5pt,
    text(fill: text-color, it)
  )
  doc
}

#let rainbow(content) = {
  set text(fill: gay)
  box(content)
}
