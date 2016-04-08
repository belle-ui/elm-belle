module RatingExample (..) where

import Html exposing (..)
import Html.Attributes exposing (..)
import Belle.Rating exposing (rating)
import BaseUI.Rating exposing (onRatingSelect)
import Html.Attributes exposing (attribute, property)
import Signal
import StartApp.Simple as StartApp
import Util
import Json.Encode exposing (string)


type alias State =
  { rating : Int }


init : State
init =
  { rating = 1 }


source : Signal.Mailbox Action
source =
  Signal.mailbox NoOp


type Action
  = NoOp
  | ChangeRating Int


update : Action -> State -> State
update action previous =
  case action of
    NoOp ->
      previous

    ChangeRating newRating ->
      { previous | rating = newRating }


view : State -> Html
view state =
  div
    []
    [ span [] [ text (toString state.rating) ]
    , div
        []
        [ rating [] (onRatingSelect source.address ChangeRating) ]
    , Util.stylesheetLink "/rating-example.css"
    ]


main : Signal Html
main =
  Signal.map view state


state : Signal State
state =
  Signal.foldp update init source.signal
