# Belle (Elm)

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

Visit: `http://localhost:8000/Accordion.elm` in your browser
