module GameLoopTest exposing (..)

import GameLoop exposing (..)
import Views exposing (welcome_screen)
import Expect exposing (Expectation)
import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (class)
import Test exposing (..)
import Test.Html.Query as Query
import Test.Html.Event as Event
import Test.Html.Selector exposing (text, tag)


gameLoopTest : Test
gameLoopTest =
    describe "GameLoop"
        [ describe "BeginPlay..."
            [ test "Displays the welcomeScreen." <|
                let
                    gameLoop =
                        GameLoop.initialViewInGameLoop
                in
                    \() -> Expect.equal welcomeScreen gameLoop.currentView
            , test "When the user hits the `Next` button they are presented with the mode_menu_screen." <|
                \() ->
                    Html.input [ onClick SetMode ] []
                        |> Query.fromHtml
                        |> Event.simulate (Event.click)
                        |> Event.expect (SetMode)
            ]
        , describe "SetMode..."
            [ test "Displays the modeMenuScreen." <|
                let
                    gameLoopAtStart =
                        GameLoop.initialViewInGameLoop

                    returned =
                        update SetMode gameLoopAtStart

                    ( gameLoop, command ) =
                        returned
                in
                    \() -> Expect.equal modeMenuScreen gameLoop.currentView
            , test "When the user hits the `Human Vs. Human` button the Players are set to Human Human." <|
                \() ->
                    Html.input [ onClick SetPlayersHvH ] []
                        |> Query.fromHtml
                        |> Event.simulate (Event.click)
                        |> Event.expect (SetPlayersHvH)
            , test "When the user hits the `Human Vs. Computer` button the Players are set to Human Computer." <|
                \() ->
                    Html.input [ onClick SetPlayersHvC ] []
                        |> Query.fromHtml
                        |> Event.simulate (Event.click)
                        |> Event.expect (SetPlayersHvC)
            , test "When the user hits the `Computer Vs. Computer` button the Players are set to Computer Computer." <|
                \() ->
                    Html.input [ onClick SetPlayersCvC ] []
                        |> Query.fromHtml
                        |> Event.simulate (Event.click)
                        |> Event.expect (SetPlayersCvC)
            ]
        , describe "BeginTurns..."
            [ test "Begins the first turn with prompt for the first player." <|
                let
                    gameLoopAtStart =
                        GameLoop.initialViewInGameLoop

                    gameLoopWithPlayersSetHvC =
                        update SetPlayersHvC gameLoopAtStart

                    ( gameLoopAfterPlayersSet, commandRun ) =
                        gameLoopWithPlayersSetHvC

                    gameLoopPromptingForMove =
                        update BeginTurns gameLoopAfterPlayersSet

                    ( gameLoop, command ) =
                        gameLoopPromptingForMove
                in
                    \() -> Expect.equal (playScreen "X" GameLoop.TakeTurn gameLoop.board) gameLoop.currentView
            , test "Begins the first turn with an empty board." <|
                let
                    gameLoopAtStart =
                        GameLoop.initialViewInGameLoop

                    gameLoopWithPlayersSetHvC =
                        update SetPlayersHvC gameLoopAtStart

                    ( gameLoop, command ) =
                        gameLoopWithPlayersSetHvC

                    gameLoopAtFirstTurn =
                        update BeginTurns gameLoop

                    newBoard =
                        List.repeat 9 ""
                in
                    \() -> Expect.equal newBoard gameLoop.board
            ]
        , describe "TakeTurn..."
            [ test "Updates the board." <|
                let
                    gameLoopAtStart =
                        GameLoop.initialViewInGameLoop

                    model =
                        update (TakeTurn 0 "X") gameLoopAtStart

                    ( gameLoop, cmd ) =
                        model
                in
                    \() -> Expect.equal [ "X", "", "", "", "", "", "", "", "" ] gameLoop.board
            , test "begins the first turn with an empty board." <|
                let
                    gameLoopAtStart =
                        GameLoop.initialViewInGameLoop

                    newBoard =
                        List.repeat 9 ""
                in
                    \() -> Expect.equal newBoard gameLoopAtStart.board
            , test "getPlayerInTurn returns Player1 when no moves have been made" <|
                let
                    gameLoopAtStart =
                        GameLoop.initialViewInGameLoop
                in
                    \() -> Expect.equal (getPlayerInTurn gameLoopAtStart) "X"
            , test "getPlayerInTurn returns Player2 when one move has been made" <|
                let
                    gameLoopAtStart =
                        GameLoop.initialViewInGameLoop

                    model =
                        update (TakeTurn 0 "X") gameLoopAtStart

                    ( gameLoop, cmd ) =
                        model
                in
                    \() -> Expect.equal (getPlayerInTurn gameLoop) "O"
            , test "getPlayerInTurn returns Player1 when two moves have been made" <|
                let
                    gameLoopAtStart =
                        GameLoop.initialViewInGameLoop

                    modelAfterOneMove =
                        update (TakeTurn 0 "X") gameLoopAtStart

                    ( gameLoopAfterFirstMove, cmd1 ) =
                        modelAfterOneMove

                    modelAfterTwoMoves =
                        update (TakeTurn 8 "O") gameLoopAfterFirstMove

                    ( gameLoop, cmd2 ) =
                        modelAfterTwoMoves
                in
                    \() -> Expect.equal "X" (getPlayerInTurn gameLoop)
            ]
        , describe "ValidateMove"
            [ test "does not update the board when user clicks on a cell that is already taken" <|
                let
                    gameLoopAtStart =
                        GameLoop.initialViewInGameLoop

                    modelAfterOneMove =
                        update (TakeTurn 0 "X") gameLoopAtStart

                    ( gameLoopAfterFirstMove, cmd1 ) =
                        modelAfterOneMove

                    modelAfterValidation =
                        update (ValidateMove 0 "O") gameLoopAfterFirstMove

                    ( gameLoopAfterInvalidSecondMove, cmd2 ) =
                        modelAfterValidation
                in
                    \() -> Expect.equal gameLoopAfterFirstMove gameLoopAfterInvalidSecondMove
            , test "does update the board when user clicks on a cell that is vacant" <|
                let
                    gameLoopAtStart =
                        GameLoop.initialViewInGameLoop

                    modelAfterOneMove =
                        update (TakeTurn 0 "X") gameLoopAtStart

                    ( gameLoopAfterFirstMove, cmd1 ) =
                        modelAfterOneMove

                    modelAfterValidation =
                        update (ValidateMove 1 "O") gameLoopAfterFirstMove

                    ( gameLoopAfterValidSecondMove, cmd2 ) =
                        modelAfterValidation
                in
                    \() -> Expect.notEqual gameLoopAfterFirstMove gameLoopAfterValidSecondMove
            , test "runValidation returns TakeTurn for move on vacant cell" <|
                let
                    gameLoopAtStart =
                        GameLoop.initialViewInGameLoop

                    gameLoopAfterValidMove =
                        (update (TakeTurn 5 "X") gameLoopAtStart)
                in
                    \() -> Expect.equal gameLoopAfterValidMove (GameLoop.runValidation 5 gameLoopAtStart "X")
            ]
        , describe "CheckForWin"
            [ test "sets winner when board has winning combination" <|
                let
                    gameLoopAtStart =
                        GameLoop.initialViewInGameLoop

                    gameLoopWithWinningBoard =
                        { gameLoopAtStart | board = [ "X", "X", "X", "", "", "", "", "", "" ] }

                    ( gameLoopAfterCheckingForWinner, cmd1 ) =
                        update CheckForWin gameLoopWithWinningBoard
                in
                    \() -> Expect.equal (Just gameLoopWithWinningBoard.players.player1) gameLoopWithWinningBoard.winner
            , describe "Win Possibilities"
                [ test "isBoardWon returns (True, winningPiece, board) if board matches win combination" <|
                    let
                        wonBoardFirstRowX =
                            [ "X", "X", "X", "", "", "", "", "", "" ]

                        wonBoardFirstRowO =
                            [ "O", "O", "O", "", "", "", "", "", "" ]

                        wonBoardSecondRowX =
                            [ "", "", "", "X", "X", "X", "", "", "" ]

                        wonBoardThirdRowO =
                            [ "", "", "", "X", "X", "", "O", "O", "O" ]

                        wonBoardFirstColX =
                            [ "X", "", "", "X", "O", "O", "X", "", "" ]

                        wonBoardDTLRO =
                            [ "O", "X", "", "X", "O", "O", "", "", "O" ]

                        expected =
                            [ ( True, "X", wonBoardFirstRowX )
                            , ( True, "O", wonBoardFirstRowO )
                            , ( True, "X", wonBoardSecondRowX )
                            , ( True, "O", wonBoardThirdRowO )
                            , ( True, "X", wonBoardFirstColX )
                            , ( True, "O", wonBoardDTLRO )
                            ]

                        actual =
                            [ (isBoardWon wonBoardFirstRowX)
                            , (isBoardWon wonBoardFirstRowO)
                            , (isBoardWon wonBoardSecondRowX)
                            , (isBoardWon wonBoardThirdRowO)
                            , (isBoardWon wonBoardFirstColX)
                            , (isBoardWon wonBoardDTLRO)
                            ]
                    in
                        \() ->
                            Expect.equal expected actual
                , test "isBoardWon returns (False, \"\", board) if board does not match a win combination" <|
                    let
                        unWonBoard =
                            [ "", "", "", "", "X", "", "", "", "O" ]
                    in
                        \() ->
                            Expect.equal ( False, "", unWonBoard ) (isBoardWon unWonBoard)
                ]

            --, test "When the playerInTurn is a Human a prompt for a move is displayed." <|
            --    \() ->
            --        Html.input [ onClick SetPlayersHvH ] []
            --            |> Query.fromHtml
            --            |> Event.simulate (Event.click)
            --            |> Query.fromHtml
            --            |> Query.contains [ div [] [ "Human click on a cell to place your marker." ] ]
            --, test "When the playerInTurn is a Computer a prompt to wait is displayed." <|
            --    \() ->
            --        Html.input [ onClick SetPlayersHvC ] []
            --            |> Query.fromHtml
            --            |> Event.simulate (Event.click)
            --            |> Query.fromHtml
            --            |> Query.contains [ div [] [ "The computer player is thinking..." ] ]
            ]
        ]
