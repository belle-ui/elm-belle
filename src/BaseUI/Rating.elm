module BaseUI.Rating (view, Rating, init, update, Action) where

import Html exposing (Html, div, span, text, Attribute)
import Html.Attributes exposing (attribute)
import Html.Events exposing (on)
import Json.Decode exposing (succeed)
import Signal exposing (Signal, Message)
import Array
import Json.Decode as Json

type alias Config = 
  { maxRating : Int
  , theme : String
  }

setMaxRating : Int -> Config -> Config
setMaxRating maxRating config =
  { config | maxRating = maxRating }


defaultConfig : Config
defaultConfig =
  { maxRating = 6
  , theme = "defaultTheme" }


type alias Model = 
  { value : Int
  , config : Config
  }


init : Int -> Model
init value =
  { value = value
  , config = defaultConfig
  }


initWithConfig: Int -> Config -> Model
initWithConfig value config =
  { value = value 
  , config = config }


type Rating 
  = Rating Model

type Action
  = SetValue Int


update : Action -> Rating -> Rating
update action (Rating model) =
  case action of 
    SetValue value ->
      (Rating ({ model | value = value }))
      

view : (Int -> Signal.Message) -> Rating -> Html
view address (Rating model) =
  let
    createStar = (\rating -> viewStar address (Rating model) rating)
    stars = Array.toList (Array.initialize model.config.maxRating createStar)
  in
    div
      []
      stars


viewStar : (Int -> Signal.Message) -> Rating -> Int -> Html
viewStar handleClick (Rating model) value = 
  span 
    [ on "click" Json.value (\_ -> handleClick (SetValue value)) ]
    [ text "★" ]