module ButtonExample (..) where

import Html exposing (..)
import Html.Attributes exposing (..)

import Belle.Button as Button
import Html.Attributes exposing (attribute, property)
import Signal
import Util
import Json.Encode exposing (string)


type alias Model =
  { firstButton : Button.Model }


init : Model
init =
  let
    config =
      Button.defaultConfig
        |> Button.setTheme "myfirstButtonTheme"
  in
    { firstButton = Button.initWithConfig (text "Follow Me") config }


source : Signal.Mailbox Action
source =
  Signal.mailbox NoOp


type Action
  = NoOp
  | TrackClick Button.Action


update : Action -> Model -> Model
update action previous =
  case action of
    NoOp ->
      previous

    TrackClick act ->
      previous


view : Model -> Html
view model =
  div
    []
    [ div
        []
        [ Button.view (Signal.forwardTo source.address TrackClick) model.firstButton ]
    , Util.stylesheetLink "/rating-example.css"
    ]


main : Signal Html
main =
  Signal.map view state


state : Signal Model
state =
  Signal.foldp update init source.signal
