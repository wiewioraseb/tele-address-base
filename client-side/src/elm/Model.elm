module Model exposing ( Model )

import Date exposing (Date)
import DatePicker


-- MODEL
type alias Model =
    { name: String
    , surname: String
    , date: Maybe Date
    , datePicker : DatePicker.DatePicker
    , telephone: String
    , email: String
    , tickBool : Bool
    , validationErrors : Int
    }
