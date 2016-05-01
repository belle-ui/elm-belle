module Belle.DatePicker.Helpers 
  ( daysInMonth
  , dayOfWeek
  , changeDay
  , changeMonth
  , getYear
  , validateDate
  ) where


import Date exposing (..)
import Time exposing (..)
import String exposing (..)
import Debug


getYear : (Int, Int, Int) -> Int 
getYear (day, month, year) =
  year


validateDate : (Int, Int, Int) -> (Int, Int, Int)
validateDate (day, month, year) =
  let
    dateString =
      (toString year) ++ "/" ++ (toString month) ++ "/" ++ (toString day)

    maybeDate = Result.toMaybe (Date.fromString dateString)
  in 
    case maybeDate of
      Just date ->
        (day, month, year)

      Nothing ->
        (1, 1, 1970)


daysInMonth : (Int, Int, Int) -> Int
daysInMonth (_, month, year) =
  let
    leapDay =
      getLeapDay year
  in
    if month == 2 then
      (28 + leapDay)
    else
      (31 - (month - 1) % 7 % 2)


getLeapDay : Int -> Int
getLeapDay year =
  let
    isLeapYear =
      year%4 > 0 || year%100 == 0 && year%400 > 0
  in
    if isLeapYear then
      0
    else
      1


changeDay : (Int, Int, Int) -> Int -> (Int, Int, Int)
changeDay (day, month, year) newDay =
  (newDay, month, year)


changeMonth : (Int, Int, Int) -> Int -> (Int, Int, Int)
changeMonth (day, month, year) newMonth =
  let
    validMonth = 
      validateMonth newMonth

    validYear =
      validateYear newMonth year
  in
    (1, validMonth, validYear)


validateMonth : Int -> Int
validateMonth month =
  if month > 12 then
    month - 12
  else if month < 1 then
    12 + month
  else 
    month


validateYear : Int -> Int -> Int
validateYear month year =
  if month > 12 then
    year+1
  else if month < 1 then
    year-1
  else 
    year


dayOfWeek : (Int, Int, Int) -> Int -- Zeller's Rule
dayOfWeek (day, month, year) =
  let 
    zellerMonth = 
      validateMonth (month-2)

    zellerYear = 
      validateYear (month-2) year

    lastTwo =
      zellerYear
      |> toString
      |> String.right 2
      |> String.toInt
      |> Result.withDefault 0 

    firstTwo = 
      (zellerYear - lastTwo)
      |> Basics.toFloat
      |> (*)(1/100)
      |> round
      

    a = 
      (13*zellerMonth-1)
      |> Basics.toFloat
      |> (*)(1/5)
      |> floor

    b =
      (Basics.toFloat lastTwo)/4
      |> floor

    c = 
      (Basics.toFloat firstTwo)/4
      |> floor

    dayOfWeek = 
      (day + a + lastTwo + b + c - 2*firstTwo)%7

  in
    if dayOfWeek == 0 then 6 else dayOfWeek-1

