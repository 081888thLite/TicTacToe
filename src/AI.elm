module Logic.AI exposing (getBestMove)

import Model exposing (..)
import GamePlay exposing (..)
import Logic.GameUtils
import Tuple exposing (..)


getBestMove : Game -> Maybe Position
getBestMove game =
    let
        bestNextGame =
            second (negamax (possibleGames game) -infinite infinite ( -infinite, Nothing ))
    in
        case bestNextGame of
            Just nextState ->
                Maybe.map .coordinates (List.head nextState.movesSoFar)

            Nothing ->
                Nothing


score : Game -> Int -> Int -> Int
score game bestForCurrentPlayer bestForOpponent =
    case game.status of
        Draw ->
            0

        Won player ->
            if player == game.currentPlayer then
                (numberOfAvailableMoves game) + 1
            else
                -((numberOfAvailableMoves game) + 1)

        InProgress ->
            Tuple.first
                (negamax
                    (possibleGames game)
                    bestForCurrentPlayer
                    bestForOpponent
                    ( -infinite, Nothing )
                )


negamax : List Game -> Int -> Int -> ( Int, Maybe Game ) -> ( Int, Maybe Game )
negamax games bestForCurrentPlayer bestForOpponent bestSoFar =
    case games of
        first :: rest ->
            let
                firstScore =
                    -(score first -bestForOpponent -bestForCurrentPlayer)

                newBestForCurrentPlayer =
                    max bestForCurrentPlayer firstScore

                newBestSoFar =
                    if firstScore > (first bestSoFar) then
                        ( firstScore, Just first )
                    else
                        bestSoFar
            in
                if newBestForCurrentPlayer > bestForOpponent then
                    newBestSoFar
                else
                    negamax rest newBestForCurrentPlayer bestForOpponent newBestSoFar

        [] ->
            bestSoFar


numberOfAvailableMoves : Game -> Int
numberOfAvailableMoves game =
    game.boardSize ^ 2 - (List.length game.movesSoFar)


infinite : Int
infinite =
    round (1 / 0)


possibleGames : Game -> List Game
possibleGames game =
    let
        makeMove =
            \coordinates -> GamePlay.makeMove coordinates game
    in
        case game.status of
            InProgress ->
                List.map makeMove (availableCoordinates game)

            _ ->
                []


availableCoordinates : Game -> List Coordinates
availableCoordinates game =
    let
        isMoveTaken =
            \coordinates -> (playerAt coordinates game) == Nothing
    in
        List.filter isMoveTaken (boardCoordinates game)
