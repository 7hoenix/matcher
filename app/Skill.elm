module Skill exposing (..)

import Html exposing (Html, div, option, select, text)
import Html.Attributes exposing (value)
import Http exposing (Request)
import Json.Decode exposing (Decoder, field, int, list, string)
import Json.Decode.Pipeline exposing (decode, required)


type alias Skill =
    { id : Int
    , name : String
    }


fetch : Request (List Skill)
fetch =
    Http.get "/api/skills" (field "data" (list decoder))


decoder : Decoder Skill
decoder =
    decode Skill
        |> required "id" int
        |> required "name" string


view : List Skill -> Html msg
view skills =
    let
        options =
            List.map
                (\{ id, name } -> option [ value (toString id) ] [ text name ])
                skills
    in
        div []
            [ select [] options
            ]
