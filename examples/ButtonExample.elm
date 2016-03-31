module ButtonExample (..) where

import Html exposing (..)
import Html.Attributes exposing (..)
import Belle.Button as Button
import Signal
import StartApp.Simple as StartApp
import Util


main =
  StartApp.start { model = "", view = view, update = update }


view =
  div
    []
    [ Button.view
    , Util.stylesheetLink "/button-example.css"
    ]


update model = model
