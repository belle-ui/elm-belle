module ButtonExample (..) where

import Html exposing (..)
import Html.Attributes exposing (..)
import Belle.Button exposing (belleButton)
import Core.Button exposing (coreButton)
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


--buttons : List Button.Button
--buttons =
--  [ { content = "+", primary = False, type' = "submit", disabled = False, onClick = Signal.message source.address Increment }
--  , { content = "-", primary = False, type' = "button", disabled = False, onClick = Signal.message source.address Decrement }
--  ]


view : State -> Html
view state =
  div
    []
    [ span [] [ text (toString state.count) ]
    --, span [] (List.map (\entry -> Button.view entry) buttons)
    , div
      []
      [ coreButton
        [ onClick source.address Increment
        , property "theme" (Json.Encode.object [ ("root", string "my-class") ])
        ]
        [ text "Yay" ]
      ]
    , Util.stylesheetLink "/button-example.css"
    ]


main : Signal Html
main =
  Signal.map view state


state : Signal State
state =
  Signal.foldp update init source.signal
