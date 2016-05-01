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
import Belle.DatePicker.Helpers exposing (validateDate, changeDay, changeMonth, daysInMonth, dayOfWeek, getYear)


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
    choosen = 
      model.value

    suggestion =
      model.suggesting

    days =
      createDays address suggestion choosen

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


createDays : Signal.Address Action -> DateTuple -> DateTuple -> List Html
createDays address (day, month, year) choosen =
  let
    date =
      (day, month, year)

    prefix =
      (1, month, year)
      |> dayOfWeek

    prev =
      changeMonth (day, month, year) (month-1)

    daysInPrev =
      daysInMonth prev

    prefixDate =
      changeDay prev (daysInPrev-prefix+1)

    next =
      changeMonth date (month+1)

    daysInMonth' =
      daysInMonth date

    postfix =
      42 - daysInMonth' - prefix

    createDay =
      (\(init, month, year) day -> viewDay address (init+day, month, year) choosen)

    prefixDays =
      Array.initialize prefix (createDay prefixDate)

    days =
      Array.initialize daysInMonth' (createDay (1, month, year))

    postfixDays =
      Array.initialize postfix (createDay next)
  in
    Array.toList prefixDays
      ++ Array.toList days
      ++ Array.toList postfixDays


viewDay : Signal.Address Action -> DateTuple -> DateTuple -> Html
viewDay address (day, month, year) (choosenDay, choosenMonth, choosenYear) =
  let
    date =
      (day, month, year)

    highlight =
      day == choosenDay && month == choosenMonth && year == choosenYear

    classes =
      [ ( "BelleDatePickerDay", True )
      , ( "BelleDatePickerDayHighlight", highlight )
      ]

    attr =
      [ classList classes
      , onClick address (SetValue date)
      ]
  in
    div
      attr
      [ text (toString day) ]


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