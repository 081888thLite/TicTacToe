module ViewsTest exposing (..)

import GameLoop exposing (..)
import Views exposing (..)
import Expect exposing (Expectation)
import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes as Attr exposing (..)
import Test exposing (..)
import Test.Html.Query as Query
import Test.Html.Event as Event
import Test.Html.Selector exposing (text, tag)


viewsTest : Test
viewsTest =
    describe "Views"
        [ test "When the user hits the `Next` button they are presented with the mode_menu_screen." <|
            \() ->
                Html.input [ onClick GameLoop.SetMode ] []
                    |> Query.fromHtml
                    |> Event.simulate (Event.click)
                    |> Event.expect (SetMode)
        ]


makeDisplayableTest : Test
makeDisplayableTest =
    describe "makeDisplayable"
        [ test "Turns a maybe with non-empty String into a displayable element." <|
            \() ->
                Expect.equal "X" (makeDisplayable (Just "X"))
        , test "Turns a maybe with empty String into a displayable element." <|
            \() ->
                Expect.equal "_" (makeDisplayable (Just ""))
        ]
