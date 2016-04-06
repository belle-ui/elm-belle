module ButtonExample (..) where

import Html exposing (..)
import Html.Attributes exposing (..)
import Belle.Button as Button
import Signal
import StartApp.Simple as StartApp
import Util


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
update action before =
  case action of
    NoOp ->
      before

    Increment ->
      { before | count = before.count + 1 }

    Decrement ->
      { before | count = before.count - 1 }


--buttons : List Button.Button
--buttons =
--  [ { content = "+", primary = False, type' = "submit", disabled = False, onClick = Signal.message source.address Increment }
--  , { content = "-", primary = False, type' = "button", disabled = False, onClick = Signal.message source.address Decrement }
--  ]


single : Button.Button
single = 
  { content = "primary"
  , primary = True
  , type' = "button"
  , disabled = False
  , onClick = Signal.message source.address Decrement
  , hoverStyle = [ ( "color", "blue", "yellow" ) ]
  , focusStyle = [ ( "color", "blue", "red" ) ]
  }


view : State -> Html
view state =
  div
    []
    [ --span [] (List.map (\entry -> Button.view entry) buttons)
    span [] [ text (toString state.count) ]
    , div [] [ Button.view single ]
    , Util.stylesheetLink "/button-example.css"
    ]


main : Signal Html
main =
  Signal.map view state


state : Signal State
state =
  Signal.foldp update init source.signal
