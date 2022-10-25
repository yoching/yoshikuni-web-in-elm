module Pages.Home.Home exposing (homeJapaneseView, homeView)

import Entities.Post exposing (Post)
import Html exposing (..)
import Html.Attributes exposing (class, href, rel, target, title)
import UIElements.PostEntryView exposing (postEntryView)
import UIElements.SvgImages exposing (..)


homeView : List Post -> Html msg
homeView posts =
    div [ class "space-y-6" ] <|
        homeTopArticleView
            :: List.map postEntryView posts


homeJapaneseView : Html msg
homeJapaneseView =
    div [] [ text "日本語のホーム" ]


homeTopArticleView : Html msg
homeTopArticleView =
    article
        [ class "flex flex-col mt-6 mb-12 justify-center min-h-[320px]" ]
        [ header
            []
            [ h1
                [ class "text-4xl font-bold" ]
                [ text "Hello, I’m Yoshikuni!" ]
            ]
        , section
            [ class "my-4 text-base text-black/60 dark:text-white/60" ]
            [ p
                []
                [ text "A software engineer with 8+ years of work experience in application development."
                , br [] []
                , text "Based in Amsterdam🇳🇱. Originally from Japan🇯🇵."
                , br [] []
                , a
                    [ class "text-black/90 dark:text-white/90", href "/profile" ]
                    [ text "Read my profile" ]
                , text " to know more about me!"
                ]
            ]
        , footer
            []
            [ div
                [ class "flex py-3" ]
                [ a
                    [ href "https://github.com/yoching"
                    , target "_blank"
                    , rel "noopener noreferrer me"
                    , title "Github"
                    , class "mr-3"
                    ]
                    [ div [ class "h-7 w-7" ] [ githubIcon ] ]
                , a
                    [ href "https://twitter.com/yoshikuni_kato"
                    , target "_blank"
                    , rel "noopener noreferrer me"
                    , title "Twitter"
                    , class "mr-3"
                    ]
                    [ div [ class "h-7 w-7" ] [ twitterIcon ] ]
                , a
                    [ href "https://linkedin.com/in/yoshikunikato"
                    , target "_blank"
                    , rel "noopener noreferrer me"
                    , title "Linkedin"
                    ]
                    [ div [ class "h-7 w-7" ] [ linkedInIcon ] ]
                ]
            ]
        ]
