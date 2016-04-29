module Belle.DatePicker.Helpers (maybeDate, validDate, daysInMonth, getLeapDay, getSafeYear, getSafeMonth, monthAsInt, dayAsInt, changeDate) where


import Date exposing (..)
import Time exposing (..)

maybeDate : String -> Maybe Date
maybeDate string =
  Result.toMaybe (Date.fromString string)


validDate : Time -> Maybe Date -> Date
validDate default value =
  case value of
    Just date ->
      date

    Nothing ->
      (Date.fromTime default)


daysInMonth : Date -> Int
daysInMonth date =
  let
    month =
      Date.month date

    monthInt =
      monthAsInt month

    leapDay =
      getLeapDay date
  in
    if month == Date.Feb then
      (28 + leapDay)
    else
      (31 - (monthInt - 1) % 7 % 2)


getLeapDay : Date -> Int
getLeapDay date =
  let
    year =
      Date.year date

    reminder4 =
      year % 4

    reminder100 =
      year % 100

    reminder400 =
      year % 400

    isLeapYear =
      reminder4 > 0 || reminder100 == 0 && reminder400 > 0
  in
    if isLeapYear then
      0
    else
      1


monthAsInt : Date.Month -> Int
monthAsInt month =
  case month of
    Date.Jan ->
      1

    Date.Feb ->
      2

    Date.Mar ->
      3

    Date.Apr ->
      4

    Date.May ->
      5

    Date.Jun ->
      6

    Date.Jul ->
      7

    Date.Aug ->
      8

    Date.Sep ->
      9

    Date.Oct ->
      10

    Date.Nov ->
      11

    Date.Dec ->
      12


dayAsInt : Date.Day -> Int
dayAsInt day =
  case day of
    Date.Mon ->
      0

    Date.Tue ->
      1

    Date.Wed ->
      2

    Date.Thu ->
      3

    Date.Fri ->
      4

    Date.Sat ->
      5

    Date.Sun ->
      6


type Changable
  = Day Int
  | Month Int


changeDate : Date -> Changable -> Maybe Date
changeDate date change =
  case change of
    Day day ->
      let
        month =
          Date.month date
            |> monthAsInt

        year =
          Date.year date
      in
        assembleDate year month day

    Month monthRaw ->
      let
        day =
          Date.day date

        month =
          monthRaw
            |> getSafeMonth

        year =
          Date.year date
            |> getSafeYear monthRaw
      in
        assembleDate year month day


assembleDate : Int -> Int -> Int -> Maybe Date
assembleDate year month day =
  let
    dateString =
      (toString year) ++ "/" ++ (toString month) ++ "/" ++ (toString day)
  in
    maybeDate dateString


getSafeMonth : Int -> Int
getSafeMonth month =
  case month of
    13 ->
      1

    0 ->
      12

    _ ->
      month


getSafeYear : Int -> Int -> Int
getSafeYear month year =
  case month of
    13 ->
      year + 1

    0 ->
      year - 1

    _ ->
      year