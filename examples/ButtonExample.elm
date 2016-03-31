module ButtonExample (..) where

import Html exposing (..)
import Html.Attributes exposing (..)
import Belle.Button as Button
import Signal
import StartApp.Simple as StartApp
import Util

main =
  StartApp.start { model = model, view = view, update = update }

model : List Button.Button
model = 
  [ { content = "hey", primary = True }
  , { content = "hey2", primary = False }
  ]


view address model =
  div
    []
    [ div 
      []
      ( List.map (\entry -> Button.view entry) model )
    , Util.stylesheetLink "/button-example.css"
    ]


update model = model
