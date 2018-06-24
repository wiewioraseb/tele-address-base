module Main exposing (..)

import Char
import DatePicker exposing (DateEvent(Changed), DatePicker, defaultSettings)
import Html

import View exposing ( view )
import Model exposing ( Model )
import Msg exposing ( Msg(..) )
import Types exposing (EmailStatus(EmptyEmail, InvalidEmail, ValidEmail), NameFirstCharStatus(NameFirstCharIsNotUpper, NameFirstCharIsUpper), NameLengthStatus(NameTooShort), SurnameFirstCharStatus(SurnameFirstCharIsNotUpper), SurnameLengthStatus(SurnameTooShort), TelephoneStatus(InvalidTelephone))



-- APP
main : Program Never Model Msg
main =
  Html.program { view = view, update = update, init = init, subscriptions = always Sub.none }

init : ( Model, Cmd Msg )
init =
    let
        ( datePicker, datePickerFx ) =
            DatePicker.init
    in
        { name = ""
        , nameUpperCharValidation = NameFirstCharIsNotUpper
        , nameLengthValidation = NameTooShort
        , surname = ""
        , surnameUpperCharValidation = SurnameFirstCharIsNotUpper
        , surnameLengthValidation = SurnameTooShort
        , date = Nothing
        , datePicker = datePicker
        , telephone = ""
        , phoneNumberValidation = InvalidTelephone
        , email = ""
        , emailAddressValidation = EmptyEmail
        , tickBool = False
        , userEntries = []
        }
            ! [ Cmd.map ToDatePicker datePickerFx ]

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of

    AcceptCompanyRules ->
        ({ model | tickBool = not model.tickBool }
            , Cmd.none)

    Name newName ->
        validate ({ model | name = newName }
            , Cmd.none)

    Surname newSurname ->
        ({ model | surname = newSurname }
            , Cmd.none)

    ToDatePicker newBirthday ->
        let
                ( newDatePicker, datePickerFx, dateEvent ) =
                    DatePicker.update defaultSettings newBirthday model.datePicker

                newDate =
                    case dateEvent of
                        Changed newDate ->
                            newDate

                        _ ->
                            model.date
            in
                { model
                    | date = newDate
                    , datePicker = newDatePicker
                }
                    ! [ Cmd.map ToDatePicker datePickerFx ]

    Telephone newTelephone ->
        ({ model | telephone = newTelephone }
        , Cmd.none)

    Email newEmail ->
        ({ model | email = newEmail}
        , Cmd.none)

    Submit ->
        (model
        , Cmd.none)
    NoOp ->
        (model, Cmd.none)

validate (model, cmd) =
    let
        nameFirstChar =
            if Char.isUpper (fromJustChar (List.head (String.toList model.name))) then
                NameFirstCharIsUpper
            else
                NameFirstCharIsNotUpper


--        emailStatus =
--            if model.email == "" then
--                EmptyEmail
--            else if String.contains "@" model.email then
--                ValidEmail
--            else
--                InvalidEmail
--
--        lengthStatus =
--            if String.length model.password < 3 then
--                PasswordTooShort
--            else if String.length model.password > 120 then
--                PasswordTooLong
--            else
--                ValidPassword
--
--        matching =
--            model.password == model.confirmedPassword
--
--        ready =
--            (passwordStatus == ValidPassword)
--                && (emailStatus == ValidEmail)
--                && matching
    in
        ({ model
            | nameUpperCharValidation = nameFirstChar
--            , nameLengthValidation = nameLength
--            , surnameUpperCharValidation = surnameFirstChar
--            , surnameLengthValidation = surnameLength
--            , phoneNumberValidation = telephoneStatus
--            , emailAddressValidation = emailStatus
--            , tickBool = ready
        }, cmd)

fromJustChar : Maybe Char -> Char
fromJustChar x = case x of
    Just y -> y
    Nothing -> ' '