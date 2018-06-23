module Main exposing (..)

import Date exposing (Date)
import DatePicker exposing (DateEvent(Changed), DatePicker, defaultSettings)
import Html

import View exposing ( view )
import Model exposing ( Model )
import Msg exposing ( Msg(..) )


-- APP
main : Program Never Model Msg
main =
  Html.beginnerProgram { model = model, view = view, update = update }

model : Model
model = Model "" "" (Just (Date.fromTime 0)) (Tuple.first DatePicker.init) "" "" True

--init : ( Model, Cmd Msg )
--init =
--    let
--        ( datePicker, datePickerFx ) =
--            DatePicker.init
--    in
--        { model | date = Nothing
--        , datePicker = datePicker
--        }
--            ! [ Cmd.map ToDatePicker datePickerFx ]

update : Msg -> Model -> Model
update msg model =
  case msg of

    AcceptCompanyRules ->
        { model | tickBool = not model.tickBool }

    Name newName ->
        { model | name = newName }

    Surname newSurname ->
        { model | surname = newSurname }

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
--                    ! [ Cmd.map ToDatePicker datePickerFx ]



    Telephone newTelephone ->
        { model | telephone = newTelephone }

    Email newEmail ->
        { model | email = newEmail}

    NoOp ->
        model