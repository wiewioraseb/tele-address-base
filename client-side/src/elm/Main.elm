module Main exposing (..)

import Char
import DatePicker exposing (DateEvent(Changed), DatePicker, defaultSettings)
import Html

import View exposing ( view )
import Model exposing (Model, NewTeleAddressEntry)
import Msg exposing ( Msg(..) )
import Types exposing (EmailStatus(EmptyEmail, InvalidEmail, ValidEmail), NameFirstCharStatus(NameFirstCharIsNotUpper, NameFirstCharIsUpper), NameLengthStatus(NameTooShort, NameValidLength), SurnameFirstCharStatus(SurnameFirstCharIsNotUpper, SurnameFirstCharIsUpper), SurnameLengthStatus(SurnameTooShort, SurnameValidLength), TelephoneStatus(EmptyTelephone, InvalidTelephone, ValidTelephone))



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
        , acceptTerms = False
        , ready = False
        , userEntries = []
        }
            ! [ Cmd.map ToDatePicker datePickerFx ]

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of

    AcceptCompanyRules ->
        ({ model | acceptTerms = not model.acceptTerms }
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
        validate ({ model | email = newEmail}
        , Cmd.none)

    Submit ->
        ({model | userEntries = model.userEntries ++ [(NewTeleAddressEntry model.name model.surname model.date model.telephone model.email model.acceptTerms)] }
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

        nameLengthStatus =
            if String.length model.name < 3 then
                NameTooShort
            else
                NameValidLength

        surnameFirstChar =
            if Char.isUpper (fromJustChar (List.head (String.toList model.surname))) then
                SurnameFirstCharIsUpper
            else
                SurnameFirstCharIsNotUpper

        surnameLengthStatus =
            if String.length model.surname < 3 then
                SurnameTooShort
            else
                SurnameValidLength

        telephoneStatus =
            let
                invalidTeleCharList = (String.toList model.telephone)
                    |> List.filter (\x-> x /= '-')
                    |> List.filter (\x-> not (Char.isDigit x))
                (result) =
                    if (String.length model.telephone) == 0 then
                        (EmptyTelephone)
                    else if (List.length invalidTeleCharList) == 0 then
                        (ValidTelephone)
                    else
                        (InvalidTelephone)
            in
                result

        emailStatus =
            if model.email == "" then
                EmptyEmail
            else if String.contains "@" model.email then
                ValidEmail
            else
                InvalidEmail


        ready =
            (nameFirstChar == NameFirstCharIsUpper)
                && (nameLengthStatus == NameValidLength)
                && (surnameFirstChar == SurnameFirstCharIsUpper)
                && (surnameLengthStatus == SurnameValidLength)
                && (telephoneStatus == ValidTelephone)
                && (emailStatus == ValidEmail)

    in
        ({ model
            | nameUpperCharValidation = nameFirstChar
            , nameLengthValidation = nameLengthStatus
            , surnameUpperCharValidation = surnameFirstChar
            , surnameLengthValidation = surnameLengthStatus
            , phoneNumberValidation = telephoneStatus
            , emailAddressValidation = emailStatus
--            , acceptTerms = ticked
            , ready = ready
        }, cmd)

fromJustChar : Maybe Char -> Char
fromJustChar x = case x of
    Just y -> y
    Nothing -> ' '