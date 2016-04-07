module ButtonExample (..) where

import Html exposing (..)
import Html.Attributes exposing (..)
import Belle.Button exposing (button)
import Html.Events exposing (onClick)
import Html.Attributes exposing (attribute, property)
import Signal
import StartApp.Simple as StartApp
import Util
import Json.Encode exposing (string)


type alias State =
  { count : Int }


init : State
init =
  { count = 1 }


source : Signal.Mailbox Action
source =
  Signal.mailbox NoOp


type Action
  = NoOp
  | Increment
  | Decrement


update : Action -> State -> State
update action previous =
  case action of
    NoOp ->
      previous

    Increment ->
      { previous | count = previous.count + 1 }

    Decrement ->
      { previous | count = previous.count - 1 }


view : State -> Html
view state =
  div
    []
    [ span [] [ text (toString state.count) ]
    , div
        []
        [ Belle.Button.button
            [ onClick source.address Increment ]
            [ text "Increment" ]
        , Belle.Button.button
            [ onClick source.address Decrement
            , attribute "class" "my-custom-class2"
              -- this does not work :(
            ]
            [ text "Decrement" ]
        ]
    , Util.stylesheetLink "/button-example.css"
    ]


main : Signal Html
main =
  Signal.map view state


state : Signal State
state =
  Signal.foldp update init source.signal
