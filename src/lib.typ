#import "./colours.typ": *

#let colourscheme = state("colours", catppuccin)
#let in_outline = state("in_outline", false)

#let theorem_selector = figure.where(kind: "theorem")

// #let vline = context {
//
// }

#let headers(theme: auto, doc,) = context{
  let colours = theme
  if colours == auto {
    colours = colourscheme.get()
  }
  let gay = gradient.linear(colours.red, colours.orange, colours.yellow, colours.green, colours.blue, colours.purple)

  show heading: it => math.bold(it)
  show heading.where(level: 1): it => {
    it
    v(-1em)
    move(line(length: 100% + 3pt, stroke: 2pt + gay), dx: -3pt)
  }
  show heading.where(level: 2): it => {
    it
    v(-1em)
    move(line(length: measure(it).width, stroke: 1.5pt + gay))
  }
  show heading.where(level: 3): it => {
    it
    v(-1em)
    move(line(length: measure(it).width, stroke: 1pt + gay))
  }
  doc
}

#let lists(theme: auto, doc,) = context{
  let colours = theme
  if colours == auto {
    colours = colourscheme.get()
  }
  let gay = gradient.linear(colours.red, colours.orange, colours.yellow, colours.green, colours.blue, colours.purple)

  show list: it => {
    let n-children = it.children.len()
    let block = block
    if it.tight {
      block = block.with(spacing: 0.65em)
    }

    for (idx, child) in it.children.enumerate() {
      block(pad(left: it.indent,
        stack(dir: ltr, spacing: it.body-indent,
          {
            let r = 0
            if n-children > 1 {
              r = (idx/(n-children - 1))
            }
            text(gay.sample(r*100%))[•]
          },
          child.body
        )
      ))
    }
  }
  doc
}

#let tables(theme: auto, doc) = context{
  let colours = theme
  if colours == auto {
    colours = colourscheme.get()
  }
  let gay = gradient.linear(colours.red, colours.orange, colours.yellow, colours.green, colours.blue, colours.purple)
  let gay_rel = gradient.linear(relative: "parent", colours.red, colours.orange, colours.yellow, colours.green, colours.blue, colours.purple)

  show table.cell.where(y: 0): strong

  show table: set table.vline(
      stroke: gay_rel
  )
  set table(
    stroke: (x, y) => if (y == 1) {
      (top: 1pt + gay)
    } else if(y > 1) {
      (top: 0.5pt + gay)
    },
    align: (x, y) => if x > 0 { center } else { left }
  )
  doc
}

#let outlines(theme: auto, one_page: true, gay_fill: true, doc) = context{
  let colours = theme
  if colours == auto {
    colours = colourscheme.get()
  }
  let gay = gradient.linear(colours.red, colours.orange, colours.yellow, colours.green, colours.blue, colours.purple)

  let outline_counter = counter("outlines")

  set outline.entry(
    fill: repeat(
      text(size: 1.5pt, weight: "bold")[gay],
      gap: 0.5em
    )
  ) if (gay_fill == auto and colours.name != "boring") or gay_fill == true

  set outline(indent: 1.2em)
  show outline.entry: it => {
    outline_counter.step()
    in_outline.update(true)
    let curr_index = 0
    if state("idx").at(it.element.location()) != none {
      curr_index = state("idx").at(it.element.location())
    }
    let indent = if outline.indent == auto {
      1.2em
    } else {
      outline.indent
    } * curr_index

    it.indented(
      it.prefix(),
      link(
        it.element.location(),
        text(
          // fill: colours.text-color,
          h(indent) + it.body()
          + h(4pt) + box(width: 1fr, it.fill) + h(4pt)
        )
        + context if one_page {
          text(
            fill: gay.sample(outline_counter.get().at(0) / outline_counter.final().at(0)*100%),
            sym.star.filled
          )
        } else {
          text(
            fill: gay.sample(outline_counter.get().at(0) / outline_counter.final().at(0)*100%),
            str(it.element.location().page())
          )
        }
      )
    )
    in_outline.update(false)
  }
  show outline.entry: set block(above: 0.8em)
  show outline.entry.where(level: 1): it => {
    if it.element.func() == heading {
      set block(above: 1.3em)
      it
    } else {
      it
    }
  }

  doc
}

#let code(theme: auto, doc) = context{
  let colours = theme
  if colours == auto {
    colours = colourscheme.get()
  }
  set raw(theme: "tmThemes/" + colours.name + ".tmTheme")
  show raw.where(block: true): it => block(
    fill: colours.background-light,
    inset: 1em,
    radius: 5pt,
    text(fill: colours.text-color, it)
  )
  doc
}

