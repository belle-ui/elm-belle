module Belle.TextInput (view, update, Action, Model, init, initWithConfig, defaultConfig, Config, setTheme, setMaxHeight, getHeight) where

import Html exposing (Html, div, span, text, textarea)
import Html.Attributes exposing (classList, id, style)
import Html.Events exposing (targetValue, on)
import Signal exposing (Signal, Message)
import Array
import Json.Decode as Json exposing (..)
import Debug

import Native.TextInput
import Task exposing (Task)

-- Config


type alias Config =
  { maxHeight : Int
  , theme : String
  }


setMaxHeight : Int -> Config -> Config
setMaxHeight maxHeight config =
  { config | maxHeight = maxHeight }


setTheme : String -> Config -> Config
setTheme theme config =
  { config | theme = theme }


defaultConfig : Config
defaultConfig =
  { maxHeight = 600
  , theme = "defaultTheme"
  }



-- Model


type alias Model =
  { value : String
  , height : Int
  , config : Config
  }


init : String -> Model
init value =
  { value = value
  , height = 30
  , config = defaultConfig
  }


initWithConfig : String -> Config -> Model
initWithConfig value config =
  { value = value
  , height = 30
  , config = config
  }



-- Update


type Action
  = SetValue String


update : Action -> Model -> Model
update action model =
  case action of
    SetValue value ->
      { model | value = value, height = (getHeight 30) }


getHeight : Int -> Int
getHeight default =
  Native.TextInput.getHeight default


-- View


view : Signal.Address Action -> Model -> Html
view address model =
  let
    classes =
      [ ( "BelleRating", True ) ] ++ [ ( model.config.theme, True ) ]
  in
    div
      [ classList classes ]
      [ textarea 
          [ id "text-field"
          , on "input" targetValue (\str -> Signal.message address (SetValue str))
          , style [ ("height", (toString model.height) ++ "px") ] ]
          [ text model.value ]
        , div 
          [ id "BelleTextInputMeasure" ]
          [ text model.value ]
      ]

