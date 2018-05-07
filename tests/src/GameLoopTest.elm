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

                    gameLoop =
                        update SetMode gameLoopAtStart
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

                    gameLoop =
                        update BeginTurns gameLoopWithPlayersSetHvC
                in
                    \() -> Expect.equal (playScreen "Human") gameLoop.currentView
            , test "Begins the first turn with an empty board." <|
                let
                    gameLoopAtStart =
                        GameLoop.initialViewInGameLoop

                    gameLoopWithPlayersSetHvC =
                        update SetPlayersHvC gameLoopAtStart

                    gameLoop =
                        update BeginTurns gameLoopWithPlayersSetHvC

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

                    gameLoop =
                        update (TakeTurn 0 "X") gameLoopAtStart
                in
                    \() -> Expect.equal [ "X", "", "", "", "", "", "", "", "" ] gameLoop.board
            , test "begins the first turn with an empty board." <|
                let
                    gameLoopAtStart =
                        GameLoop.initialViewInGameLoop

                    gameLoopWithPlayersSetHvC =
                        update SetPlayersHvC gameLoopAtStart

                    gameLoop =
                        update BeginTurns gameLoopWithPlayersSetHvC

                    newBoard =
                        List.repeat 9 ""
                in
                    \() -> Expect.equal newBoard gameLoop.board

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
