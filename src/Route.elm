module Route exposing (Language(..), Page(..), Route, routeParser)

import Url.Parser exposing ((</>), Parser, map, oneOf, s, top)


type alias Route =
    { page : Page
    , language : Language
    }


type Page
    = Home
    | Profile
    | Blog


type Language
    = Default
    | Japanese


routeParser : Parser (Route -> a) a
routeParser =
    oneOf
        [ map { page = Profile, language = Default } (s "profile")
        , map { page = Blog, language = Default } (s "blog")
        , map { page = Home, language = Japanese } (s "jp")
        , map { page = Profile, language = Japanese } (s "jp" </> s "profile")
        , map { page = Blog, language = Japanese } (s "jp" </> s "blog")
        , map { page = Home, language = Default } top
        ]
