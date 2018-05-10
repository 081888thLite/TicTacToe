module GameUtils exposing (..)

import Array exposing (..)
import List exposing (..)


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
            List.any (\row -> row == [ O, O, O ]) winningCombos

        isWonByX =
            List.any (\row -> row == [ X, X, X ]) winningCombos
    in
        case ( isWonByX, isWonByO ) of
            ( True, _ ) ->
                ( True, X, board )

            ( _, True ) ->
                ( True, X, board )

            ( False, False ) ->
                ( False, Nothing, board )


getAt : List a -> Int -> Maybe a
getAt xs index =
    List.head <| List.drop index xs


markBoard position piece board =
    ((Array.fromList board) |> (Array.set position piece)) |> Array.toList


updateAt : Int -> (a -> a) -> List a -> List a
updateAt index fn list =
    if index < 0 then
        list
    else
        let
            head =
                List.take index list

            tail =
                List.drop index list
        in
            case tail of
                x :: xs ->
                    head ++ fn x :: xs

                _ ->
                    list


getPlayerInTurnFromBoard : List String -> String
getPlayerInTurnFromBoard board =
    if (((List.filter (\cellValue -> (cellValue /= "")) board) |> List.length) % 2) == 0 then
        "X"
    else
        "O"


justValue justElement =
    case justElement of
        Just element ->
            element

        Nothing ->
            ""


getIndexedBoard board =
    List.indexedMap (,) board


getIndexedVacantCells board =
    let
        indexedBoard =
            getIndexedBoard board
    in
        List.filter (\( index, value ) -> value == "") indexedBoard
