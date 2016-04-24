module Belle.DatePicker 
    ( Config, defaultConfig, setMinDate, setMaxDate, setTheme, defaultTime
    , Model, init, initWithConfig
    , Action, update
    , view
    ) where

import Html exposing (Html, div, span, text)
import Html.Attributes exposing (classList)
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
      { model | value = value }

    SetSuggestion value ->
      { model | suggesting = value }


-- View


view : Signal.Address Action -> Model -> Time -> Html
view address model time =
  let
    value = validDate model.value (Date.fromTime time)

    year = Debug.log "here" (Date.year value)
    daysInMonth' = Debug.log "daysInMonth" (daysInMonth value)

    createDay =
      (\day -> viewDay address model day)

    arrayOfDays =
      Array.initialize daysInMonth' createDay

    days =
      Array.toList arrayOfDays
  in
    div
      []
      [ text (toString time) 
      , text (toString year)
      , div 
        []
        days
      ]

viewDay : Signal.Address Action -> Model -> Int -> Html
viewDay address model day =
  let 
    classes = 
      [ ( "BelleDatePickerDay", True )
      , ( "BelleDatePickerHighlight", model.suggesting == model.value ) ]
  in
    span
      [ classList classes
      , onMouseOver address (SetSuggestion model.value)
      , on "touchenter" Json.value (\_ -> Signal.message address (SetValue model.value)) ]
      [ text (toString day), text " " ]

-- helpers 


maybeDate : String -> Maybe Date
maybeDate string =
  Result.toMaybe (Date.fromString string)


validDate : Maybe Date -> Date -> Date
validDate value default =
  case value of
    Just date ->
      date 

    Nothing ->
      default


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
