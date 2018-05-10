module AITest exposing (..)

import Game exposing (..)
import Views exposing (..)
import Expect exposing (Expectation)
import Test exposing (..)



--get_best_move_test : Test
--get_best_move_test =
--  describe "returns best move possible",

--        Expect.equal 8 (AI.get_best_move ["X","X","","","","","O","O",""],"O"),
--        Expect.equal 8 (AI.get_best_move ["X","","","","","","O","O",""],"X"),
--        Expect.equal 8 (AI.get_best_move ["X","","","","","","O","O",""],"O"),
--        Expect.equal 2 (AI.get_best_move ["X","X","","","","","O","O",""],"X"),
--        Expect.equal 2 (AI.get_best_move ["X","X","","","","","","O",""],"O"),
--        Expect.equal 2 (AI.get_best_move ["X","X","","","","","","O",""],"X")

--possible_boards_test : Test
--possible_boards_test =
--  describe "makes a list of hypothetical boards after next move",
--        Expect.equal ([["","", "","","","","","","X"],
--                       ["","","","","","","","X",""],
--                       ["","","","","","","X","",""],
--                       ["","","","","","X","","",""],
--                       ["","","","","X","","","",""],
--                       ["","","","X","","","","",""],
--                       ["","","X","","","","","",""],
--                       ["","X","","","","","","",""],
--                       ["X","","","","","","","",""]]),
--                       AI.possible_boards(["","","","","","","","",""],"X")),
--        Expect.equal ([[1,2 AI.,4,5,6,"X","O","X"],
--                       [1,2,3,4,5,"X",7,"O","X"],
--                       [1,2,3,4,"X",6,7,"O","X"],
--                       [1,2,3,"X",5,6,7,"O","X"],
--                       [1,2,"X",4,5,6,7,"O","X"],
--                       [1,"X",3,4,5,6,7,"O","X"],
--                       ["X",2,3,4,5,6,7,"O","X"]]),
--                       ai:possible_boards([1,2,3,4,5,6,7,"O","X"],"X")),
--        Expect.equal ([[1,2 AI.,4,5,"O","X","O","X"],
--                       [1,2,3,4,"O",6,"X","O","X"],
--                       [1,2,3,"O",5,6,"X","O","X"],
--                       [1,2,"O",4,5,6,"X","O","X"],
--                       [1,"O",3,4,5,6,"X","O","X"],
--                       ["O",2,3,4,5,6,"X","O","X"]]),
--                       ai:possible_boards([1,2,3,4,5,6,"X","O","X"],"O")),
--        Expect.equal ([["O","X" AI.,"X","O","O","X","O","X"]]),
--                       ai:possible_boards(["O","X","O","X","O",6,"X","O","X"],"O"))}].

--score_test : Test
--score_test =
--  -> Terminal_Board_Won_By_X_3_empties = ["X","X","X","O","O",6,"O",8,9],
--     Terminal_Board_Won_By_O =  ["O","O","O","X","X",6,"X",8,9],
--     Terminal_Board_Drawn    =  ["X","O","X","O","X","X","O","X","O"],
--     [{ "returns a score based on end condition of board",
--        Expect.equal  10  - AI.count_moves(Terminal_Board_Won_By_X_3_empties),
--                            ai:score(Terminal_Board_Won_By_X_3_empties)),
--        Expect.equal -10  + AI.count_moves(Terminal_Board_Won_By_O),
--                            ai:score(Terminal_Board_Won_By_O)),
--        Expect.equal   0, AI.i:score(Terminal_Board_Drawn))}].

--minimize_test : Test
--minimize_test =
--  ->  Terminal_Board_Won_By_X_3_empties = ["X","X","X","O","O",6,"O",8,9],
--      Terminal_Board_Won_By_O_3_empties = ["O","O","O","X","X",6,"X",8,9],
--      Terminal_Board_Drawn    = ["X","O","X","O","X","X","O","X","O"],
--      [{"scores a board as minimizer",
--      Expect.equal 4, AI.minimize(Terminal_Board_Won_By_X_3_empties)),
--      Expect.equal -4, AI.minimize(Terminal_Board_Won_By_O_3_empties)),
--      Expect.equal 0, AI.minimize(Terminal_Board_Drawn))
--      }].

--maximize_test : Test
--maximize_test =
--  ->  Terminal_Board_Won_By_X_3_empties = ["X","X","X","O","O",6,"O",8,9],
--      Terminal_Board_Won_By_O_3_empties = ["O","O","O","X","X",6,"X",8,9],
--      Terminal_Board_Drawn    = ["X","O","X","O","X","X","O","X","O"],
--      [{"scores a board as maximizer",
--      Expect.equal 4, AI.maximize(Terminal_Board_Won_By_X_3_empties)),
--      Expect.equal -4, AI.maximize(Terminal_Board_Won_By_O_3_empties)),
--      Expect.equal 0, AI.maximize(Terminal_Board_Drawn))
--      }].

--count_moves_test : Test
--count_moves_test =
--  ->  Board_with_6_moves = ["X","X","X","O","O",6,"O",8,9],
--      Board_with_5_moves = [1,"O","O","X","X",6,"X",8,9],
--      Full_Board_of_9    = ["X","O","X","O","X","X","O","X","O"],
--      [{"counts the moves made on the board",
--      Expect.equal 6, AI.count_moves(Board_with_6_moves)),
--      Expect.equal 5, AI.count_moves(Board_with_5_moves)),
--      Expect.equal 9, AI.count_moves(Full_Board_of_9))
--      }].

--minimax_value_test : Test
--minimax_value_test =
--  ->
--      Board_Not_Won_x_Turn_5_empties = ["X","X",3,4,5,6,"O","O",9],
--      Board_Not_Won_o_Turn_6_empties = ["X",2,3,4,5,6,"O","O",9],
--      Terminal_Board_Won_By_X_3_empties = ["X","X","X","O","O",6,"O",8,9],
--      Terminal_Board_Won_By_O_3_empties = ["O","O","O","X","X",6,"X",8,9],
--      Terminal_Board_Drawn    = ["X","O","X","O","X","X","O","X","O"],
--      [{"uses the board and the player at turn,
--      creates new boards until one reaches a terminal state,
--      then it returns the score based off whether the player is
--      minimizer or maximizer",
--      Expect.equal 4, AI.minimax_value(Terminal_Board_Won_By_X_3_empties, "O")),
--      Expect.equal -4, AI.minimax_value(Terminal_Board_Won_By_O_3_empties, "O")),
--      Expect.equal 4, AI.minimax_value(Terminal_Board_Won_By_X_3_empties, "X")),
--      Expect.equal -4, AI.minimax_value(Terminal_Board_Won_By_O_3_empties, "X")),
--      Expect.equal 0, AI.minimax_value(Terminal_Board_Drawn, "X")),
--      Expect.equal 0, AI.minimax_value(Terminal_Board_Drawn, "O")),
--      Expect.equal -6, AI.minimax_value(Board_Not_Won_o_Turn_6_empties, "O")),
--      Expect.equal -3, AI.minimax_value(Board_Not_Won_o_Turn_6_empties, "X")),
--      Expect.equal -5, AI.minimax_value(Board_Not_Won_x_Turn_5_empties, "O")),
--      Expect.equal 5, AI.minimax_value(Board_Not_Won_x_Turn_5_empties, "X"))}].