#let maths(doc) = {
  show math.equation: set text(size: 11pt)

  set math.equation(numbering: "(1)", supplement: [Eq.])
  show math.equation.where(block: true): it => {
    if it.block and not it.has("label") [
      #counter(math.equation).update(v => v - 1)
      #math.equation(it.body, block: true, numbering: none)#label(" ")
    ] else {
      it
    }
  }
  doc
}

#let dark_mode(dark: true, theme: auto, doc) = context{
  let colours = theme
  if colours == auto {
    colours = colourscheme.get()
  }
  set page(fill: colours.background) if dark
  set text(fill: colours.text-color) if dark
  doc
}

#let set_theme(theme) = {
  colourscheme.update(theme)
}

#let conf(
  theme: catppuccin,
  one_page: auto,
  gay_outline: auto,
  dark: true,
  monospace: auto,
  doc,
) = {
  let colours = theme
  if one_page == auto {
    if colours.name != "boring" {
      one_page = true
    } else {
      one_page = false
    }
  }

  if gay_outline == auto {
    if colours.name != "boring" {
      gay_outline = true
    } else {
      gay_outline = false
    }
  }

  if monospace == auto {
    if colours.name != "boring" {
      monospace = true
    } else {
      monospace = false
    }
  }

  // utils
  colourscheme.update(colours)
  let gay = gradient.linear(colours.red, colours.orange, colours.yellow, colours.green, colours.blue, colours.purple)
  let gay_rel = gradient.linear(relative: "parent", colours.red, colours.orange, colours.yellow, colours.green, colours.blue, colours.purple)
  let rainbow(content) = {
    set text(fill: gay)
    box(content)
  }

  // page formatting
  set page(height: auto) if one_page
  set page(numbering: "1 / 1") if not one_page

  // general formatting and theming
  set text(
    font: "JetBrainsMono NF",
    weight: "light",
    size: 9pt,
  ) if monospace

  set par(
    justify: true,
  )

  show strong: it => {
    text(
      weight: "extrabold"
    )[#it]
  }

  show link: it => context{
    if not in_outline.get(){
      rainbow(it)
    } else {
      it
    }
  }

  show: dark_mode.with(dark: dark)
  show: headers.with(theme: colours)
  show: lists.with(theme: colours)
  show: tables.with(theme: colours)
  show: outlines.with(theme: colours, one_page: one_page, gay_fill: gay_outline)

  show: code.with(theme: colours)
  show: maths

  doc
}

#let rainbow(content) = context{
  let colours = colourscheme.get()
  let gay = gradient.linear(colours.red, colours.orange, colours.yellow, colours.green, colours.blue, colours.purple)
  set text(fill: gay)
  box(content)
}

#let prev_idx = state("idx", 0)
#let prev_colour = state("colour", rgb("#000"))
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
    {
      box({
        set text(
          fill: header-color,
          weight: "bold",
        );
        math.bold({
          icon
          if title == none [
            #type
          ] else if type.len() != 0 [
            #type: #title
          ] else [
            #title
          ]
        })
      })
      prev_idx.update(old => old + 1)
      prev_colour.update(color)
      if type != "Exemple" {
        hide(box(
          height: 0pt,
          figure(
            none,
            kind: "theorem",
            caption: [#type.slice(0, 1): #title],
            numbering: none,
          )
        ))
      }
      "\n" + body
      prev_idx.update(old => old - 1)
    }
  )
}

#let example(body, ..args) = context {
  let colours = colourscheme.get()
  clue(
    "Exemple",
    colours.desaturated,
    body,
    ..args
  )
};
#let theorem(body, ..args) = context {
  let colours = colourscheme.get()
  clue(
    "Teorema",
    colours.primary,
    body,
    ..args
  )
};

#let def(body, ..args) = context {
  let colours = colourscheme.get()
  clue(
    "Definició",
    colours.secondary,
    body,
    ..args
  )
};

#let tip(body, ..args, title: []) = {
  context {
    let colours = colourscheme.get()
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
      body
    )
  }
}


#let faint(body) = context {text(fill: colourscheme.get().desaturated)[$#body$]}

#let exercise_numbering(..nums) = {
  let midmarker = "."
  let endmarker = ")"
  let nums_len = nums.pos().len()
  let (i, num) = nums.pos().enumerate().last()
  let marker = if nums_len != 1 and i == nums_len - 1 { endmarker } else { midmarker }
  let num-rep = numbering(if i == 0 { "1" } else { "a" }, num)
  [#num-rep#marker]
}

