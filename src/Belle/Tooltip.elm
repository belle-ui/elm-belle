module Belle.Tooltip exposing (..)

import Html exposing (Html, div)
import Html.Events exposing (onMouseEnter, onMouseLeave)
import Html.Attributes exposing (classList, style)
import Belle.TooltipCss as Style exposing (..)
import Css exposing (..)

styles =
    Css.asPairs >> Html.Attributes.style

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
    contentStyle =
      if visible then Style.content else Style.hiddenContent
  in
    div
      [ onMouseEnter Show
      , onMouseLeave Hide
      ]
      [ div [] [ trigger ]
      , div [ styles contentStyle ] [ content ]
      ]
