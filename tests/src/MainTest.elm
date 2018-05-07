module MainTest exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import Test exposing (..)
import Main exposing (..)
import Array exposing (..)


mainTest : Test
mainTest =
    describe "nothing_D"
        [ test "nothing_T when bla" <|
            \() -> Expect.equal "nothing" "nothing"
        ]



--describe "Game"
--        [ describe "after calling setPlayers"
--            [ test "setPlayers human human returns a list of 2 human players" <|
--                \() -> Expect.equal (setPlayers Human Human) [ Human, Human ]
--            , test "setPlayers computer computer returns a list of 2 computer players" <|
--                \() -> Expect.equal (setPlayers Computer Computer) [ Computer, Computer ]
--            , test "setPlayers computer human returns a mixed list of players w/ Computer player first" <|
--                \() -> Expect.equal (setPlayers Computer Human) [ Computer, Human ]
--            , test "setPlayers human computer returns a mixed list of players w/ Human player first" <|
--                \() -> Expect.equal (setPlayers Computer Human) [ Computer, Human ]
--            ]
--        , describe "after calling setBoard"
--            [ test "with emptyBoard" <|
--                let
--                    gameInPlay =
--                        Game [ Human, Human ] (Array.fromList [ "X", "", "", "", "", "", "", "", "O" ])
--                    expectedGame =
--                        Game [ Human, Human ] (Array.fromList [ "", "", "", "", "", "", "", "", "" ])
--                in
--                    \() -> Expect.equal (setBoard gameInPlay Main.emptyBoard) expectedGame
--            , test "with a new value" <|
--                let
--                    gameInPlay =
--                        Game [ Human, Human ] (Array.fromList [ "X", "", "", "", "", "", "", "", "O" ])
--                    expectedGame =
--                        Game [ Human, Human ] (Array.fromList [ "X", "", "O", "", "", "", "", "", "O" ])
--                    withNewValue =
--                        (Array.fromList [ "X", "", "O", "", "", "", "", "", "O" ])
--                in
--                    \() -> Expect.equal (setBoard gameInPlay withNewValue) expectedGame
--            ]
--        ]
