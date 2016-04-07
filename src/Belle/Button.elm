module Belle.Button (css, belleButton) where

import Html exposing (Html, button, Attribute)
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


belleButton : List Attribute -> List Html -> Html
belleButton attributes html =
  let
    classes = ButtonDefault
      -- if attributes.primary then
      --   ButtonPrimary
      -- else
      --   ButtonDefault
    newAttributes =
      attributes
      ++
      [
        class [ classes ]
      ]
  in
    button
      newAttributes
      html
