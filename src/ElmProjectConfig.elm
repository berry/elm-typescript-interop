module ElmProjectConfig exposing (ElmProjectConfig, ElmVersion(..), decoder)

import Json.Decode as Decode exposing (Decoder)
import String.Interpolate exposing (interpolate)


type alias ElmProjectConfig =
    { sourceDirectories : List String
    , elmVersion : ElmVersion
    }


type ElmVersion
    = Elm18
    | Elm19


decoder : Decoder ElmProjectConfig
decoder =
    Decode.map2 ElmProjectConfig
        (Decode.field "source-directories" (Decode.list Decode.string))
        (Decode.field "elm-version" Decode.string
            |> Decode.andThen parseVersion18
        )


parseVersion18 : String -> Decoder ElmVersion
parseVersion18 versionString =
    if versionString == elm18VersionString then
        Decode.succeed Elm18

    else if versionString == elm19VersionString then
        Decode.succeed Elm19

    else
        interpolate "Unsupported elm-version value: `{0}`. I only support the exact values [{1}]."
            [ versionString
            , [ elm18VersionString, elm19VersionString ]
                |> List.map toString
                |> String.join ", "
            ]
            |> Decode.fail


elm18VersionString : String
elm18VersionString =
    "0.18.0 <= v < 0.19.0"


elm19VersionString : String
elm19VersionString =
    "0.19.1"
