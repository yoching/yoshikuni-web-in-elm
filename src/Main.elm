module Main exposing (..)

-- import Hello.World exposing (hello)

import Browser exposing (..)
import Browser.Navigation as Nav
import Html exposing (..)
import Html.Attributes as Attr exposing (class, href, title)
import Json.Decode exposing (..)
import Time exposing (..)
import Url
import Url.Parser



-- MODEL


type alias Post =
    { title : String
    , description : String
    , footerText : String
    }


type alias Model =
    { posts : List Post
    , key : Nav.Key
    , url : Url.Url
    , route : Route
    }



-- MAIN


type alias Flags =
    {}


type Route
    = Profile
    | Blog


routeParser : Url.Parser.Parser (Route -> a) a
routeParser =
    Url.Parser.oneOf
        [ Url.Parser.map Profile (Url.Parser.s "profile")
        , Url.Parser.map Blog (Url.Parser.s "blog")
        ]


main : Program Flags Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlRequest = LinkClicked
        , onUrlChange = UrlChanged
        }


initialPosts : List Post
initialPosts =
    [ { title = "Report - 2021 Q4"
      , description = "This is a report of my activities in 2021 Q4. Project changes, learning, and so on!\nClient work New client projects started in this period.\nCoral Thank you, Coral team.I’m looking forward to working with you again.An app project with a Japanese startup Building a new messaging app for teenagers.Using SwiftUI, Firebase, GraphQL, The Composable Architecture(TCA), and so on.An art app project with an artist based in New York Building a photo- based app with some interesting ideas...."
      , footerText = "December 24, 2021 · 2 min"
      }
    , { title = "Haskell and Swift"
      , description = "Hello, world. Let me share some of my findings of Haskell and Swift.\nI got interested in functional programming, especially in Haskell, when I realized that most of my favorite Swift features come from functional programming. My favorite features include enum with associated values, Result type, higher-order functions (i.e. passing functions themselves), KeyPath type, and so on."
      , footerText = "July 23, 2021 · 4 min"
      }
    ]


init : Flags -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url key =
    case Url.Parser.parse routeParser url of
        Just route -> ( Model initialPosts key url route, Cmd.none )
        Nothing -> ( Model initialPosts key url Profile, Cmd.none )



-- PORTS
-- UPDATE


type Msg
    = UrlChanged Url.Url
    | LinkClicked UrlRequest


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UrlChanged url ->
            case Url.Parser.parse routeParser url of
                Just route ->
                    ( { model | url = url, route = route }, Cmd.none )

                Nothing ->
                    ( model, Cmd.none )

        LinkClicked urlRequest ->
            case urlRequest of
                Internal url ->
                    ( model, Nav.pushUrl model.key (Url.toString url) )

                External href ->
                    ( model, Nav.load href )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- VIEW


view : Model -> Document Msg
view model =
    case model.route of
        Profile ->
            { title = "Profile"
            , body =
                [ div [ class "bg-stone-100", class "dark:bg-zinc-900" ]
                    [ header
                    , pageHtml [ profileHtml ]
                    ]
                ]
            }

        Blog ->
            { title = "Blog"
            , body =
                [ div [ class "bg-stone-100", class "dark:bg-zinc-900 min-h-screen" ]
                    [ header
                    , pageHtml [ postsView model.posts ]
                    ]
                ]
            }


header : Html Msg
header =
    Html.header []
        [ nav
            [ class "flex"
            , class "max-w-5xl"
            , class "mx-auto"
            , class "h-16"
            , class "justify-between"
            ]
            [ div [ class "flex", class "mx-6" ]
                [ a
                    [ title "Yoshikuni Kato"
                    , href "./"
                    , class "font-bold"
                    , class "text-2xl"
                    , class "my-auto"
                    ]
                    [ text "Yoshikuni Kato" ]
                ]
            , ul
                [ class "flex"
                , class "space-x-6"
                , class "my-auto"
                , class "mx-6"
                ]
                [ li []
                    [ a
                        [ title "Profile"
                        , href "./profile"
                        ]
                        [ text "Profile" ]
                    ]
                , li []
                    [ a
                        [ title "Blog"
                        , href "./blog"
                        ]
                        [ text "Blog" ]
                    ]
                ]
            ]
        ]


pageHtml : List (Html Msg) -> Html Msg
pageHtml contents =
    Html.main_
        [ Attr.class "dark:bg-zinc-900" ]
        [ div
            [ Attr.class "max-w-3xl mx-auto p-10 dark:text-white/80 text-lg" ]
            contents
        ]


