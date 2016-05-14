module ButtonExample exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)

import Belle.Button as Button
import Html.Attributes exposing (attribute, property)
import Html.App as App
import Util

type alias Model =
  { firstButton : Button.Model
  , secondButton : Button.Model
  , counter: Int
  }


init : Model
init =
  let
    config =
      Button.defaultConfig
        |> Button.setTheme "myfirstButtonTheme"
  in
    { firstButton = Button.initWithConfig (text "Follow Me") config
    , secondButton = Button.init (text "Or follow me here")
    , counter = 0
    }


type Msg
  = TrackClick Button.Msg


update : Msg -> Model -> Model
update action model =
  case action of
    TrackClick msg ->
      { model | counter = model.counter + 1 }


view : Model -> Html Msg
view model =
  div
    []
    [ div
        []
        [ App.map TrackClick (Button.view model.firstButton)
        , App.map TrackClick (Button.view model.secondButton)
        , div
          []
          [ text ("Counter: " ++ toString model.counter) ]
        ]

    , Util.stylesheetLink "/button-example.css"
    ]


main =
  App.beginnerProgram { model = init , view = view , update = update }
