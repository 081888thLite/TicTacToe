module PromptTest exposing (..)

import Prompt exposing (..)
import Expect exposing (Expectation)
import Test exposing (..)


promptTest : Test
promptTest =
    describe "Prompt"
        [ test "toSetUpPlayers" <|
            \() -> Expect.equal Prompt.toSetUpPlayers "Set the game mode by choosing each player's type:"
        ]
