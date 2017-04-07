module Matchr exposing (..)

import Html exposing (Html, button, div, fieldset, input, label, text)
import Html.Attributes exposing (name, type_)
import Html.Events exposing (onClick)
import Http
import RemoteData exposing (RemoteData(..), WebData)
import Skill exposing (Skill)


type alias Matchr =
    { skills : WebData (List Skill)
    , role : Role
    }


init =
    let
        cmd =
            Http.send SkillsFetch Skill.fetch
    in
        ( { skills = Loading, role = Teacher }, cmd )


type Role
    = Learner
    | Teacher


type Msg
    = SkillsFetch (Result Http.Error (List Skill))
    | SwitchTo Role
    | Submit


update : Msg -> Matchr -> ( Matchr, Cmd Msg )
update msg model =
    case msg of
        SkillsFetch (Err err) ->
            { model | skills = Failure err } ! []

        SkillsFetch (Ok skills) ->
            { model | skills = Success skills } ! []

        SwitchTo role ->
            { model | role = role } ! []

        Submit ->
            model ! []


view : Matchr -> Html Msg
view model =
    case model.skills of
        Failure _ ->
            div [] [ text "Failed!" ]

        Success skills ->
            div []
                [ Skill.view skills
                , fieldset []
                    [ label []
                        [ text "I want to teach this"
                        , input [ type_ "radio", name "role", onClick (SwitchTo Teacher) ] []
                        ]
                    , label []
                        [ input [ type_ "radio", name "role", onClick (SwitchTo Learner) ] []
                        , text "I want to learn this"
                        ]
                    ]
                , button [ onClick Submit ] [ text "Add" ]
                ]

        _ ->
            div [] [ text "Loading..." ]
