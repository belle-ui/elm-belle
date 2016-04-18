module BaseUI.Rating (view, init, update, Action, Model) where

import Html exposing (Html, div, span, text, Attribute)
import Html.Attributes exposing (attribute)
import Html.Events exposing (on, onClick)
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


type Action
  = SetValue Int


update : Action -> Model -> Model
update action model =
  case action of 
    SetValue value ->
      { model | value = value }
      

view : Signal.Address Action -> Model -> Html
view address model =
  let
    createStar = (\rating -> viewStar address model rating)
    stars = Array.toList (Array.initialize model.config.maxRating createStar)
  in
    div
      []
      stars


viewStar : Signal.Address Action -> Model -> Int -> Html
viewStar address model value = 
  span 
    [ onClick address (SetValue value) ]
    [ text "★" ]

