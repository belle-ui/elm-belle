module Belle.Tooltip exposing (..)

import Html exposing (Html, div)
import Html.Events exposing (onMouseEnter, onMouseLeave)
import Html.Attributes exposing (classList, style)

import Debug

-- State

type alias State = Bool


type Msg = Show | Hide


update : Msg -> State -> State
update msg state =
  case msg of
    Show -> True
    Hide -> False


-- View

view : State -> (Html Msg, Html Msg) -> Html Msg
view visible (trigger, content) =
  let
    displayStyle =
      if visible then "inline" else "none"
  in
    div
      [ onMouseEnter Show
      , onMouseLeave Hide
      ]
      [ div [ style [ ("display", displayStyle) ] ] [ trigger ]
      , div [] [ content ]
      ]
