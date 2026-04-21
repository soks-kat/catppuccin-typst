#import "@typst_template/catppuccin:0.0.1": *
#show: conf.with(theme: kanagawa)

// #set_theme(catppuccin)
//
// #show: outlines.with(theme: kanagawa)
// #show: headers
// #show: dark_mode

#outline(target: selector.or(heading, theorem_selector), indent: 2em)

The outiline can include theorems and definitions or not depending on your preference by including figures of type "theorem".

= Usage
You can show as many modules as you want out of.
```typst
#show headings.with(theme: auto)
#show lists.with(theme: auto)
#show tables.with(theme: auto)
#show outlines.with(theme: auto, one_page: true, gay_fill: true)
#show code.with(theme: auto)
#show maths
```

Other usefull functions include
```typst
#show: dark_mode.with(theme: auto, dark: true) //changes document to dark mode
#set_theme(<theme>) //changes the theme of the document
```
Alternatively you can use one function that encompases all previous show rules

```typst
#show conf.with(
  theme: auto,
  one_page: auto, 
  gay_outline: auto, 
  monospace: auto,
  dark: true
)
```

The value of `auto` depends on which theme you have.
```typst
#if theme != "boring" {
  one_page = true
  gay_outline = true
  monospace = true
}

#if theme == "boring" {
  one_page = false
  gay_outline = false
  monospace = false
}
```

- Theme: the document theme can be specified either in the `conf` function or with the `set_theme` function. If no theme specified the document theme defaults to catppuccin. In each module, if the theme is `auto` then it gets the current document theme.

- One_page: decides whether the document has one or multiple pages. If `false` there will be numbering on the pages and the page numbers will appear in the outline

- Gay_outline: decides whether the dots in the outline are dots or small instances of the word gay.

- monospace: decides whether the font is "JetBrainsMono NF" or the default typst foent.

- Dark: decides whether to make the document have a dark background and light text.

== Theming
You can decide the colourscheme of the document with `#show: conf.with(theme: <colourscheme>)` or `#set_theme(<colourscheme>)`. The default theme is Catppuccin.

*Options:*
- catppuccin
- kanagawa
- trans
- boring

You can define your own colourscheme as a dictionary + a tmTheme under the same name.

```typst
#let your_colourscheme = (
  name: "your_colourscheme",
  background: rgb("#1e1e2e"),
  background-light: rgb("#2d2c3e"),

  text-color: rgb("#cdd6f4"),
  desaturated: rgb("#857da8"),

  primary: rgb("#cba6f7"),
  secondary: rgb("#89b4fa"),

  red: rgb("#f38ba8"),
  orange: rgb("#fab387"),
  yellow: rgb("#f9e2af"),
  green: rgb("#a6e3a1"),
  blue: rgb("#89b4fa"),
  purple: rgb("#cba6f7"),
)
```

= Text
== Subtitle

#lorem(50)
=== Sub-subtitle
#lorem(50)
=== Bullet points
- #lorem(5)
- #lorem(5)
- #lorem(5)
- #lorem(5)
- #lorem(5)
- #lorem(5)
- #lorem(5)
- #lorem(5)
- #lorem(5)
=== Rainbow
You can highlight words with ```typst #rainbow[word]``` #rainbow[this is now rainbow]
=== Link
#link("links.are.by.default@rainbow")


= Tables
#table(
  columns: (1fr, 1fr, 1fr),
  align: left,
  [Section 1], [Section 2], [Section 3],
  [content], [content], [content], [content], [content], [content], [content], [content], [content]
)

= Code blocks
little `block` or a bigger code block
```C
#include <stdio.h>

typedef struct{
  float lorem[5];
}Ipsum;

int main(){
  printf("dolor sit\n");
  int amet = 2;
  if (consectetur == 2) {
    int adipiscing = elit;
    // consectetur
  }
}

float sed(float a, float b){
  return a/b;
}
```

= Maths
#theorem(title: "Beautiful")[
  This is a theorem.
  You can make parts of an equation fainter
  $ faint(x^2 ->) x^2 $
  #tip()[you can add tips]
  #theorem(title: "Theorem in a thorem")[
    You can put theorems inside eachother
  ]
]

#example()[Hello yippee]

#def(title: "Limit")[
  this is the definition of a limit
  #tip()[tips adapt to the colour of the block they are in]
]

