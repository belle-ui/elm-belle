module ToggleExample (..) where

import Html exposing (..)
import Html.Attributes exposing (..)
import Belle.Toggle exposing (toggle)
--import BaseUI.Toggle exposing (belleAttribute)
import Html.Events exposing (onClick)
import Html.Attributes exposing (attribute, property, classList)
import Signal
import StartApp.Simple as StartApp
import Util
import Json.Encode exposing (string)
import Debug exposing (log)

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


handleToggle : Signal.Address Action -> Bool -> Signal.Message
handleToggle address bool =
  let
    action = if bool == True then Decrement else Increment
  in
    Signal.message address action


view : State -> Html
view state =
  div
    []
    [ span [] [ text (toString state.count) ]
    , div
      []
      [ toggle 
          [ onClick source.address Increment ]

          -- [ ("onClick", handleToggle source.address), ("value", True)]
          -- Problem with approach: 
            -- List must have element of same type
            -- Solved by: processing element which handles each type into a unified type
            -- e.g. : handleAttr : (String, Value) -> ToggleAttribute
            -- However, this looks ugly and it could be nice to use std attribute functions and not import costume ones

          -- [ onClick source.address Decrement, classList [("my-custom-class2", True)] ]
          -- Problem with approch:
            -- onClick, classList (...) turns the arguments into Attributes.
            -- This is problematic as we cannot read the arguments in the toggle module one processes by onClick (..)

          -- { onClick : handleToggle, value : True, class : "my-class" }
          -- Problem with approach:
            -- For compliance with the type the toggle module expects, one must specify every single propery expected.
            -- This means that if the toggle module should be able to handle a property called hoverStyle,
            -- this must be sent as { onClick : handleToggle, value : True, class : "my-class", hoverStyle: Nothing }
            -- even if we don't want to specify any hoverStyle

          -- Apparent options left:
            -- 1. As far as I know, JSON objects can be passed down and then properties can be handled even if not specified
            -- 2. Why are Html.Attributes properties not readable? Writable makes sense, but to remove possibility to obtain 
            --    knowledge from the dom/anywhere seems obscure

          [ text "Decrement" ]
      ]
    , Util.stylesheetLink "/toggle-example.css"
    ]


main : Signal Html
main =
  Signal.map view state


state : Signal State
state =
  Signal.foldp update init source.signal
