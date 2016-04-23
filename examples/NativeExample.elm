module NativeExample (..) where

import Graphics.Element exposing (show)
import Task exposing (Task, andThen)
import Belle.DatePicker exposing (getCurrentTime)
import Time exposing (second, Time)
import Graphics.Element exposing (Element)

main : Signal Element
main =
  Signal.map show contentMailbox.signal


contentMailbox : Signal.Mailbox Float
contentMailbox =
  Signal.mailbox 0


port updateContent : Task x ()
port updateContent =
  getCurrentTime `andThen`
    Signal.send contentMailbox.address