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
        , q Der "Kuss" "💏"
        , q Die "Familie" "👨\u{200D}👩\u{200D}👧"
        , q Die "Kraft" "💪🏾"
        , q Das "Ohr" "👂"
        , q Die "Nase" "👃"
        , q Das "Auge" "👁"
        , q Die "Zunge" "👅"
        , q Der "Mund" "👄"
        , q Das "Herz" "❤"
        , q Die "Bombe" "💣"
        , q Das "T-Shirt" "👕"
        , q Das "Kleid" "👗"
        , q Die "Tasche" "👜"
        , q Der "Rucksack" "🎒"
        , q Der "Schuh" "👞"
        , q Der "Stiefel" "👢"
        , q Die "Krone" "👑"
        , q Der "Hut" "👒"
        , q Der "Affe" "🐵"
        , q Die "Katze" "🐱"
        , q Der "Löwe" "🦁"
        , q Der "Tiger" "🐯"
        , q Das "Pferd" "🐴"
        , q Der "Hirsch" "🦌"
        , q Das "Einhorn" "🦄"
        , q Die "Kuh" "🐮"
        , q Das "Schwein" "🐷"
        , q Das "Schaf" "🐑"
        , q Die "Ziege" "🐐"
        , q Das "Kamel" "🐫"
        , q Der "Elefant" "🐘"
        , q Das "Nashorn" "🦏"
        , q Die "Maus" "🐭"
        , q Die "Ratte" "🐀"
        , q Der "Hamster" "🐹"
        , q Der "Hase" "🐰"
        , q Das "Kaninchen" "🐇"
        , q Die "Fledermaus" "🦇"
        , q Der "Bär" "🐻"
        , q Der "Vogel" "🐦"
        , q Die "Ente" "🦆"
        , q Die "Eule" "🦉"
        , q Der "Frosch" "🐸"
        , q Das "Krokodil" "🐊"
        , q Die "Schlange" "🐍"
        , q Der "Drache" "🐲"
        , q Der "Wal" "🐳"
        , q Der "Hai" "🦈"
        , q Der "Krebs" "🦀"
        , q Der "Schmetterling" "🦋"
        , q Die "Raupe" "🐛"
        , q Die "Ameise" "🐜"
        , q Die "Spinne" "🕷"
        , q Das "Huhn" "🐔"
        , q Das "Wildschwein" "🐗"
        , q Die "Schnecke" "🐌"
        , q Die "Biene" "🐝"
        , q Der "Marienkäfer" "🐞"
        , q Der "Fisch" "🐟"
        , q Die "Schildkröte" "🐢"
        , q Das "Küken" "🐣"
        , q Der "Pinguin" "🐧"
        , q Der "Delfin" "🐬"
        , q Die "Brille" "👓"
        , q Die "Hose" "👖"
        , q Der "Baum" "🌳"
        , q Der "Kaktus" "🌵"
        , q Das "Blatt" "🍃"
        , q Die "Melone" "🍉"
        , q Die "Zitrone" "🍋"
        , q Die "Banane" "🍌"
        , q Die "Ananas" "🍍"
        , q Der "Apfel" "🍎"
        , q Die "Birne" "🍐"
        , q Der "Pfirsich" "🍑"
        , q Die "Erdbeere" "🍓"
        , q Die "Kiwi" "🥝"
        , q Die "Tomate" "🍅"
        , q Die "Kartoffel" "🥔"
        , q Die "Karotte" "🥕"
        , q Der "Mais" "🌽"
        , q Die "Gurke" "🥒"
        , q Der "Pilz" "🍄"
        , q Das "Brot" "🍞"
        , q Das "Croissant" "🥐"
        , q Der "Käse" "🧀"
        , q Das "Fleisch" "🍗"
        , q Die "Pizza" "🍕"
        , q Das "Ei" "🥚"
        , q Der "Salat" "🥗"
        , q Das "Popcorn" "🍿"
        , q Der "Reis" "🍚"
        , q Die "Nudelsuppe" "🍜"
        , q Das "Eis" "🍨"
        , q Der "Keks" "🍪"
        , q Der "Kuchen" "🎂"
        , q Die "Torte" "🍰"
        , q Die "Schokolade" "🍫"
        , q Das "Bonbon" "🍬"
        , q Der "Lolli" "🍭"
        , q Der "Honig" "🍯"
        , q Die "Milch" "🥛"
        , q Der "Kaffee" "☕"
        , q Der "Sekt" "🍾"
        , q Der "Wein" "🍷"
        , q Das "Bier" "🍺"
        , q Das "Besteck" "🍴"
        , q Der "Löffel" "🥄"
        , q Das "Messer" "🔪"
        , q Die "Erde" "🌍"
        , q Der "Berg" "⛰"
        , q Der "Vulkan" "🌋"
        , q Das "Haus" "🏠"
        , q Das "Krankenhaus" "🏥"
        , q Die "Bank" "🏦"
        , q Die "Kirche" "⛪"
        , q Die "Lok" "🚂"
        , q Der "Zug" "🚄"
        , q Die "Eisenbahn" "🚆"
        , q Die "U-Bahn" "🚇"
        , q Die "Straßenbahn" "🚋"
        , q Der "Bus" "🚌"
        , q Das "Auto" "🚗"
        , q Der "Lastwagen" "🚛"
        , q Das "Fahrrad" "🚲"
        , q Das "Motorrad" "🏍"
        , q Die "Ampel" "🚦"
        , q Das "Schild" "🛑"
        , q Der "Anker" "⚓"
        , q Das "Boot" "🛶"
        , q Das "Schiff" "🚢"
        , q Das "Flugzeug" "✈"
        , q Der "Hubschrauber" "🚁"
        , q Die "Rakete" "🚀"
        , q Die "Tür" "🚪"
        , q Das "Bett" "🛌"
        , q Das "Klo" "🚽"
        , q Die "Toilette" "🚽"
        , q Die "Dusche" "🚿"
        , q Die "Badewanne" "🛁"
        , q Die "Armbanduhr" "⌚"
        , q Der "Wecker" "⏰"
        , q Die "Uhr" "🕑"
        , q Der "Mond" "🌛"
        , q Das "Thermometer" "🌡"
        , q Die "Temperatur" "🌡"
        , q Der "Stern" "⭐"
        , q Die "Wolke" "☁"
        , q Das "Wetter" "⛅"
        , q Das "Gewitter" "⛈"
        , q Der "Regen" "🌧"
        , q Der "Regenbogen" "🌈"
        , q Der "Regenschirm" "☂"
        , q Der "Blitz" "⚡"
        , q Der "Schnee" "🌨"
        , q Die "Schneeflocke" "❄"
        , q Das "Feuer" "🔥"
        , q Das "Wasser" "💧"
        , q Der "Tropfen" "💧"
        , q Die "Welle" "🌊"
        , q Der "Luftballon" "🎈"
        , q Das "Geschenk" "🎁"
        , q Der "Ball" "⚽"
        , q Der "Würfel" "🎲"
        , q Die "Glocke" "🔔"
        , q Die "Musik" "🎶"
        , q Das "Saxophon" "🎷"
        , q Die "Gitarre" "🎸"
        , q Das "Klavier" "🎹"
        , q Die "Trompete" "🎺"
        , q Die "Geige" "🎻"
        , q Die "Trommel" "🥁"
        , q Das "Handy" "📱"
        , q Das "Telefon" "☎"
        , q Die "Batterie" "🔋"
        , q Der "Stecker" "🔌"
        , q Der "Computer" "💻"
        , q Der "Film" "🎬"
        , q Die "Lupe" "🔍"
        , q Die "Kerze" "🕯"
        , q Die "Glühbirne" "💡"
        , q Die "Taschenlampe" "🔦"
        , q Das "Buch" "📖"
        , q Das "Papier" "📄"
        , q Die "Zeitung" "📰"
        , q Das "Geld" "💶"
        , q Die "Kreditkarte" "💳"
        , q Der "Briefkasten" "📮"
        , q Der "Bleistift" "✏"
        , q Der "Stift" "🖍"
        , q Der "Kugelschreiber" "🖊"
        , q Der "Kalender" "📅"
        , q Das "Lineal" "📏"
        , q Die "Schere" "✂"
        , q Das "Schloss" "🔒"
        , q Der "Schlüssel" "🔑"
        , q Der "Hammer" "🔨"
        , q Der "Einkaufswagen" "🛒"
        , q Die "Fahne" "🏴"
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
    , generateNewQuestion
    )


generateNewQuestion =
    Random.generate NewQuestion (Random.int 0 (Array.length questions - 1))


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
            let
                newQuestion =
                    Array.get index questions |> Maybe.withDefault defaultQuestion
            in
            ( InGame { model | question = newQuestion, errors = [] }
            , if newQuestion == model.question then
                generateNewQuestion

              else
                Cmd.none
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
    let
        ( pic, message ) =
            gameOverMessage score
    in
    column
        viewAttributes
        [ el [ centerX, Font.size 50 ] (text <| String.fromInt score ++ " Punkte")
        , bigPicture pic
        , text message
        , text "Schaffst du noch mehr?"
        , startButton "Nochmal"
        ]


gameOverMessage score =
    if score < 10 then
        ( "😐", "Nächstes Mal wird's bestimmt besser!" )

    else if score < 20 then
        ( "🙂", "Gut gemacht!" )

    else if score < 30 then
        ( "😎", "Mega!" )

    else if score < 40 then
        ( "😍", "Superduper!" )

    else if score < 50 then
        ( "🥳", "Juhu! Das war ja fantastisch!" )

    else
        ( "🦖", "Uuuuuaaaa! Ich bin ein T. Rex!" )


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
