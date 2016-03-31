module Belle.Button (Button, view, css) where

import Html exposing (Html, button, text)
import Css exposing (..)
import Css.Elements as Css
import Html.CssHelpers exposing (namespace)


type CssClasses
  = ButtonDefault
  | ButtonPrimary


{ class, classList, id } =
  Html.CssHelpers.namespace ""


css =
  (stylesheet)
    [ (.)
        ButtonDefault
        [ backgroundColor (rgb 100 100 100) ]
    , (.)
        ButtonPrimary
        [ backgroundColor (rgb 240 240 240) ]
    ]


type alias Button = {
  content: String,
  primary: Bool
}

view : Button -> Html
view parameters =
  let
    buttonText = "Follow Me"

    classes = if parameters.primary then ButtonPrimary else ButtonDefault
  in
    button
      [ class [ classes ] 
      ]
      [text parameters.content]
