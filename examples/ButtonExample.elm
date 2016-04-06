module ButtonExample (..) where

import Html exposing (..)
import Html.Attributes exposing (..)
import Belle.Button as Button
import Signal
import StartApp.Simple as StartApp
import Util

type alias State = { count: Int }

init : State
init = { count = 1 }

source : Signal.Mailbox Action
source = Signal.mailbox NoOp

type Action = NoOp | Increment

update : Action -> State -> State
update action before =
  case action of
    NoOp ->
      before
    Increment ->
      { before | count = before.count + 1 }

buttons : List Button.Button
buttons = 
  [ { content = "hey4", primary = True, type' = "submit", disabled = False }
  , { content = "hey2", primary = False, type' = "button", disabled = True }
  ]

view : State -> Html
view state =
  div 
    []
    [ div [] ( List.map (\entry -> Button.view entry) buttons )
    , div [] [ text (toString state.count) ]
    ]
  

main : Signal Html
main = Signal.map view state
  
state : Signal State
state = Signal.foldp update init source.signal