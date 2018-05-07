module Main exposing (..)

--Internal APIs

import Prompt exposing (..)
import GameLoop exposing (..)
import Views exposing (..)


--Elm Core APIs

import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)


----Imported Package APIs
--import Bootstrap.CDN as CDN exposing (..)
--import Bootstrap.Grid as Grid exposing (..)
--import Bootstrap.Grid.Col as Col exposing (..)
--import Bootstrap.Grid.Row as Row exposing (..)


main =
    beginnerProgram { model = model, view = view, update = update }



--type alias Game =
--    { players : List Player
--    , board : Array String
--    }
--type Player
--    = Human
--    | Computer
--type alias Human =
--    Player
--        { name : String
--        , piece : String
--        }
--type alias Computer =
--    Player
--        { name : String
--        , piece : String
--        , difficulty : String
--        }
-- MODEL


model =
    GameLoop.model



---- UPDATE
--type Msg
--    = New
--    | Fill
--    | Mark Int String
--update msg model =
--    case msg of
--        New ->
--            Game model.players (Array.repeat 9 "")
--        Fill ->
--            Game model.players (Array.repeat 9 "X")
--        Mark int piece ->
--            Game model.players (Array.set int piece model.board)
--setPlayers : Player -> Player -> List Player
--setPlayers player1 player2 =
--    [ player1, player2 ]
--setBoard : Game -> Array String -> Game
--setBoard game newBoard =
--    Game game.players newBoard
--emptyBoard =
--    Array.fromList [ "", "", "", "", "", "", "", "", "" ]
---- VIEW
--view model =
--    div []
--        [ viewOptions
--        , viewBoard model.board
--        ]
--viewOptions =
--    div [ class "options" ]
--        [ div [ class "options-header" ]
--            [ text "Options" ]
--        , div [ class "options-prompt" ]
--            [ text Prompt.toSetUpPlayers ]
--        ]
--viewBoard board =
--    div [ class "board" ]
--        [ Grid.container []
--            [ Grid.row []
--                [ Grid.col [] [ renderCell 0 board (toString (Array.get 0 board)) ]
--                , Grid.col [] [ renderCell 1 board (toString (Array.get 1 board)) ]
--                , Grid.col [] [ renderCell 2 board (toString (Array.get 2 board)) ]
--                , Grid.colBreak []
--                , Grid.col [] [ renderCell 3 board (toString (Array.get 3 board)) ]
--                , Grid.col [] [ renderCell 4 board (toString (Array.get 4 board)) ]
--                , Grid.col [] [ renderCell 5 board (toString (Array.get 5 board)) ]
--                , Grid.colBreak []
--                , Grid.col [] [ renderCell 6 board (toString (Array.get 6 board)) ]
--                , Grid.col [] [ renderCell 7 board (toString (Array.get 7 board)) ]
--                , Grid.col [] [ renderCell 8 board (toString (Array.get 8 board)) ]
--                , Grid.colBreak []
--                ]
--            ]
--        ]
--renderCell position board value =
--    div []
--        [ button
--            [ onClick (Mark position value)
--            ]
--            [ text (toString position) ]
--        ]
