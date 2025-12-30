# Installation
Go to ```~/.local/share/typst/packages``` and create the folders ```templates/catppuccin/0.0.1/```

There you shall clone this repository.

# Usage
At the start of any typst document where you want this template write the following lines:
```
#import "@templates/catppuccin:0.0.1": *
#show: conf
```

If you want to make an individual word rainbow use ```#rainbow[your text]```
