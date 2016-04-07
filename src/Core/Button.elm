module Core.Button (coreButton) where

import Html exposing (Html, button, Attribute)
import Html.Attributes exposing (attribute, property)

coreButton : List Attribute -> List Html -> Html
coreButton attributes html =
  let
    newAttributes =
      attributes
      ++
      [
        attribute "class" (Maybe.withDefault "wrong" (List.head attributes))
      ]
  in
    button
      newAttributes
      html
