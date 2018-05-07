module GameLoop exposing (..)

import Views exposing (..)
import Html exposing (..)


--Update
--View


main =
    beginnerProgram { model = model, view = view, update = update }


type alias GameLoop =
    { currentView : Html Msg }


model =
    initialViewInGameLoop


initialViewInGameLoop =
    { currentView = viewWelcomeScreen
    }


type Msg
    = BeginPlay
    | SetMode


update msg model =
    case msg of
        BeginPlay ->
            { model | currentView = viewWelcomeScreen }

        SetMode ->
            { model | currentView = viewModeMenu }


view model =
    div [] [ model.currentView ]


viewWelcomeScreen =
    div [] [ welcome_screen SetMode ]


viewModeMenu =
    div [] [ mode_menu_screen ]



--"When a game begins the user is presented with the
--    welcome_view"
--2. 6:30 "When the user hits the "Set Mode" button they are
--    presented the mode_menu"
--3. 7:30 "When the user checks a box selecting the game mode the
--    players and strategies are set"
--4. 8:30 "When the user hits the "Start Game" button a turn_loop
--    is started in the desired mode with an empty board and
--    player 1 in turn."
--5. 9:30 "When the player clicks on a board cell that is owned nothing happens"
--6. 10:30 "When the player clicks on a board cell that is not owned:
--    - the board is Marked.
--    - the board is checked for a win
--      - if won then Game { state : Won, winner : Player }
--      - if not won then Game { state : InProgress, winner : Nothing }
--    - the board is checked if it is full
--      - if full then Game { state : Drawn, winner : Nothing }
--      - if notFull then Game { state : InProgress, winner : Maybe.Nothing }"
--7. 11:30 "A new turn loop begins with the players switched"
