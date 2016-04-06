module Belle.Button (Button, view, css) where

import Html exposing (Html, button, text, Attribute)
import Html.Attributes exposing (type')
import Html.Events exposing (on)
import Css exposing (..)
import Css.Elements as Css
import Html.CssHelpers exposing (namespace)
import DynamicStyle exposing (hover)
import Signal exposing (Message)
import Json.Decode exposing (succeed)


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
    classes =
      if parameters.primary then
        ButtonPrimary
      else
        ButtonDefault

    attributesBehaviour =
      [ class [ classes ]
      , type' parameters.type'
      , on "click" (succeed ()) (\_ -> parameters.onClick)
      , Html.Attributes.disabled parameters.disabled
      ]

    attributesStyle =
      List.append
        (DynamicStyle.hover [ ( "color", "blue", "green" ) ])
        (DynamicStyle.focus [ ( "color", "blue", "red" ) ])

    attributes =
      List.append attributesStyle attributesBehaviour
  in
    button
      (attributes)
      [ text parameters.content ]
