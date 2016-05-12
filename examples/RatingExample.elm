module RatingExample exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)

import Belle.Rating as Rating
import Html.Attributes exposing (attribute, property)
import Html.App as App
import Util
import Json.Encode exposing (string)


type alias Model =
  { rating : Rating.Model }


init : Model
init =
  let
    config =
      Rating.defaultConfig
        |> Rating.setMaxRating 5
        |> Rating.setTheme "myTheme"
  in
    { rating = Rating.initWithConfig 2 config }


type Msg
  = Rating Rating.Msg


update : Msg -> Model -> Model
update msg previous =
  case msg of
    Rating ratingMsg ->
      let
        updatedRating =
          Rating.update ratingMsg previous.rating
      in
        { previous | rating = updatedRating }


view : Model -> Html Msg
view model =
  div
    []
    [ span [] [ text (toString model.rating) ]
    , div
        []
        [ App.map Rating (Rating.view model.rating) ]
    , Util.stylesheetLink "/rating-example.css"
    ]


main =
  App.beginnerProgram { model = init , view = view , update = update }
