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
  { rating : Rating.Model }


init : Model
init =
  let
    config =
      Rating.defaultConfig
        |> Rating.setMaxRating 5
        |> Rating.setTheme "myTheme"
  in
    { rating = Rating.initWithConfig 2 config }


source : Signal.Mailbox Action
source =
  Signal.mailbox NoOp


type Action
  = NoOp
  | Rating Rating.Action


update : Action -> Model -> Model
update action previous =
  case action of
    NoOp ->
      previous

    Rating act ->
      let
        updatedRating =
          Rating.update act previous.rating
      in
        { previous | rating = updatedRating }


view : Model -> Html
view model =
  div
    []
    [ span [] [ text (toString model.rating) ]
    , div
        []
        [ Rating.view (Signal.forwardTo source.address Rating) model.rating ]
    , Util.stylesheetLink "/rating-example.css"
    ]


main : Signal Html
main =
  Signal.map view state


state : Signal Model
state =
  Signal.foldp update init source.signal
