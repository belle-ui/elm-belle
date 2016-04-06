module Belle.Button (Button, view, css) where

import Html exposing (Html, button, text, Attribute)
import Html.Attributes exposing (type', disabled)
import Html.Events exposing (onClick, on)
import Css exposing (..)
import Css.Elements as Css
import Html.CssHelpers exposing (namespace)
import Signal exposing (Message)
import Json.Decode

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


type alias Button = 
  { content : String
  , primary : Bool
  , type' : String
  , disabled : Bool
  , onClick : Message
  }

view : Button -> Html
view parameters =
  let
    this_type = parameters.type'
    classes = if parameters.primary then ButtonPrimary else ButtonDefault
  in
    button
      [ class [ classes ]
      , type' this_type
      , on "click" (Json.Decode.succeed ()) (\_ -> parameters.onClick)
      , Html.Attributes.disabled parameters.disabled
      ]
      [text parameters.content]
