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
        [ p
            [ class "w3-display-topmiddle w3-jumbo" ]
            [ text "TicTacToe" ]
        , div
            [ class "w3-display-middle w3-xxxlarge" ]
            [ div
                [ class "w3-cell-row" ]
                [ div
                    [ id "1", class "w3-button w3-container w3-cell w3-orange w3-border w3-hover-border-black", onClick (actionToMarkCell 0 "X") ]
                    [ p
                        []
                        [ text (toString ((Array.get 0 (currentBoard |> Array.fromList)))) ]
                    ]
                , div
                    [ class "w3-button w3-container w3-cell w3-orange w3-border w3-hover-border-black" ]
                    [ p
                        []
                        [ text "Cell 2" ]
                    ]
                , div
                    [ class "w3-button w3-container w3-cell w3-orange w3-border w3-hover-border-black" ]
                    [ p
                        []
                        [ text "Cell 3" ]
                    ]
                ]
            , div
                [ class "w3-cell-row" ]
                [ div
                    [ class "w3-button w3-container w3-cell w3-orange w3-border w3-hover-border-black" ]
                    [ p
                        []
                        [ text "Cell 4" ]
                    ]
                , div
                    [ class "w3-button w3-container w3-cell w3-orange w3-border w3-hover-border-black" ]
                    [ p
                        []
                        [ text "Cell 5" ]
                    ]
                , div
                    [ class "w3-button w3-container w3-cell w3-orange w3-border w3-hover-border-black" ]
                    [ p
                        []
                        [ text "Cell 6" ]
                    ]
                ]
            , div
                [ class "w3-cell-row" ]
                [ div
                    [ class "w3-button w3-container w3-cell w3-orange w3-border w3-hover-border-black" ]
                    [ p
                        []
                        [ text "Cell 7" ]
                    ]
                , div
                    [ class "w3-button w3-container w3-cell w3-orange w3-border w3-hover-border-black" ]
                    [ p
                        []
                        [ text "Cell 8" ]
                    ]
                , div
                    [ class "w3-button w3-container w3-cell w3-orange w3-border w3-hover-border-black" ]
                    [ p
                        []
                        [ text "Cell 9" ]
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


display_prompt playerInTurn =
    if playerInTurn == "Human" then
        prompt_for_move playerInTurn
    else
        wait_for_computer playerInTurn


prompt_for_move playerInTurn =
    playerInTurn ++ " click on a cell to place your marker."


wait_for_computer playerInTurn =
    playerInTurn ++ " is thinking..."
