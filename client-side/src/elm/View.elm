module View exposing ( view )

import Char
import Date exposing (Date)
import DatePicker exposing (defaultSettings)
import Html exposing (..)
import Html.Attributes exposing (placeholder, style, type_)
import Html.Events exposing (onClick, onInput)
import List exposing (head, take)
import Model exposing ( Model )
import Msg exposing ( Msg(..) )
import Regex exposing (regex)
import String exposing (toList)



-- VIEW
-- Html is defined as: elem [ attribs ][ children ]
-- CSS can be applied via class names or inline style attrib
view : Model -> Html Msg
view model =
    div []
        [ input [ placeholder "Name", onInput Name  ] [ ]
        , firstCharValidation model.name
        , minimumLengthValidation model.name
        , input [ placeholder "Surname", onInput Surname  ] [ ]
        , firstCharValidation model.surname
        , minimumLengthValidation model.surname
        , div [] [ text ("Look! What a funny name: " ++ (String.reverse model.surname)) ]
        , br [] []
--        , input [ placeholder "Birthday", onInput Birthday  ] [ ]
        , case model.date of
            Nothing ->
                h1 [] [ text "Pick a date" ]

            Just date ->
                h1 [] [ text (toString date) ]
        , DatePicker.view model.date defaultSettings model.datePicker
            |> Html.map ToDatePicker
        , br [] []
        , input [ placeholder "Telephone", onInput Telephone  ] [ ]
        , telephoneValidation model.telephone
        , br [] []
        , input [ placeholder "Email", onInput Email  ] [ ]
        , emailValidation model.email
        , br [] []
        , checkbox AcceptCompanyRules "Accept company rules."
        ]

--formatDate : Date -> String
--formatDate d =
--    toString (Date.month d) ++ " " ++ toString (Date.day d) ++ ", " ++ toString (Date.year d)


firstCharValidation : String -> Html msg
firstCharValidation fieldTextContent =
    let
        firstChar = fromJustChar (List.head (String.toList fieldTextContent))
        (color, message) =
            if Char.isUpper firstChar then
                ("green", "OK")
            else
                ("red", "First char must be uppercase")
    in
        div [ style [("color", color)] ] [ text message ]

minimumLengthValidation : String -> Html msg
minimumLengthValidation fieldTextContent =
    let
        (color, message) =
            if (String.length fieldTextContent) > 2 then
                ("green", "OK")
            else
                ("red", "Data provided is too short")
    in
        div [ style [("color", color)] ] [ text message ]

telephoneValidation : String -> Html msg
telephoneValidation fieldTextContent =
    let
        telephoneNumber = (String.toList fieldTextContent)
            |> List.filter (\x-> x /= '-')
            |> List.filter (\x-> not (Char.isDigit x))
        (color, message) =
            if (List.length telephoneNumber) == 0 then
                ("green", "OK")
            else
                ("red", "Telephone number can't consist of alphabetic characters and special sign except for '-'")
    in
        div [ style [("color", color)] ] [ text message ]

emailValidation : String -> Html msg
emailValidation fieldTextContent =
    let
        (color, message) =
            -- basic regex email validation
            if Regex.contains (regex "^\\S+@\\S+\\.\\S+$") fieldTextContent then
                ("green", "OK")
            else
                ("red", "Please, provide a valid email address")
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

fromJustChar : Maybe Char -> Char
fromJustChar x = case x of
    Just y -> y
    Nothing -> ' '