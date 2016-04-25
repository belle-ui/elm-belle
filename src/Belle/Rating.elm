module Belle.Rating (view, update, Action, Model, init, initWithConfig, defaultConfig, Config, setTheme, setMaxRating, getSuggestion) where

import Html exposing (Html, div, span, text)
import Html.Attributes exposing (classList)
import Html.Events exposing (on, onClick, onMouseOver, onMouseLeave)
import Signal exposing (Signal, Message)
import Array
import Json.Decode as Json

-- Config


type alias Config =
  { maxRating : Int
  , theme : String
  }


setMaxRating : Int -> Config -> Config
setMaxRating maxRating config =
  { config | maxRating = maxRating }


setTheme : String -> Config -> Config
setTheme theme config =
  { config | theme = theme }


defaultConfig : Config
defaultConfig =
  { maxRating = 6
  , theme = "defaultTheme"
  }



-- Model


type alias Model =
  { value : Int
  , suggesting : Int
  , config : Config
  }


init : Int -> Model
init value =
  { value = value
  , suggesting = value
  , config = defaultConfig
  }


initWithConfig : Int -> Config -> Model
initWithConfig value config =
  { value = value
  , suggesting = value
  , config = config
  }


-- Update


type Action
  = SetValue Int
  | SetSuggestion Int


update : Action -> Model -> Model
update action model =
  case action of
    SetValue value ->
      { model | value = value }

    SetSuggestion value ->
      { model | suggesting = value }


-- View


view : Signal.Address Action -> Model -> Html
view address model =
  let
    classes =
      [ ( "BelleRating", True ) ] ++ [ ( model.config.theme, True ) ]

    createStar =
      (\rating -> viewStar address model rating)

    arrayOfStars =
      Array.initialize model.config.maxRating createStar

    stars =
      Array.toList arrayOfStars
  in
    div
      [ classList classes
      , onClick address (SetValue model.suggesting)
      , onMouseLeave address (SetSuggestion model.value) ]
      stars


viewStar : Signal.Address Action -> Model -> Int -> Html
viewStar address model value =
  let 
    classes = 
      [ ( "BelleRatingValue", True )
      , ( "BelleRatingHighlight", model.suggesting >= value ) ]
  in
    span
      [ classList classes
      , onMouseOver address (SetSuggestion value)
      , on "touchenter" Json.value (\_ -> Signal.message address (SetValue value)) ]
      [ text "★" ]

-- get values


getSuggestion : Action -> Int
getSuggestion action =
  case action of
    SetSuggestion value ->
      value

    SetValue value ->
      -1



