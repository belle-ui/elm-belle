module Belle.DatePicker (Action, update, view) where

import Html exposing (Html, div, span, text)
import Html.Attributes exposing (classList, class)
import Html.Events exposing (on, onClick, onMouseOver, onMouseLeave)
import Signal exposing (Signal, Message)
import Array
import Json.Decode as Json
import Time exposing (Time)
import Date exposing (Date, Month)
import Debug


import Belle.DatePicker.Config exposing (Config, DateTuple)
import Belle.DatePicker.Model exposing (Model)
import Belle.DatePicker.Helpers exposing (validateDate, changeMonth, daysInMonth, dayOfWeek, getYear)


-- Update


type Action
  = SetValue DateTuple
  | SetSuggestion DateTuple


update : Action -> Model -> Model
update action model =
  case action of
    SetValue date ->
      { model | value = date, suggesting = date }

    SetSuggestion date ->
      { model | suggesting = date }



-- View


view : Signal.Address Action -> Model -> Html
view address model =
  let
    picked = 
      model.value

    suggestion =
      model.suggesting

    days =
      createDays address suggestion

    classes =
      [ ( "BelleDatePicker", True ) ]
  in
    div
      [ classList classes ]
      [ text (toString (getYear suggestion))
      , div [] [ viewMonth address suggestion ]
      , div [] viewWeekDays
      , div [] days
      ]


viewMonth : Signal.Address Action -> DateTuple -> Html
viewMonth address (day, month, year) =
  let
    date =
      (day, month, year)

    prevMonth =
      changeMonth date (month - 1)

    nextMonth =
      changeMonth date (month + 1)
  in
    div
      []
      [ span [ onClick address (SetSuggestion prevMonth) ] [ text "<" ]
      , text (toString month)
      , span [ onClick address (SetSuggestion nextMonth) ] [ text ">" ]
      ]


viewWeekDays : List Html
viewWeekDays =
  [ div [ class "BelleDatePickerDayClass" ] [ text "Mo" ]
  , div [ class "BelleDatePickerDayClass" ] [ text "Tu" ]
  , div [ class "BelleDatePickerDayClass" ] [ text "We" ]
  , div [ class "BelleDatePickerDayClass" ] [ text "Th" ]
  , div [ class "BelleDatePickerDayClass" ] [ text "Fr" ]
  , div [ class "BelleDatePickerDayClass" ] [ text "Sa" ]
  , div [ class "BelleDatePickerDayClass" ] [ text "Su" ]
  ]


createDays : Signal.Address Action -> DateTuple -> List Html
createDays address (day, month, year) =
  let
    date =
      (day, month, year)

    prevMonth =
      changeMonth date (month - 1)

    nextMonth =
      changeMonth date (month + 1)

    daysInMonth' =
      daysInMonth date

    daysInPrevMonth =
      daysInMonth prevMonth

    prefix =
      (1, month, year)
        |> dayOfWeek

    postfix =
      42 - daysInMonth' - prefix

    createDay =
      (\from (_, month, year) disabled day -> viewDay address (from + day, month, year) disabled)

    prefixDays =
      Array.initialize prefix (createDay (daysInPrevMonth - prefix) prevMonth True)

    days =
      Array.initialize daysInMonth' (createDay 0 date False)

    postfixDays =
      Array.initialize postfix (createDay 0 nextMonth True)
  in
    Array.toList prefixDays
      ++ Array.toList days
      ++ Array.toList postfixDays


viewDay : Signal.Address Action -> DateTuple -> Bool -> Html
viewDay address (dayZero, month, year) disabled =
  let
    day = 
      dayZero+1

    date =
      (day, month, year)

    classes =
      [ ( "BelleDatePickerDay", True )
        --, ( "BelleDatePickerDayHighlight", date == value )
      ]

    attr =
      [ classList classes
      , onClick address (SetValue date)
      ]
  in
    div
      attr
      [ text (toString day) ]


