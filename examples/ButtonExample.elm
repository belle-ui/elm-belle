module ButtonExample (..) where

import Html exposing (..)
import Html.Attributes exposing (..)
import Belle.Button as Button
import Signal
import StartApp.Simple as StartApp
import Util


main =
  StartApp.start { model = "", view = view, update = update }

model = 0


view address model =
  div
    []
    [ Button.view "hey"
    , Util.stylesheetLink "/button-example.css"
    ]


update model = model
