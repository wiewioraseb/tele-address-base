module Model exposing ( Model )

import Date exposing (Date)

-- MODEL
type alias Model =
    { intValue : Int
    , tickBool : Bool
    , name: String
    , surname: String
    , birthday: Date
    , telephone: Int
    , email: String
    }
