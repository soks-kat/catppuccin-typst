#import "./colours.typ": *

#let theme = state("colours", catppuccin)

#let conf(
  colours: catppuccin,
  one_page: true,
  doc,
) = {
  theme.update(colours)
  let gay = gradient.linear(colours.red, colours.orange, colours.yellow, colours.green, colours.blue, colours.purple)
  let rainbow(content) = {
    set text(fill: gay)
    box(content)
  }

  let page_height = 841.89pt
  let page_numbering = "1 / 1"
  if one_page {
    page_height = auto
    page_numbering = none
  } // This is to only have one page
  set page(height: page_height, numbering: page_numbering)

  set page(fill: colours.background)

  set text(
    font: "JetBrainsMono NF",
    weight: "light",
    size: 9pt,
  )

  show math.equation: set text(size: 11pt)

  set text(fill: colours.text-color)

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
          #let r = 0
          #if n-children > 1 {
            r = (idx/(n-children - 1))
          }
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

  set raw(theme: colours.name + ".tmTheme")
  show raw.where(block: true): it => block(
    fill: colours.background-light,
    inset: 1em,
    radius: 5pt,
    text(fill: colours.text-color, it)
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

  // show outline: set heading(outlined: true)
  let outline_counter = counter("outlines")

  let fill = repeat(".", gap: 0.15em)
  if colours.name != "boring" {
    fill = repeat(text(size: 1.5pt, weight: "bold")[gay], gap: 0.5em)
  }
  set outline.entry(fill: fill)

  let header_level = state("level", 0)
  show outline.entry: it => {
    outline_counter.step()
    context{
        let level = 0
        let prepad = ""
        // let level = 0
        if(it.element.func() == heading) {
          header_level.update(it.element.level)
          level = header_level
        } else {
          prepad = header_level.get() * "  "
        }
        it.indented(
          it.prefix(),
          link(
            it.element.location(),
            text(
              fill: colours.text-color,
              prepad 
              +it.body()
              +h(4pt)
              +box(width: 1fr, it.fill)
              +h(4pt)
            )
            // + [#outline_counter.get().at(0) / #outline_counter.final().at(0)]
            + if one_page {
              text(fill: gay.sample(outline_counter.get().at(0) / outline_counter.final().at(0)*100%),sym.star.filled)
            } else {
              text(fill: gay.sample(outline_counter.get().at(0) / outline_counter.final().at(0)*100%), str(it.element.location().page()))
            }
          )
        ) 
    }
  }
  show outline.entry: set block(above: 0.8em) 
  show outline.entry.where(
    level: 1
  ): it => {
    if it.element.func() == heading {
      set block(above: 1.3em) 
      it
    } else {
      it
    }
  }

  doc
}

#let rainbow(content) = context{
  let colours = theme.get()
  let gay = gradient.linear(colours.red, colours.orange, colours.yellow, colours.green, colours.blue, colours.purple)
  set text(fill: gay)
  box(content)
}

#let prev_idx = state("idx", 0)
#let prev_colour = state("colour", rgb("#000"))
// #let  = state("self", 0)
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
    fill: color.transparentize(80%),
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
    #context{
      prev_idx.update(old => old + 1)
      prev_colour.update(color)
      if type != "Exemple" {
        hide(box(height: 0pt, figure(
              none,
              kind: "theorem",
              supplement: type,
              caption: prev_idx.get()*"  " + type.slice(0, 1) + ": " + title,
              numbering: none,
              outlined: true,
          )))
      }
      "\n" + body
      prev_idx.update(old => old -1)
    }
  ]
}

#let example(body, ..args) = context{
  let colours = theme.get()
  clue(
    "Exemple",
    colours.desaturated,
    body,
    ..args
  )
};
#let theorem(body, ..args) = context{
  let colours = theme.get()
  clue(
    "Teorema",
    colours.primary,
    body,
    ..args
  )
};

#let def(body, ..args) = context{
  let colours = theme.get()
  clue(
    "Definició",
    colours.secondary,
    body,
    ..args
  )
};

#let tip(body, ..args, title: []) = {
  context {
    let colours = theme.get()
    let colour = colours.primary
    if prev_idx.get() != 0 {colour = prev_colour.get()}
    block(
      // fill: color.transparentize(80%),
      stroke: colour,
      radius: 6pt,
      inset: (
        top: 10pt,
        left: 15pt,
        right: 15pt,
        bottom: 10pt
      ),
      width: 100%,
      ..args,
    )[
      #body
    ]
  }
}


#let faint(body) = context {text(fill: theme.get().desaturated)[$#body$]}

#let exercise_numbering(..nums) = {
  let midmarker = "."
  let endmarker = ")"
  let nums_len = nums.pos().len()
  let (i, num) = nums.pos().enumerate().last()
  let marker = if nums_len != 1 and i == nums_len - 1 { endmarker } else { midmarker }
  let num-rep = numbering(if i == 0 { "1" } else { "a" }, num)
  [#num-rep#marker]
}

