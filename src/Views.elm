module Views exposing (..)

import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)


welcome_view_greeting =
    "Welcome to tic tac toe."


welcome_view_prompt =
    "Hit the Next button to set the Game Mode"


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


mode_menu_screen =
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
                    [ class "w3-large w3-btn w3-ripple w3-orange" ]
                    [ text "Human vs. Human" ]
                , button
                    [ class "w3-large w3-btn w3-ripple w3-orange" ]
                    [ text "Human vs. Computer" ]
                , button
                    [ class "w3-large w3-btn w3-ripple w3-orange" ]
                    [ text "Computer vs. Computer" ]
                ]
            ]
        ]
