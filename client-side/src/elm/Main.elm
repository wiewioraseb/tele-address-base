module Main exposing (..)

import Date exposing (Date)
import Html

import View exposing ( view )
import Model exposing ( Model )
import Msg exposing ( Msg(..) )


-- APP
main : Program Never Model Msg
main =
  Html.beginnerProgram { model = model, view = view, update = update }

model : Model
model = Model "" "" (Date.fromTime 0) "" "" True

update : Msg -> Model -> Model
update msg model =
  case msg of

    AcceptCompanyRules ->
        { model | tickBool = not model.tickBool }

    Name newName ->
        { model | name = newName }

    Surname newSurname ->
        { model | surname = newSurname }

    Birthday newBirthday ->
        { model | birthday = newBirthday }

    Telephone newTelephone ->
        { model | telephone = newTelephone }

    Email newEmail ->
        { model | email = newEmail}

    NoOp ->
        model