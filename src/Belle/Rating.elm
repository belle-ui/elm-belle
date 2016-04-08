module Belle.Rating (rating, css, theme) where

import BaseUI.Rating exposing (rating, RatingTheme)
import Html exposing (Html, Attribute)
import Css exposing (..)
import Css.Elements as Css
import Html.CssHelpers exposing (namespace)
import Signal exposing (Message)


type CssClasses
  = BelleRatingRoot
  | BelleRatingCharacter


{ class, classList, id } =
  Html.CssHelpers.namespace ""


css =
  (stylesheet)
    [ (.)
        BelleRatingRoot
        []
    , (.)
        BelleRatingCharacter
        []
    ]


theme : RatingTheme
theme =
  { root = "BelleRatingRoot"
  , character = "BelleRatingCharacter"
  }


rating : List Attribute -> (number -> Message) -> Html
rating attrs action =
  BaseUI.Rating.rating
    attrs
    action
    theme
