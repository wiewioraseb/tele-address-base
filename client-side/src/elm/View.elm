module View exposing ( view )

import Html exposing (..)
import Html.Attributes exposing (placeholder, style, type_)
import Html.Events exposing (onClick, onInput)
import Model exposing ( Model )
import Msg exposing ( Msg(..) )


-- VIEW
-- Html is defined as: elem [ attribs ][ children ]
-- CSS can be applied via class names or inline style attrib
view : Model -> Html Msg
view model =
    div []
        [ input [ placeholder "Name", onInput Name  ] [ ]
        , viewNameValidation model
        , input [ placeholder "Surname", onInput Surname  ] [ ]
        , div [] [ text (String.reverse model.surname) ]
        , br [] []
--        , input [ placeholder "Birthday", onInput Birthday  ] [ ]
        , br [] []
        , input [ placeholder "Telephone", onInput Telephone  ] [ ]
        , br [] []
        , input [ placeholder "Email", onInput Email  ] [ ]
        , br [] []
        , checkbox AcceptCompanyRules "Accept company rules."
        ]

viewNameValidation : Model -> Html msg
viewNameValidation model =
    let
        (color, message) =
            if model.name == "cze" then
                ("green", "OK")
            else
                ("red", "Wrong name")
    in
        div [ style [("color", color)] ] [ text message ]

https://guide.elm-lang.org/architecture/user_input/forms.html
http://package.elm-lang.org/packages/elm-lang/core/latest/String
Sprawdzic czy pierwsza litera jest wielka litera

checkbox : msg -> String -> Html msg
checkbox msg name =
  label
    [ style [("padding", "20px")]
    ]
    [ input [ type_ "checkbox", onClick msg ] []
    , text name
    ]

