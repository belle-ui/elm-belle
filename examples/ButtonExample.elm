module ButtonExample (..) where

import Html exposing (..)
import Html.Attributes exposing (..)
import Belle.Button as Button
import Signal
import StartApp.Simple as StartApp
import Util


main =
  StartApp.start { model = model, view = view, update = update }

model : Button.Button
model = 
  { content = "hey"
  , primary = True 
  }


view address model =
  div
    []
    [ Button.view model
    , Util.stylesheetLink "/button-example.css"
    ]


update model = model
