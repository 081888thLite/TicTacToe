module Main exposing (..)

import GameLoop exposing (..)
import Views exposing (..)
import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)


main =
    program
        { init = GameLoop.init
        , view = GameLoop.view
        , update = GameLoop.update
        , subscriptions = GameLoop.subscriptions
        }


model =
    GameLoop
