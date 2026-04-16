#import "@typst_template/catppuccin:0.0.1": *
#show: conf.with(colours: catppuccin, one_page: true)

#outline(target: selector.or(heading, figure))

The outiline can include theorems and definitions or not depending on your preference by including figures of type "theorem".

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

= Theming
You can decide the colourscheme of the document with `#show: conf.with(colours: <colourscheme>)`. The default theme is Catppuccin.

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

You can also decide whether to have more than one page for your document with `#show conf.with(one_page: false)`. The default is to have one page.

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
  #tip()[wawa]
]

#example()[Hello yippee]

#def(title: "Limit")[
  this is the definition of a limit
  #tip()[you can add tips]
]

