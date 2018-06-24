module Msg exposing ( Msg(..) )

import Date exposing (Date)
import DatePicker



-- UPDATE
type Msg = NoOp
        | Name String
        | Surname String
        | ToDatePicker DatePicker.Msg
        | Telephone String
        | Email String
        | Submit

