# Belle (Elm)

# Available Components

- Button
- Rating

# Architecture

This repository contains 2 libraries. The BaseUI which contains unstyled versions of various component, but option to map apply a theme. The second one is Belle which leverages the BaseUI to create a styles version of all the components. BaseUI can easily be used to create your own styled library, while Belle is useful in case you don't want to apply custom styling and need a well designed components out of the box.

# Development

## Setup

```
elm package install
```

## Formatting

We are using elm-format, read here how to set it up: https://github.com/avh4/elm-format

```
elm-format src/
elm-format examples/
```

# Run the Examples

```
# Go to examples and stay in that directory
cd examples

elm package install
npm install
chmod u+x elm-stuff/packages/rtfeldman/elm-css/1.1.0/elm-css.js
elm-stuff/packages/rtfeldman/elm-css/1.1.0/elm-css.js Stylesheets.elm

# Start the examples environment
elm reactor -a=localhost

# Run this every time you change CSS written in Elm in a different tab
elm-stuff/packages/rtfeldman/elm-css/1.1.0/elm-css.js Stylesheets.elm
```

Visit on of these pages in your browser:

- [http://localhost:8000/ButtonExample.elm](http://localhost:8000/ButtonExample.elm)
- [http://localhost:8000/RatingExample.elm](http://localhost:8000/RatingExample.elm)
