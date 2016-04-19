module TooltipExample (..) where

import Html exposing (..)
import Html.Attributes exposing (..)

import Belle.Tooltip as Tooltip
import Html.Attributes exposing (attribute, property)
import Signal
import Util

type alias Model =
  { firstTooltip: Tooltip.Model
  }

init : Model
init =
  let
    config =
       Tooltip.defaultConfig
        |> Tooltip.setTheme "myfirstButtonTheme"
  in
    { firstTooltip = Tooltip.initWithConfig (text "Hi there") (text "I am a tooltip") config 
    }

source : Signal.Mailbox Action
source =
  Signal.mailbox NoOp

type Action
  = NoOp
  | UpdateTooltip Tooltip.Action

update : Action -> Model -> Model
update action model =
  case action of
    NoOp ->
      model

    UpdateTooltip act ->
      model

view : Model -> Html
view model =
  div
    []
    [ div
        []
        [ Tooltip.view (Signal.forwardTo source.address UpdateTooltip) model.firstTooltip
        ]

    , Util.stylesheetLink "/rating-example.css"
    ]

main : Signal Html
main =
  Signal.map view state

state : Signal Model
state =
  Signal.foldp update init source.signal
