module Model exposing ( Model )

import Date exposing (Date)
import DatePicker
import Types exposing (EmailStatus, NameFirstCharStatus, NameLengthStatus, SurnameFirstCharStatus, SurnameLengthStatus, TelephoneStatus)



-- MODEL
type alias Model =
    { name: String
    , nameUpperCharValidation: NameFirstCharStatus
    , nameLengthValidation: NameLengthStatus
    , surname: String
    , surnameUpperCharValidation: SurnameFirstCharStatus
    , surnameLengthValidation: SurnameLengthStatus
    , date: Maybe Date
    , datePicker : DatePicker.DatePicker
    , telephone: String
    , phoneNumberValidation: TelephoneStatus
    , email: String
    , emailAddressValidation: EmailStatus
    , tickBool : Bool
    , userEntries: List NewTeleAddressEntry
    }

type alias NewTeleAddressEntry =
    { name: String
    , surname: String
    , date: Maybe Date
    , telephone: String
    , email: String
    , tickBool : Bool
    }
