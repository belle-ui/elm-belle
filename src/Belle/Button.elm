module Belle.Button (button, css, theme) where

import BaseUI.Button exposing (button, ButtonTheme)
import Html exposing (Html, Attribute)
import Css exposing (..)
import Css.Elements as Css
import Html.CssHelpers exposing (namespace)


type CssClasses
  = BelleButtonRoot


{ class, classList, id } =
  Html.CssHelpers.namespace ""


css =
  (stylesheet)
    [ (.)
        BelleButtonRoot
        [ backgroundColor (rgb 100 100 100) ]
    ]


theme : ButtonTheme
theme =
  { root = "BelleButtonRoot" }


button : List Attribute -> List Html -> Html
button attributes html =
  BaseUI.Button.button
    attributes
    html
    theme
