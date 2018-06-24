module Types exposing ( NameFirstCharStatus(..), SurnameFirstCharStatus(..) , NameLengthStatus(..), SurnameLengthStatus(..), TelephoneStatus(..), EmailStatus(..) )

type NameFirstCharStatus
    = NameFirstCharIsUpper
    | NameFirstCharIsNotUpper

type SurnameFirstCharStatus
    = SurnameFirstCharIsUpper
    | SurnameFirstCharIsNotUpper

type NameLengthStatus
    = NameTooShort
    | NameValidLength

type SurnameLengthStatus
    = SurnameTooShort
    | SurnameValidLength

type TelephoneStatus
    = ValidTelephone
    | InvalidTelephone
    | EmptyTelephone

type EmailStatus
    = ValidEmail
    | InvalidEmail
    | EmptyEmail