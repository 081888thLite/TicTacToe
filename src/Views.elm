module Views exposing (..)

import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import Array exposing (..)


welcome_screen actionOnClick =
    div
        [ class "w3-margin" ]
        [ h1
            [ class "w3-display-topmiddle w3-xxxlarge" ]
            [ text welcome_view_greeting ]
        , h2
            [ class "w3-display-middle" ]
            [ text welcome_view_prompt ]
        , button
            [ class "w3-display-bottommiddle w3-jumbo w3-btn w3-ripple w3-orange"
            , onClick (actionOnClick)
            ]
            [ text "Next" ]
        ]


welcome_view_greeting =
    "Welcome to tic tac toe."


welcome_view_prompt =
    "Hit the Next button to set the Game Mode"


mode_menu_screen humanVHumanAction humanVComputerAction computerVComputerAction =
    div []
        [ div
            [ class "w3-margin" ]
            [ h1
                [ class "w3-display-topmiddle w3-xxxlarge" ]
                [ text "Set Mode" ]
            ]
        , div
            [ class "w3-display-middle" ]
            [ div
                [ class "w3-bar" ]
                [ button
                    [ class "w3-large w3-btn w3-ripple w3-orange"
                    , onClick (humanVHumanAction)
                    ]
                    [ text "Human vs. Human" ]
                , button
                    [ class "w3-large w3-btn w3-ripple w3-orange"
                    , onClick (humanVComputerAction)
                    ]
                    [ text "Human vs. Computer" ]
                , button
                    [ class "w3-large w3-btn w3-ripple w3-orange"
                    , onClick (computerVComputerAction)
                    ]
                    [ text "Computer vs. Computer" ]
                ]
            ]
        ]


waiting_to_start_screen startTheGame =
    div
        [ class "w3-display-middle w3-xxxlarge"
        , onClick (startTheGame)
        ]
        [ div [ id "1", class "w3-button w3-container w3-cell w3-orange w3-border w3-hover-border-black" ]
            [ p []
                [ text "Start Game" ]
            ]
        ]


game_play_screen playerInTurn actionToMarkCell currentBoard =
    div []
        [ div
            [ class "w3-display-topmiddle w3-jumbo w3-margin" ]
            [ text "TicTacToe" ]
        , div
            [ class "w3-display-middle w3-xxxlarge" ]
            [ div
                [ class "w3-cell-row" ]
                [ div
                    [ id "1"
                    , class "w3-button w3-container w3-cell w3-orange w3-border w3-hover-border-black"
                    , style [ ( "width", "33%" ) ]
                    , onClick (actionToMarkCell 0 playerInTurn)
                    ]
                    [ p
                        []
                        [ text ((Array.get 0 (currentBoard |> Array.fromList) |> makeDisplayable)) ]
                    ]
                , div
                    [ id "2"
                    , class "w3-button w3-container w3-cell w3-orange w3-border w3-hover-border-black"
                    , style [ ( "width", "33%" ) ]
                    , onClick (actionToMarkCell 1 playerInTurn)
                    ]
                    [ p
                        []
                        [ text ((Array.get 1 (currentBoard |> Array.fromList) |> makeDisplayable)) ]
                    ]
                , div
                    [ id "3"
                    , class "w3-button w3-container w3-cell w3-orange w3-border w3-hover-border-black"
                    , style [ ( "width", "33%" ) ]
                    , onClick (actionToMarkCell 2 playerInTurn)
                    ]
                    [ p
                        []
                        [ text ((Array.get 2 (currentBoard |> Array.fromList) |> makeDisplayable)) ]
                    ]
                ]
            , div
                [ class "w3-cell-row" ]
                [ div
                    [ id "4"
                    , class "w3-button w3-container w3-cell w3-orange w3-border w3-hover-border-black"
                    , style [ ( "width", "33%" ) ]
                    , onClick (actionToMarkCell 3 playerInTurn)
                    ]
                    [ p
                        []
                        [ text ((Array.get 3 (currentBoard |> Array.fromList) |> makeDisplayable)) ]
                    ]
                , div
                    [ id "5"
                    , class "w3-button w3-container w3-cell w3-orange w3-border w3-hover-border-black"
                    , style [ ( "width", "33%" ) ]
                    , onClick (actionToMarkCell 4 playerInTurn)
                    ]
                    [ p
                        []
                        [ text ((Array.get 4 (currentBoard |> Array.fromList) |> makeDisplayable)) ]
                    ]
                , div
                    [ id "6"
                    , class "w3-button w3-container w3-cell w3-orange w3-border w3-hover-border-black"
                    , style [ ( "width", "33%" ) ]
                    , onClick (actionToMarkCell 5 playerInTurn)
                    ]
                    [ p
                        []
                        [ text ((Array.get 5 (currentBoard |> Array.fromList) |> makeDisplayable)) ]
                    ]
                ]
            , div
                [ class "w3-cell-row" ]
                [ div
                    [ id "7"
                    , class "w3-button w3-container w3-cell w3-orange w3-border w3-hover-border-black"
                    , style [ ( "width", "33%" ) ]
                    , onClick (actionToMarkCell 6 playerInTurn)
                    ]
                    [ p
                        []
                        [ text ((Array.get 6 (currentBoard |> Array.fromList) |> makeDisplayable)) ]
                    ]
                , div
                    [ id "8"
                    , class "w3-button w3-container w3-cell w3-orange w3-border w3-hover-border-black"
                    , style [ ( "width", "33%" ) ]
                    , onClick (actionToMarkCell 7 playerInTurn)
                    ]
                    [ p
                        []
                        [ text ((Array.get 7 (currentBoard |> Array.fromList) |> makeDisplayable)) ]
                    ]
                , div
                    [ id "9"
                    , class "w3-button w3-container w3-cell w3-orange w3-border w3-hover-border-black"
                    , style [ ( "width", "33%" ) ]
                    , onClick (actionToMarkCell 8 playerInTurn)
                    ]
                    [ p
                        []
                        [ text ((Array.get 8 (currentBoard |> Array.fromList) |> makeDisplayable)) ]
                    ]
                ]
            , div
                [ class "w3-animate-fading" ]
                [ text (display_prompt playerInTurn) ]
            , div
                []
                []
            ]
        ]


makeDisplayable justElement =
    case justElement of
        Just element ->
            if element == "" then
                "_"
            else
                element

        Nothing ->
            ""


display_prompt playerInTurn =
    if playerInTurn == "Human" then
        prompt_for_move playerInTurn
    else
        wait_for_computer playerInTurn


prompt_for_move playerInTurn =
    playerInTurn ++ " click on a cell to place your marker."


wait_for_computer playerInTurn =
    playerInTurn ++ " is thinking..."
