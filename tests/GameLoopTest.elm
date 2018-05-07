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
    describe "beginPlay"
        [ test "the user is presented with the welcome_view" <|
            let
                beginning =
                    GameLoop.initialViewInGameLoop
            in
                \() -> Expect.equal viewWelcomeScreen beginning.currentView
        , test "the user hits the `Next` button they are presented with the mode_menu_screen" <|
            \() ->
                Html.input [ onClick SetMode ] []
                    |> Query.fromHtml
                    |> Event.simulate (Event.click)
                    |> Event.expect (SetMode)
        ]
