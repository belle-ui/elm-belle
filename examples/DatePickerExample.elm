module DatepickerExample (..) where

import Html exposing (..)
import Html.Attributes exposing (..)

import Belle.DatePicker as DatePicker
import Html.Attributes exposing (attribute, property)
import Signal
import Util
import Json.Encode exposing (string)

import Time exposing (every, second)
import Date exposing (year, hour, minute, second, fromTime)


type alias Model =
  { datepicker : DatePicker.Model }


init : Model
init =
  let
    config =
      DatePicker.defaultConfig
  in
    { datepicker = DatePicker.initWithConfig 2 config }


source : Signal.Mailbox Action
source =
  Signal.mailbox NoOp


type Action
  = NoOp
  | DatePicker DatePicker.Action


update : Action -> Model -> Model
update action model =
  case action of
    NoOp ->
      model

    DatePicker act ->
      let
        updatedDatepicker =
          DatePicker.update act model.datepicker
      in
        { model | datepicker = updatedDatepicker }


view : Model -> Html
view model =
  div
    []
    [ span [] [ text (toString model.datepicker) ]
    , div
        []
        [ DatePicker.view (Signal.forwardTo source.address DatePicker) model.datepicker ]
    , Util.stylesheetLink "/Datepicker-example.css"
    ]


main : Signal Html
main =
  Signal.map view state


state : Signal Model
state =
  Signal.foldp update init source.signal

