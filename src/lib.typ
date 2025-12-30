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
#let desaturated = rgb("#857da8");

#let gay = gradient.linear(red, orange, yellow, green, blue, purple)
#let rainbow(content) = {
  set text(fill: gay)
  box(content)
}

#let conf(
  doc,
) = {
  set page(height: auto) // This is to only have one page

  set page(fill: background)

  set text(
    font: "JetBrainsMono NF",
    weight: "light",
    size: 9pt,
  )

  show math.equation: set text(size: 11pt)

  set text(fill: text-color)

  set par(
    justify: true,
  )
  show heading: it => math.bold(it)
  show heading.where(level: 1): it => {
    it
    v(-1em)
    move(line(length: 100% + 3pt, stroke: 2pt + gay), dx: -3pt)
    // counter(heading).step()
  }
  show heading.where(level: 2): it => {
    underline(it, stroke: 1.5pt + gay, extent: 1pt, offset: 2.5pt, evade: false)
  }
  show heading.where(level: 3): it => {
    underline(it, stroke: 1pt + gay, extent: 0pt, offset: 2.5pt, evade: false)
  }

  // let list_counter = counter("bullets")
  show list: it => {
    let n-children = it.children.len()
    let block = block
    if it.tight {
    block = block.with(spacing: 0.65em)
  }

    for (idx, child) in it.children.enumerate() {
      block(pad(left: it.indent)[
        #stack(dir: ltr, spacing: it.body-indent)[
          #let r = (idx/(n-children - 1))
          #set text(gay.sample(r*100%))
          •
        ][
          #child.body
        ]
      ])
    }
  }
  // set highlight(
  //   fill: purple.transparentize(40%),
  //   top-edge: 0.5pt,
  // )
  //
  // show strong: it => {
  //   highlight[#it.body]
  // };

  show link: it => rainbow(it)

  show table.cell.where(y: 0): strong
  set table(
    stroke: (x, y) => if (y == 1){
    (top: 1pt + gay)
  }else if(y > 1){
    (top: 0.5pt + gay)

  },
    align: (x, y) => (
    if x > 0 { center }
    else { left }
  )
  )
  set math.equation(numbering: "(1)", supplement: [Eq.])
  show math.equation: it => {
    if it.block and not it.has("label") [
      #counter(math.equation).update(v => v - 1)
      #math.equation(it.body, block: true, numbering: none)#label(" ")
    ] else {
      it
    }  
  }

  set raw(theme: "theme.tmTheme")
  show raw: it => block(
    fill: background-light,
    inset: 5pt,
    radius: 5pt,
    text(fill: text-color, it)
  )
  show strong: it => {
    text(
      weight: "extrabold"
    )[#it]
  }

  // show outline.entry.where(
  //   level: 1
  // ): set block(above: 1.2em)
// show outline.entry: it => link(
//   it.element.location(),
//   // Keep just the body, dropping
//   // the fill and the page.
//   it.indented(it.prefix(), it.body() + it.fill),
// )

  let outline_counter = counter("outlines")

  set outline.entry(fill: repeat(text(size: 1.5pt, weight: "bold")[gay], gap: 0.5em))
  show outline.entry: it => {
  outline_counter.step()
context{
    it.indented(
      it.prefix(),
      link(
        it.element.location(),
        text(
          fill: text-color,
          it.body()
          +h(4pt)
          +box(width: 1fr, it.fill)
          +h(4pt)
        )
        // + [#outline_counter.get().at(0) / #outline_counter.final().at(0)]
        + text(fill: gay.sample(outline_counter.get().at(0) / outline_counter.final().at(0)*100%),sym.star.filled)
      )
    ) 
}
  }
  show outline.entry.where(
    level: 1
  ): set block(above: 1.2em)

  doc
}

#let clue(
  type,
  color,
  body,
  title: [],
  header-color: auto,
  icon: [>],
  ..args
) = {
  if header-color == auto {
    header-color = color;
  }
  block(
    fill: color.transparentize(84%),
    radius: 6pt,
    inset: (
      top: 10pt,
      left: 15pt,
      right: 15pt,
      bottom: 15pt
    ),
    width: 100%,
    ..args,
  )[
    #box()[
      #set text(
        fill: header-color,
        weight: "bold",
      );
      #math.bold[
        #icon
        #if title == none [
          #type
        ] else if type.len() != 0 [
          #type: #title
        ] else [
          #title
        ]
      ]
    ]

    #body
  ]
}

#let example(body, ..args) = clue(
  "Exemple",
  desaturated,
  body,
  ..args
);
#let theorem(body, ..args) = clue(
  "Teorema",
  primary,
  body,
  ..args
);


#let faint(body) = text(fill: desaturated)[$#body$]

#let exercise_numbering(..nums) = {
  let midmarker = "."
  let endmarker = ")"
  let nums_len = nums.pos().len()
  let (i, num) = nums.pos().enumerate().last()
  let marker = if nums_len != 1 and i == nums_len - 1 { endmarker } else { midmarker }
  let num-rep = numbering(if i == 0 { "1" } else { "a" }, num)
  [#num-rep#marker]
}

