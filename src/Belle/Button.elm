module Belle.Button (Button, view, css) where

import Html exposing (Html, button, text)
import Css exposing (..)
import Css.Elements as Css
import Html.CssHelpers exposing (namespace)


type CssClasses
  = ButtonBase


{ class, classList, id } =
  Html.CssHelpers.namespace ""


css =
  (stylesheet)
    [ (.)
        ButtonBase
        [ height (px 20)
        , overflow hidden
        ]
    ]


type alias Button = {
  content: String,
  primary: Bool
}

view : Button -> Html
view buttonx =
  let
    buttonText = "Follow Me"
  in
    button
      []
      [text buttonx.content]
