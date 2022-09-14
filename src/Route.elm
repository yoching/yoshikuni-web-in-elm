module Route exposing (Language(..), Page(..), Route, routeParser)

import Url.Parser exposing ((</>), Parser, map, oneOf, s, string, top)


type alias Route =
    { page : Page
    , language : Language
    }


type Page
    = Home
    | Profile
    | Blog
    | Post String


type Language
    = Default
    | Japanese


routeParser : Parser (Route -> a) a
routeParser =
    oneOf
        [ map { page = Profile, language = Default } (s "profile")
        , map { page = Blog, language = Default } (s "blog")
        , map (\pageId -> { page = Post pageId, language = Default }) (s "blog" </> string)
        , map { page = Home, language = Japanese } (s "jp")
        , map { page = Profile, language = Japanese } (s "jp" </> s "profile")
        , map { page = Blog, language = Japanese } (s "jp" </> s "blog")
        , map (\pageId -> { page = Post pageId, language = Japanese }) (s "jp" </> s "blog" </> string)
        , map { page = Home, language = Default } top
        ]



-- createJapaneseRoute : Page -> Route
-- createJapaneseRoute page =
--     { page = page, language = Japanese }
-- post : Parser (Route -> a) a
-- post =
--     map Post
