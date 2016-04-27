module Belle.DatePicker 
    ( Config, defaultConfig, setMinDate, setMaxDate, setTheme, defaultTime
    , Model, init, initWithConfig
    , Action, update
    , view
    ) where

import Html exposing (Html, div, span, text)
import Html.Attributes exposing (classList, class)
import Html.Events exposing (on, onClick, onMouseOver, onMouseLeave)
import Signal exposing (Signal, Message)
import Array
import Json.Decode as Json

import Time exposing (Time)
import Date exposing (Date, Month)
import Debug


-- Config


type alias Config =
  { minDate : Maybe Date
  , maxDate : Maybe Date
  , theme : String
  }


setMinDate : String -> Config -> Config
setMinDate minDate config =
  { config | minDate = maybeDate minDate }


setMaxDate : String -> Config -> Config
setMaxDate maxDate config =
  { config | maxDate = maybeDate maxDate }


setTheme : String -> Config -> Config
setTheme theme config =
  { config | theme = theme }


defaultConfig : Config
defaultConfig =
  { minDate = maybeDate "2015/1/1"
  , maxDate = maybeDate "2017/1/1"
  , theme = "defaultTheme"
  }

defaultTime : Signal Time
defaultTime =
  Time.every Time.hour


-- Model


type alias Model =
  { value : Maybe Date
  , suggesting : Maybe Date
  , config : Config
  }


init : String -> Model
init value =
  { value = maybeDate value
  , suggesting = maybeDate value
  , config = defaultConfig
  }


initWithConfig : String -> Config -> Model
initWithConfig value config =
  { value = maybeDate value
  , suggesting = maybeDate value
  , config = config
  }


-- Update


type Action
  = SetValue (Maybe Date)
  | SetSuggestion (Maybe Date)


update : Action -> Model -> Model
update action model =
  case action of
    SetValue value ->
      { model | value = value, suggesting = value }

    SetSuggestion value ->
      { model | suggesting = value }


-- View


view : Signal.Address Action -> Model -> Time -> Html
view address model time =
  let
    value = 
      validDate time model.value 

    suggestion = 
      validDate time model.suggesting

    days = createDays address suggestion time

    classes = 
      [ ( "BelleDatePicker", True ) ]

  in
    div
      [ classList classes ]
      [ text (toString (Date.year suggestion)) 
      , div [] [ viewMonth address suggestion ]
      , div [] viewWeekDays
      , div [] days
      ]


viewMonth : Signal.Address Action -> Date -> Html 
viewMonth address date =
  let 
    monthInt = 
      monthAsInt (Date.month date)

    prevMonth = 
      changeDate date (Month (monthInt-1))
    
    nextMonth = 
      changeDate date (Month (monthInt+1))
  in 
    div 
      [ ]
      [ span [ onClick address (SetSuggestion prevMonth) ] [ text "<" ]
      , text (toString (Date.month date))
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


createDays : Signal.Address Action -> Date.Date -> Time -> List Html
createDays address date time = 
  let
    monthInt = 
      monthAsInt (Date.month date)

    prevMonth = 
      changeDate date (Month (monthInt-1))
      |> validDate time

    nextMonth = 
      changeDate date (Month (monthInt+1))
      |> validDate time

    daysInMonth' = 
      daysInMonth date

    daysInPrevMonth = 
      daysInMonth prevMonth

    day = 
      Date.day date

    prefix = 
      changeDate date (Day 1)
      |> validDate time
      |> Date.dayOfWeek
      |> dayAsInt

    postfix = 
      42 - daysInMonth' - prefix

    createDay =
      (\from value disabled day -> viewDay address value (from+day) time disabled)

    prefixDays =
      Array.initialize prefix (createDay (daysInPrevMonth-prefix) prevMonth True)

    days =
      Array.initialize daysInMonth' (createDay 0 date False)

    postfixDays =
      Array.initialize postfix (createDay 0 nextMonth True)
  in
    Array.toList prefixDays
    ++ Array.toList days
    ++ Array.toList postfixDays

viewDay : Signal.Address Action -> Date -> Int -> Time -> Bool -> Html
viewDay address value dayRaw time disabled =
  let 
    day = 
      dayRaw+1

    date = 
      changeDate value (Day day)

    classes = 
      [ ( "BelleDatePickerDay", True )
      --, ( "BelleDatePickerDayHighlight", date == value )
      ]

    attr = 
      [ classList classes
      , onClick address (SetValue date) ]

  in
    div
      attr
      [ text (toString day) ]


-- helpers 


maybeDate : String -> Maybe Date
maybeDate string =
  Result.toMaybe (Date.fromString string)


validDate : Time -> Maybe Date -> Date
validDate default value =
  case value of
    Just date ->
      date 

    Nothing ->
      (Date.fromTime default)


daysInMonth : Date -> Int
daysInMonth date =
  let
    month = Date.month date 
    monthInt = monthAsInt month
    leapDay = getLeapDay date
  in 
    if month == Date.Feb then (28 + leapDay) else (31 - (monthInt-1) % 7 % 2)


getLeapDay : Date -> Int
getLeapDay date =
  let
    year = Date.year date
    reminder4 = year % 4
    reminder100 = year % 100
    reminder400 = year % 400

    isLeapYear = reminder4 > 0 || reminder100 == 0 && reminder400 > 0
  in 
    if isLeapYear then 0 else 1


monthAsInt: Date.Month -> Int 
monthAsInt month =
  case month of
    Date.Jan -> 1
    Date.Feb -> 2
    Date.Mar -> 3
    Date.Apr -> 4
    Date.May -> 5
    Date.Jun -> 6
    Date.Jul -> 7
    Date.Aug -> 8
    Date.Sep -> 9
    Date.Oct -> 10
    Date.Nov -> 11
    Date.Dec -> 12


dayAsInt: Date.Day -> Int 
dayAsInt day =
  case day of
    Date.Mon -> 0
    Date.Tue -> 1
    Date.Wed -> 2
    Date.Thu -> 3
    Date.Fri -> 4
    Date.Sat -> 5
    Date.Sun -> 6


type Changable 
  = Day Int 
  | Month Int 


changeDate: Date -> Changable -> Maybe Date
changeDate date change =
  case change of 
    Day day ->
      let 
        month = 
          Date.month date
            |> monthAsInt

        year = Date.year date 
      in 
        assembleDate year month day

    Month monthRaw ->
      let 
        day = 
          Date.day date

        month = 
          monthRaw
            |> getSafeMonth

        year =
          Date.year date
            |> getSafeYear monthRaw
      in 
        assembleDate year month day


assembleDate : Int -> Int -> Int -> Maybe Date
assembleDate year month day =
  let 
    dateString = (toString year)++"/"++(toString month)++"/"++(toString day)
  in 
    maybeDate dateString


getSafeMonth : Int -> Int
getSafeMonth month =
  case month of
    13 -> 1
    0 -> 12
    _ -> month


getSafeYear : Int -> Int -> Int
getSafeYear month year =
  case month of
    13 -> year+1
    0 -> year-1
    _ -> year

