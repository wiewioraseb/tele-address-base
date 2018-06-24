module Main exposing (..)

import DatePicker exposing (DateEvent(Changed), DatePicker, defaultSettings)
import Html

import View exposing ( view )
import Model exposing ( Model )
import Msg exposing ( Msg(..) )


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
        , surname = ""
        , date = Nothing
        , datePicker = datePicker
        , telephone = ""
        , email = ""
        , tickBool = False
        , validationErrors = 0
        }
            ! [ Cmd.map ToDatePicker datePickerFx ]

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of

    AcceptCompanyRules ->
        ({ model | tickBool = not model.tickBool }
            , Cmd.none)

    Name newName ->
        ({ model | name = newName }
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

    ValidationErrors value ->
        ({ model | validationErrors = model.validationErrors + value}
        , Cmd.none)

    NoOp ->
        (model, Cmd.none)