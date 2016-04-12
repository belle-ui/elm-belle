module Stylesheets (..) where

import Css.File exposing (..)
import Belle.Button as Button
import Belle.Rating as Rating
import Belle.Toggle as Toggle


port files : CssFileStructure
port files =
  toFileStructure
    [ ( "button-example.css", compile Button.css )
    , ( "rating-example.css", compile Rating.css )
    , ( "toggle-example.css", compile Toggle.css )
    ]
