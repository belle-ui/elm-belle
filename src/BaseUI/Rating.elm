module BaseUI.Rating (rating, onRatingSelect, RatingTheme) where

import Html exposing (Html, div, span, text, Attribute)
import Html.Attributes exposing (attribute)
import Html.Events exposing (on)
import Json.Decode exposing (succeed)
import Signal exposing (Signal, Message)


type alias RatingTheme =
  { root : String
  , character : String }


onRatingSelect : (Signal.Address a -> (number -> a) -> (number -> Message))
onRatingSelect addr msg =
  (\rating -> Signal.message addr (msg rating))


rating : List Attribute -> (number -> Message) -> RatingTheme -> Html
rating attributes action theme =
  let
    newAttributes =
      attributes
        ++ [ attribute "class" theme.root
           ]

    characterAttributes = [ attribute "class" theme.character ]
    characterAttributes1 = [ on "click" (succeed ()) (\_ -> action 1) ] ++ characterAttributes
    characterAttributes2 = [ on "click" (succeed ()) (\_ -> action 2) ] ++ characterAttributes
    characterAttributes3 = [ on "click" (succeed ()) (\_ -> action 3) ] ++ characterAttributes
    characterAttributes4 = [ on "click" (succeed ()) (\_ -> action 4) ] ++ characterAttributes
    characterAttributes5 = [ on "click" (succeed ()) (\_ -> action 5) ] ++ characterAttributes
  in
    div
      newAttributes
      [ span characterAttributes1 [ text "★" ]
      , span characterAttributes2 [ text "★" ]
      , span characterAttributes3 [ text "★" ]
      , span characterAttributes4 [ text "★" ]
      , span characterAttributes5 [ text "★" ]
      ]
