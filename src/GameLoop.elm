module GameLoop exposing (..)

import Views exposing (..)
import Html exposing (..)
import Array exposing (..)
import Set exposing (..)


main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



--model


type PlayerKind
    = Human
    | Computer


type alias Player =
    { name : String
    , piece : String
    , kind : PlayerKind
    }


type alias GameLoop =
    { currentView : Html Msg
    , players : { player1 : Player, player2 : Player }
    , board : List String
    , winner : Maybe Player
    }


init : ( GameLoop, Cmd Msg )
init =
    ( initialViewInGameLoop, Cmd.none )


initialViewInGameLoop =
    { currentView = welcomeScreen
    , players = { player1 = Player "Player1" "X" Human, player2 = Player "Player2" "O" Human }
    , board = List.repeat 9 ""
    , winner = Nothing
    }



--Update


type Msg
    = BeginPlay
    | SetMode
    | SetPlayersHvH
    | SetPlayersHvC
    | SetPlayersCvC
    | BeginTurns
    | TakeTurn Int String
    | ValidateMove Int String
    | InvalidMove
    | CheckForWin
    | SetWinner Player
    | DoNotSetWinner


update : Msg -> GameLoop -> ( GameLoop, Cmd Msg )
update msg gameLoop =
    case msg of
        BeginPlay ->
            ( { gameLoop | currentView = welcomeScreen }, Cmd.none )

        SetMode ->
            ( { gameLoop | currentView = modeMenuScreen }
            , Cmd.none
            )

        SetPlayersHvH ->
            ( { gameLoop | players = twoHumanPlayers, currentView = waitingToStartScreen }
            , Cmd.none
            )

        SetPlayersHvC ->
            ( { gameLoop | players = mixedPlayers, currentView = waitingToStartScreen }
            , Cmd.none
            )

        SetPlayersCvC ->
            ( { gameLoop | players = twoComputerPlayers, currentView = waitingToStartScreen }
            , Cmd.none
            )

        BeginTurns ->
            ( { gameLoop | currentView = (playScreen (getPlayerInTurn gameLoop) TakeTurn gameLoop.board) }
            , Cmd.none
            )

        TakeTurn position piece ->
            ( { gameLoop
                | board = (markBoard position piece gameLoop.board)
                , currentView =
                    playScreen (getPlayerInTurn gameLoop) ValidateMove (markBoard position piece gameLoop.board)
              }
            , Cmd.none
            )

        ValidateMove position piece ->
            (runValidation position gameLoop piece)

        InvalidMove ->
            ( gameLoop, Cmd.none )

        CheckForWin ->
            (checkBoardForWinningCombination gameLoop)

        SetWinner player ->
            ( { gameLoop | winner = Just player }, Cmd.none )

        DoNotSetWinner ->
            ( gameLoop, Cmd.none )


checkBoardForWinningCombination gameLoop =
    let
        board =
            gameLoop.board
    in
        if gameLoop.board == [ "X", "X", "X", "", "", "", "", "", "" ] then
            update (SetWinner gameLoop.players.player1) gameLoop
        else
            update DoNotSetWinner gameLoop



--getValuesFromMaybeListOfStrings : Maybe List String -> List String
--getValuesFromMaybeListOfStrings maybeListOfStrings =
--    case maybeListOfStrings of
--        Just (Just (List String)) ->
--            List String
--        Nothing ->
--            Nothing
--isRowWon : List (Maybe String) -> Bool
--isRowWon row =
--    let
--        pieceToCheckFor =
--            List.head row
--    in
--        List.all (\cellValue -> cellValue == pieceToCheckFor) row


split : Int -> List String -> List (List String)
split i list =
    case List.take i list of
        [] ->
            []

        listHead ->
            listHead :: split i (List.drop i list)


getAt : List a -> Int -> Maybe a
getAt xs index =
    List.head <| List.drop index xs



