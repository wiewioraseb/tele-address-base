module Main exposing (..)

import Html

import View exposing ( view )
import Model exposing ( Model )
import Msg exposing ( Msg(..) )

-- APP
main : Program Never Model Msg
main =
  Html.beginnerProgram { model = model, view = view, update = update }

model : Model
model = Model 0 True

update : Msg -> Model -> Model
update msg model =
  case msg of
    Increment ->
        { model | intValue = model.intValue + 1 }

    Decrement ->
        { model | intValue = model.intValue - 1 }

    ToggleNotifications ->
        { model | tickBool = not model.tickBool }

    NoOp ->
        model