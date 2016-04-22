module TextInputExample (..) where

import Html exposing (..)
import Html.Attributes exposing (..)

import Belle.TextInput as TextInput
import Html.Attributes exposing (attribute, property)
import Signal
import Util
import Json.Encode exposing (string)
import Graphics.Element exposing (show)
import Debug


type alias Model =
  { textInput : TextInput.Model }


init : Model
init =
  { textInput = TextInput.init "hey" }


source : Signal.Mailbox Action
source =
  Signal.mailbox NoOp


type Action
  = NoOp
  | TextInput TextInput.Action


update : Action -> Model -> Model
update action model =
  case action of
    NoOp ->
      model

    TextInput act ->
      let
        updatedTextInput =
          TextInput.update act model.textInput
      in
        { model | textInput = updatedTextInput }


view : Model -> Int -> Html
view model height =
  let
    test = Debug.log "height" height
  in 
    div
      []
      [ span [] [ text (toString model.textInput) ]
      , div
          []
          [ TextInput.view (Signal.forwardTo source.address TextInput) model.textInput height ]
      , Util.stylesheetLink "/TextInput-example.css"
      ]


main : Signal Html
main =
  Signal.map2 view state textFieldHeight


state : Signal Model
state =
  Signal.foldp update init source.signal


-- ports


port textFieldHeight : Signal Int

