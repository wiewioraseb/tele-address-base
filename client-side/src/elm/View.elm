module View exposing ( view )

import Char
import Html exposing (..)
import Html.Attributes exposing (placeholder, style, type_)
import Html.Events exposing (onClick, onInput)
import List exposing (head, take)
import Model exposing ( Model )
import Msg exposing ( Msg(..) )
import String exposing (toList)



-- VIEW
-- Html is defined as: elem [ attribs ][ children ]
-- CSS can be applied via class names or inline style attrib
view : Model -> Html Msg
view model =
    div []
        [ input [ placeholder "Name", onInput Name  ] [ ]
        , firstCharValidation model.name
        , input [ placeholder "Surname", onInput Surname  ] [ ]
        , firstCharValidation model.surname
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

firstCharValidation : String -> Html msg
firstCharValidation fieldTextContent =
    let
        firstChar = fromJust (List.head (String.toList fieldTextContent))
        (color, message) =
            if Char.isUpper firstChar then
                ("green", "OK")
            else
                ("red", "First char must be uppercase")
    in
        div [ style [("color", color)] ] [ text message ]

checkbox : msg -> String -> Html msg
checkbox msg name =
  label
    [ style [("padding", "20px")]
    ]
    [ input [ type_ "checkbox", onClick msg ] []
    , text name
    ]

fromJust : Maybe Char -> Char
fromJust x = case x of
    Just y -> y
    Nothing -> ' '