profileHtml : Html Msg
profileHtml =
    div [ Attr.class "dark:bg-zinc-900" ]
        [ div [ Attr.class "max-w-3xl mx-auto p-10 dark:text-white/80 text-lg" ]
            [ h1 [ Attr.class "font-bold text-[40px]" ]
                [ text "Hello, I'm Yoshikuni!" ]
            , div [ Attr.class "my-8" ]
                [ img
                    [ Attr.src "require:src/img/profile.png"
                    , Attr.class "w-48 mx-auto my-2 rounded"
                    ]
                    []
                ]
            , div
                [ Attr.class "space-y-5" ]
                [ p []
                    [ text "I'm a software engineer with 8+ years of work experience in application development."
                    , br []
                        []
                    , text "Over the past 6 years, I’ve been writing Swift and have made 10+ native iOS apps from scratch for clients."
                    ]
                , p []
                    [ text "At the moment, I’m working as a freelance engineer and focusing on two things:" ]
                , div []
                    [ ol
                        [ Attr.class "list-decimal list-inside"
                        ]
                        [ li []
                            [ text "Helping client projects by utilizing my iOS/Swift skills and experience" ]
                        , li []
                            [ text "Exploring new programming languages and technology for my future work" ]
                        ]
                    ]
                , p []
                    [ text "🧑🏻\u{200D}💻 My technical interests include Functional Programming, Interactive UI development, and various tools that support software development. I’ve given many presentations about these topics, the slides of which you can find at my"
                    , a
                        [ Attr.href "https://speakerdeck.com/yoching"
                        , Attr.class "underline underline-offset-4"
                        ]
                        [ text "SpeakerDeck" ]
                    , text ". There are some experimental projects and codes on my"
                    , a
                        [ Attr.href "https://github.com/yoching?tab=repositories"
                        , Attr.class "underline underline-offset-4"
                        ]
                        [ text "GitHub" ]
                    , text "as well. Also, I enjoy doing pair-programming and using scrum/agile methodologies when working in a team."
                    ]
                , p []
                    [ text "📚 Apart from professional experience, I am passionate about interdisciplinary fields of technology and society. This relates to my Master’s degree in Interdisciplinary Information Studies at The University of Tokyo in 2013. I’m eager to find opportunities to develop this passion further." ]
                , p []
                    [ text "🌏 Originally from Japan, I moved to Prague, the Czech Republic, in 2019 to gain experience working in an international environment. After working on several projects with international colleagues and clients, in 2021, I moved to Amsterdam, the Netherlands, where I can work as a freelancer, to be more flexible about technology choice and to work on a wider variety of projects. These moves were motivated by my ambition to contribute to software development culture." ]
                , p []
                    [ text "✨ Besides work, I like listening to the radio, thinking about philosophical ideas, visiting art exhibitions, reading books, and so on." ]
                , p []
                    [ text "If you are interested to learn more about my work experience, please read my CV or"
                    , a
                        [ Attr.href "https://linkedin.com/in/yoshikunikato"
                        , Attr.class "underline underline-offset-4"
                        ]
                        [ text "LinkedIn" ]
                    , text ". My portfolio is also available on request."
                    ]
                , p []
                    [ text "I’m looking forward to hearing from you and discussing future projects together." ]
                ]
            , div []
                [ h3
                    [ Attr.class "font-bold text-2xl pt-5 mt-6 mb-4"
                    ]
                    [ text "Contacts" ]
                , ul []
                    [ li
                        [ Attr.class "list-disc list-inside"
                        ]
                        [ a
                            [ Attr.href "mailto:yoshikuni.kato.g@gmail.com"
                            , Attr.class "underline underline-offset-4"
                            ]
                            [ text "yoshikuni.kato.g@gmail.com" ]
                        ]
                    ]
                ]
            ]
        ]


postsView : List Post -> Html Msg
postsView posts =
    div [ class "space-y-3" ] <| List.map postView posts


postView : Post -> Html Msg
postView post =
    article
        [ class "bg-white rounded-lg shadow p-5 transition active:scale-95" ]
        [ Html.header []
            [ h2
                [ class "text-2xl font-bold text-black/80"
                ]
                [ text post.title ]
            ]
        , section
            [ class "text-sm leading-relaxed text-ellipsis line-clamp-2 text-black/60 my-2"
            ]
            [ p []
                [ text post.description ]
            ]
        , footer
            [ class "text-sm text-black/60"
            ]
            [ text post.footerText ]
        ]
