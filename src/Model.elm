module Model exposing (..)

import Html exposing (..)
import Task exposing (..)


--Model


type Player
    = X
    | O


type Status
    = InProgress
    | Draw
    | Won Player


type alias Position =
    { index : Int
    }


type alias Move =
    { position : Position
    , player : Player
    }


type alias Game =
    { status : Status
    , boardSize : Int
    , computerUp : Bool
    , currentPlayer : Player
    , movesMade : List Move
    }


init : ( Game, Cmd msg )
init =
    ( initialGame, Cmd.none )


initialGame : Game
initialGame =
    Game InProgress 9 False X []


boardPositions : Game -> List Position
boardPositions game =
    List.map (\index -> Position index) [ 0, 1, 2, 3, 4, 5, 6, 7, 8 ]


whoOwns : Position -> Game -> Maybe Player
whoOwns position game =
    case List.filter (\move -> move.position == position) game.movesMade of
        move :: _ ->
            Just move.player

        _ ->
            Nothing
