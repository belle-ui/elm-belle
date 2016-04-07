module BaseUI.Button (button, ButtonTheme) where

import Html exposing (Html, Attribute)
import Html.Attributes exposing (attribute)


type alias ButtonTheme =
  { root : String }


button : List Attribute -> List Html -> ButtonTheme -> Html
button attributes html theme =
  let
    newAttributes =
      attributes
        ++ [ attribute "class" theme.root
           ]
  in
    Html.button
      newAttributes
      html
