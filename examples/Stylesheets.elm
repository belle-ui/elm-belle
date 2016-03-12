module Stylesheets (..) where

import Css.File exposing (..)
import Belle.Accordion as Accordion


port files : CssFileStructure
port files =
  toFileStructure
    [ ( "accordion-example.css", compile Accordion.css ) ]