--rowIsWon : List a -> Bool
--rowIsWon row =
--    let
--        [ x, y, z ] =
--            [ getAt row 0, getAt row 1, getAt row 2 ]
--    in
--        x == y && y == z


justValue justElement =
    case justElement of
        Just element ->
            element

        Nothing ->
            ""


isBoardWon board =
    let
        winningCombos =
            [ [ justValue (getAt board 0), justValue (getAt board 1), justValue (getAt board 2) ]
            , [ justValue (getAt board 0), justValue (getAt board 3), justValue (getAt board 6) ]
            , [ justValue (getAt board 0), justValue (getAt board 4), justValue (getAt board 8) ]
            , [ justValue (getAt board 3), justValue (getAt board 4), justValue (getAt board 5) ]
            , [ justValue (getAt board 1), justValue (getAt board 4), justValue (getAt board 7) ]
            , [ justValue (getAt board 6), justValue (getAt board 4), justValue (getAt board 2) ]
            , [ justValue (getAt board 6), justValue (getAt board 7), justValue (getAt board 8) ]
            , [ justValue (getAt board 2), justValue (getAt board 5), justValue (getAt board 8) ]
            ]

        isWonByO =
            List.any (\row -> row == [ "O", "O", "O" ]) winningCombos

        isWonByX =
            List.any (\row -> row == [ "X", "X", "X" ]) winningCombos
    in
        case ( isWonByX, isWonByO ) of
            ( True, _ ) ->
                ( True, "X", board )

            ( _, True ) ->
                ( True, "O", board )

            ( False, False ) ->
                ( False, "", board )


runValidation position gameLoop piece =
    let
        currentBoardAsArray =
            gameLoop.board |> Array.fromList

        currentValueAtPosition =
            currentBoardAsArray |> Array.get position
    in
        if currentValueAtPosition == Just "" then
            update (TakeTurn position piece) gameLoop
        else
            update InvalidMove gameLoop


markBoard position piece board =
    ((Array.fromList board) |> (Array.set position piece)) |> Array.toList


twoHumanPlayers =
    { player1 = Player "Player1" "X" Human, player2 = Player "Player2" "O" Human }


mixedPlayers =
    { player1 = Player "Player1" "X" Human, player2 = Player "Player2" "O" Computer }


twoComputerPlayers =
    { player1 = Player "Player1" "X" Computer, player2 = Player "Player2" "O" Computer }


getPlayerInTurn : GameLoop -> String
getPlayerInTurn gameLoop =
    if (((List.filter (\cellValue -> (cellValue /= "")) gameLoop.board) |> List.length) % 2) == 0 then
        gameLoop.players.player1.piece
    else
        gameLoop.players.player2.piece



--View


view model =
    div [] [ model.currentView ]


welcomeScreen =
    div [] [ welcome_screen SetMode ]


modeMenuScreen =
    div [] [ mode_menu_screen SetPlayersHvH SetPlayersHvC SetPlayersCvC ]


waitingToStartScreen =
    div [] [ waiting_to_start_screen BeginTurns ]


playScreen playerInTurn actionOnClick currentBoard =
    div [] [ game_play_screen playerInTurn actionOnClick currentBoard ]


subscriptions : GameLoop -> Sub Msg
subscriptions model =
    Sub.none



--4. 8:30 "When the user hits the "Start Game" button a turn_loop
--    is started in the desired mode with an empty board and
--    player 1 in turn."
--5. 9:30 "When the player clicks on a board cell that is owned nothing happens"
--6. 10:30 "When the player clicks on a board cell that is not owned:
--    - the board is Marked.
--    - the board is checked for a win
--      - if won then Game { state : Won, winner : Player }
--      - if not won then Game { state : InProgress, winner : Nothing }
--    - the board is checked if it is full
--      - if full then Game { state : Drawn, winner : Nothing }
--      - if notFull then Game { state : InProgress, winner : Maybe.Nothing }"
--7. 11:30 "A new turn loop begins with the players switched"
