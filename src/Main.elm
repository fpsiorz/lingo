module Main exposing (..)

import Array
import Browser exposing (Document)
import Element exposing (Element, alignRight, centerX, centerY, column, el, fill, padding, px, rgb255, row, spacing, text, width)
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
    Browser.document { init = init, view = view, update = update, subscriptions = subscriptions }


subscriptions model =
    Time.every 1000 Tick


type Model
    = InGame InGameModel
    | Welcome
    | GameOver Score


type alias InGameModel =
    { question : Question
    , score : Int
    , errors : List Article
    , remainingSeconds : Int
    }


type alias Score =
    Int


type Msg
    = Answer Article
    | NewQuestion Int
    | Tick Time.Posix
    | StartGame


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
    ( Welcome, Cmd.none )


startGame =
    ( InGame
        { question = defaultQuestion
        , score = 0
        , errors = []
        , remainingSeconds = 60
        }
    , Random.generate NewQuestion (Random.int 0 (Array.length questions - 1))
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case model of
        InGame m ->
            updateInGame msg m

        Welcome ->
            updateWelcome msg

        GameOver score ->
            updateGameOver msg score


updateInGame : Msg -> InGameModel -> ( Model, Cmd Msg )
updateInGame msg model =
    case msg of
        Answer article ->
            if article == model.question.article then
                ( if model.errors == [] then
                    InGame { model | score = model.score + 1 }

                  else
                    InGame model
                , Random.generate NewQuestion (Random.int 0 (Array.length questions - 1))
                )

            else if List.member article model.errors then
                ( InGame model, Cmd.none )

            else
                ( InGame { model | errors = article :: model.errors, score = reduceScore model.score }
                , Cmd.none
                )

        NewQuestion index ->
            ( InGame { model | question = Array.get index questions |> Maybe.withDefault defaultQuestion, errors = [] }
            , Cmd.none
            )

        Tick _ ->
            if model.remainingSeconds == 0 then
                ( GameOver model.score, Cmd.none )

            else
                ( InGame { model | remainingSeconds = model.remainingSeconds - 1 }, Cmd.none )

        StartGame ->
            -- shouldn't be happening
            startGame


reduceScore score =
    if score - 2 <= 0 then
        0

    else
        score - 2


updateWelcome : Msg -> ( Model, Cmd Msg )
updateWelcome msg =
    case msg of
        StartGame ->
            startGame

        _ ->
            ( Welcome, Cmd.none )


updateGameOver : Msg -> Score -> ( Model, Cmd Msg )
updateGameOver msg score =
    case msg of
        StartGame ->
            startGame

        _ ->
            ( GameOver score, Cmd.none )


view : Model -> Document Msg
view model =
    { title = "der, die, das"
    , body = [ viewBody model ]
    }


viewBody : Model -> Html Msg
viewBody model =
    Element.layout [] <|
        case model of
            Welcome ->
                viewWelcome

            InGame inGameModel ->
                viewInGame inGameModel

            GameOver score ->
                viewGameOver score


viewAttributes =
    [ centerX
    , centerY
    , spacing 30
    , padding 30
    , Border.rounded 4
    , Border.width 1
    , Border.color darkGreen
    , Background.color lightGreen
    , width (px 400)
    ]


viewWelcome =
    column
        viewAttributes
        [ el [ centerX, Font.size 50 ] (text "Willkommen!")
        , text "Kannst du schon der, die, das?"
        , startButton "Start"
        ]


viewGameOver score =
    column
        viewAttributes
        [ el [ centerX, Font.size 50 ] (text <| String.fromInt score ++ " Punkte")
        , text "Schaffst du noch mehr?"
        , startButton "Nochmal"
        ]


startButton label =
    Input.button
        [ Background.color darkGreen
        , Font.color <| rgb255 255 255 255
        , Border.rounded 4
        , padding 10
        , centerX
        ]
        { onPress = Just StartGame, label = text label }


darkRed =
    rgb255 128 0 0


darkGreen =
    rgb255 0 128 0


lightGreen =
    rgb255 220 255 220


viewInGame : InGameModel -> Element Msg
viewInGame { question, score, errors, remainingSeconds } =
    column
        viewAttributes
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
                darkRed

            else
                darkGreen
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
