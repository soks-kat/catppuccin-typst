#import "@typst_template/gay:0.0.1": *
#show: conf

#outline()

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
]

#example()[Hello yippee]

#def(title: "Limit")[
  this is the definition of a limit
]

