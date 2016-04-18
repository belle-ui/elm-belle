module RatingExample (..) where

import Html exposing (..)
import Html.Attributes exposing (..)
--import Belle.Rating exposing (rating)
import BaseUI.Rating as Rating
import Html.Attributes exposing (attribute, property)
import Signal
import StartApp.Simple as StartApp
import Util
import Json.Encode exposing (string)

type alias Model =
  { rating : Rating.Rating }


init : Model
init = 
  { rating = Rating.init 1 }


source : Signal.Mailbox Action
source =
  Signal.mailbox NoOp


type Action
  = Rating Rating.Action


update : Action -> Model -> Model
update action previous =
  case action of
    NoOp ->
      previous

    ChangeRating newRating ->
      Rating.update newRating


view : Model -> Html
view state =
  div
    []
    [ span [] [ text (toString state.rating) ]
    , div
        []
        [ Rating.view (\rating -> Signal.message source.address (ChangeRating rating)) state.rating ]
    , Util.stylesheetLink "/rating-example.css"
    ]


main : Signal Html
main =
  Signal.map view state


state : Signal Model
state =
  Signal.foldp update init source.signal
