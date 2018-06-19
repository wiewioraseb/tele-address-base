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
        [ button [onClick Increment] [ text ("Add 1 to " ++ toString model.intValue) ]
        , button [onClick Decrement] [ text ("Subtract 1 from " ++ toString model.intValue) ]
        , checkbox ToggleNotifications "Accept company rules."
        , br [] []
        , input [ placeholder "Name", onInput Change  ] [ ]
        , br [] []
        , input [ placeholder "Surname", onInput Change  ] [ ]
        , div [] [ text (String.reverse model.surname) ]
        , br [] []
        , input [ placeholder "Telephone", onInput Change  ] [ ]
        , br [] []
        , input [ placeholder "Email", onInput Change  ] [ ]
        ]
  
checkbox : msg -> String -> Html msg
checkbox msg name =
  label
    [ style [("padding", "20px")]
    ]
    [ input [ type_ "checkbox", onClick msg ] []
    , text name
    ]
