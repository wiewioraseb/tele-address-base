module Model exposing ( Model )

import Date exposing (Date)

-- MODEL
type alias Model =
    { name: String
    , surname: String
    , birthday: Date
    , telephone: String
    , email: String
    , tickBool : Bool
    }
