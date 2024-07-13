module Main exposing (..)

import Array
import Browser
import Element exposing (Element, alignRight, centerX, centerY, column, el, fill, padding, rgb255, row, spacing, text, width)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Html exposing (Html)
import Random
import Time


questions =
    Array.fromList
        [ q Der "Hund" "🐶"
        , q Die "Katze" "🐱"
        , q Das "Pferd" "🐴"
        , q Die "Schlange" "🐍"
        , q Das "Huhn" "🐔"
        , q Der "Elefant" "🐘"
        , q Das "Wildschwein" "🐗"
        , q Die "Schnecke" "🐌"
        , q Die "Biene" "🐝"
        , q Der "Marienkäfer" "🐞"
        , q Der "Fisch" "🐟"
        , q Die "Schildkröte" "🐢"
        , q Das "Küken" "🐣"
        , q Der "Pinguin" "🐧"
        , q Das "Kamel" "🐫"
        , q Der "Delfin" "🐬"
        , q Die "Maus" "🐭"
        , q Die "Brille" "👓"
        , q Die "Hose" "👖"
        ]


defaultQuestion =
    q Der "Hund" "🐶"


main =
    Browser.element { init = init, view = view, update = update, subscriptions = subscriptions }


subscriptions model =
    Time.every 1000 Tick


type alias Model =
    { question : Question
    , score : Int
    , errors : List Article
    , remainingSeconds : Int
    }


type Msg
    = Answer Article
    | NewQuestion Int
    | Tick Time.Posix


type Article
    = Der
    | Die
    | Das


type alias Question =
    { noun : String, article : Article, picture : String }


q : Article -> String -> String -> Question
q article noun picture =
    { article = article, noun = noun, picture = picture }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { question = defaultQuestion
      , score = 0
      , errors = []
      , remainingSeconds = 60
      }
    , Random.generate NewQuestion (Random.int 0 (Array.length questions - 1))
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Answer article ->
            if article == model.question.article then
                ( if model.errors == [] then
                    { model | score = model.score + 1 }

                  else
                    model
                , Random.generate NewQuestion (Random.int 0 (Array.length questions - 1))
                )

            else if List.member article model.errors then
                ( model, Cmd.none )

            else
                ( { model | errors = article :: model.errors, score = reduceScore model.score }
                , Cmd.none
                )

        NewQuestion index ->
            ( { model | question = Array.get index questions |> Maybe.withDefault defaultQuestion, errors = [] }
            , Cmd.none
            )

        Tick _ ->
            if model.remainingSeconds == 0 then
                ( model, Cmd.none )

            else
                ( { model | remainingSeconds = model.remainingSeconds - 1 }, Cmd.none )


reduceScore score =
    if score - 2 <= 0 then
        0

    else
        score - 2


view : Model -> Html Msg
view { question, score, errors, remainingSeconds } =
    Element.layout [] <|
        column
            [ centerX
            , centerY
            , spacing 30
            , padding 30
            , Border.rounded 4
            , Border.width 1
            , Border.color (rgb255 0 128 0)
            , Background.color (rgb255 220 255 220)
            ]
            [ topBar score remainingSeconds
            , bigPicture question.picture
            , buttonRow errors
            , nounText question.noun
            ]


topBar score seconds =
    row [ width fill, spacing 30 ]
        [ el [] (text <| String.fromInt seconds ++ "s")
        , el [ alignRight ] (text <| String.fromInt score ++ " P")
        ]


bigPicture emoji =
    el [ centerX, Font.size 100 ] (text emoji)


nounText noun =
    el [ centerX, Font.size 50 ] (text noun)


buttonRow errors =
    row [ spacing 30, centerX ]
        [ derButton errors
        , dieButton errors
        , dasButton errors
        ]


answerButton label article errors =
    Input.button
        [ Background.color <|
            if errors |> List.member article then
                rgb255 128 0 0

            else
                rgb255 0 128 0
        , Font.color <| rgb255 255 255 255
        , Border.rounded 4
        , padding 10
        ]
        { onPress = Just (Answer article), label = text label }


derButton errors =
    answerButton "der" Der errors


dieButton errors =
    answerButton "die" Die errors


dasButton errors =
    answerButton "das" Das errors
