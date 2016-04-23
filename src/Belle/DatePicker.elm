module Belle.DatePicker ( 
      getCurrentTime
    ) where


import Native.DatePicker
import Task exposing (Task)
import Time exposing (Time)


getCurrentTime : Task x Time
getCurrentTime =
  Native.DatePicker.getCurrentTime