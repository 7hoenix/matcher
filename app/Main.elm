module Main exposing (..)

import Html exposing (program)
import Matchr exposing (Matchr, Msg, init, view, update)


main : Program Never Matchr Msg
main =
    program
        { init = init
        , update = update
        , view = view
        , subscriptions = always Sub.none
        }
