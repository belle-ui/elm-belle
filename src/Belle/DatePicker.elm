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
import Date exposing (Date)
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
    value = 
      case model.value of
        Just date ->
          date 

        Nothing ->
          Date.fromTime time

    year = Debug.log "here" (Date.year value)
  in
    div
      []
      [ text (toString time) 
      , text (toString year)
      ]


-- helpers 


maybeDate : String -> Maybe Date
maybeDate string =
  Result.toMaybe (Date.fromString string)


