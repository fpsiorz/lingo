module Main exposing (..)

import Browser
import Element exposing (Element, alignRight, centerX, centerY, el, fill, padding, rgb255, row, spacing, text, width)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input


main =
    Browser.sandbox { init = init, view = view, update = update }


type Model
    = DerDieDas


type Msg
    = Der
    | Die
    | Das


init =
    DerDieDas


update msg model =
    model


view model =
    Element.layout [] buttonRow


buttonRow =
    row [ centerX, centerY, spacing 30 ]
        [ derButton
        , dieButton
        , dasButton
        ]


derButton =
    Input.button [] { onPress = Just Der, label = text "der" }


dieButton =
    Input.button [] { onPress = Just Die, label = text "die" }


dasButton =
    Input.button [] { onPress = Just Das, label = text "das" }
