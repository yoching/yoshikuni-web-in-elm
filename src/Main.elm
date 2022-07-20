module Main exposing (..)

-- import Hello.World exposing (hello)

import Browser exposing (..)
import Browser.Navigation as Nav
import Html exposing (..)
import Html.Attributes exposing (class, href, src, title)
import Html.Events exposing (onClick)
import Json.Decode exposing (..)
import Svg
import Svg.Attributes as SvgAttr
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
    , currentMode : Mode
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


type Mode
    = Dark
    | Light


modeClassName : Mode -> String
modeClassName mode =
    case mode of
        Dark ->
            "dark"

        Light ->
            "light"


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
        Just route ->
            ( Model initialPosts Dark key url route, Cmd.none )

        Nothing ->
            ( Model initialPosts Dark key url Profile, Cmd.none )



-- PORTS
-- UPDATE


type Msg
    = UrlChanged Url.Url
    | LinkClicked UrlRequest
    | ModeClicked


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

        ModeClicked ->
            case model.currentMode of
                Light ->
                    ( { model | currentMode = Dark }, Cmd.none )

                Dark ->
                    ( { model | currentMode = Light }, Cmd.none )



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
            , body = profileView |> bodyList model
            }

        Blog ->
            { title = "Blog"
            , body = postsView model.posts |> bodyList model
            }


bodyList : Model -> Html Msg -> List (Html Msg)
bodyList model pageContent =
    [ div
        [ class <| modeClassName model.currentMode ]
        [ div
            [ class "bg-stone-100 dark:bg-zinc-900 min-h-screen" ]
            [ header model
            , pageView
                [ pageContent ]
            ]
        ]
    ]


modeIcon : Mode -> Html Msg
modeIcon mode =
    case mode of
        Dark ->
            Svg.svg
                [ SvgAttr.id "sun"
                , SvgAttr.width "24"
                , SvgAttr.height "18"
                , SvgAttr.viewBox "0 0 24 24"
                , SvgAttr.fill "none"
                , SvgAttr.stroke "currentColor"
                , SvgAttr.strokeWidth "2"
                , SvgAttr.strokeLinecap "round"
                , SvgAttr.strokeLinejoin "round"
                ]
                [ Svg.circle
                    [ SvgAttr.cx "12"
                    , SvgAttr.cy "12"
                    , SvgAttr.r "5"
                    ]
                    []
                , Svg.line
                    [ SvgAttr.x1 "12"
                    , SvgAttr.y1 "1"
                    , SvgAttr.x2 "12"
                    , SvgAttr.y2 "3"
                    ]
                    []
                , Svg.line
                    [ SvgAttr.x1 "12"
                    , SvgAttr.y1 "21"
                    , SvgAttr.x2 "12"
                    , SvgAttr.y2 "23"
                    ]
                    []
                , Svg.line
                    [ SvgAttr.x1 "4.22"
                    , SvgAttr.y1 "4.22"
                    , SvgAttr.x2 "5.64"
                    , SvgAttr.y2 "5.64"
                    ]
                    []
                , Svg.line
                    [ SvgAttr.x1 "18.36"
                    , SvgAttr.y1 "18.36"
                    , SvgAttr.x2 "19.78"
                    , SvgAttr.y2 "19.78"
                    ]
                    []
                , Svg.line
                    [ SvgAttr.x1 "1"
                    , SvgAttr.y1 "12"
                    , SvgAttr.x2 "3"
                    , SvgAttr.y2 "12"
                    ]
                    []
                , Svg.line
                    [ SvgAttr.x1 "21"
                    , SvgAttr.y1 "12"
                    , SvgAttr.x2 "23"
                    , SvgAttr.y2 "12"
                    ]
                    []
                , Svg.line
                    [ SvgAttr.x1 "4.22"
                    , SvgAttr.y1 "19.78"
                    , SvgAttr.x2 "5.64"
                    , SvgAttr.y2 "18.36"
                    ]
                    []
                , Svg.line
                    [ SvgAttr.x1 "18.36"
                    , SvgAttr.y1 "5.64"
                    , SvgAttr.x2 "19.78"
                    , SvgAttr.y2 "4.22"
                    ]
                    []
                ]

        Light ->
            Svg.svg
                [ SvgAttr.id "moon"
                , SvgAttr.width "24"
                , SvgAttr.height "18"
                , SvgAttr.viewBox "0 0 24 24"
                , SvgAttr.fill "none"
                , SvgAttr.stroke "currentColor"
                , SvgAttr.strokeWidth "2"
                , SvgAttr.strokeLinecap "round"
                , SvgAttr.strokeLinejoin "round"
                ]
                [ Svg.path
                    [ SvgAttr.d "M21 12.79A9 9 0 1 1 11.21 3 7 7 0 0 0 21 12.79z" ]
                    []
                ]


header : Model -> Html Msg
header model =
    Html.header
        [ class "dark:bg-zinc-900" ]
        [ nav
            [ class "flex max-w-5xl mx-auto h-16 justify-between dark:text-white/80  leading-[4rem]" ]
            [ div
                [ class "flex mx-6" ]
                [ a
                    [ title "Yoshikuni Kato", href "./", class "font-bold text-2xl leading-[4rem]" ]
                    [ text "Yoshikuni Kato" ]
                , span
                    [ class "mx-1 inline-flex leading-[4rem]" ]
                    [ button
                        [ class "mx-1 text-2xl leading-[4rem] pt-1", onClick ModeClicked ]
                        [ modeIcon model.currentMode ]
                    , ul
                        [ class "flex" ]
                        [ li
                            [ class "mx-1" ]
                            [ text "|" ]
                        , li
                            [ class "mx-1 text-base leading-[4rem]" ]
                            [ a
                                [ title "日本語", href "./" ]
                                [ text "日本語" ]
                            ]
                        ]
                    ]
                ]
            , ul
                [ class "flex space-x-6 mx-6" ]
                [ li
                    []
                    [ a
                        [ title "Profile", href "./profile" ]
                        [ text "Profile" ]
                    ]
                , li
                    []
                    [ a
                        [ title "Blog", href "./blog" ]
                        [ text "Blog" ]
                    ]
                ]
            ]
        ]


pageView : List (Html Msg) -> Html Msg
pageView contents =
    main_
        [ class "dark:bg-zinc-900" ]
        [ div
            [ class "max-w-3xl mx-auto p-10 dark:text-white/80 text-lg" ]
            contents
        ]


profileView : Html Msg
profileView =
    div [ class "dark:bg-zinc-900" ]
        [ div [ class "max-w-3xl mx-auto p-10 dark:text-white/80 text-lg" ]
            [ h1
                [ class "font-bold text-[40px]" ]
                [ text "Hello, I'm Yoshikuni!" ]
            , div
                [ class "my-8" ]
                [ img
                    [ src "require:src/img/profile.png", class "w-48 mx-auto my-2 rounded" ]
                    []
                ]
            , div
                [ class "space-y-5" ]
                [ p
                    []
                    [ text "I'm a software engineer with 8+ years of work experience in application development."
                    , br []
                        []
                    , text "Over the past 6 years, I’ve been writing Swift and have made 10+ native iOS apps from scratch for clients."
                    ]
                , p []
                    [ text "At the moment, I’m working as a freelance engineer and focusing on two things:" ]
                , div []
                    [ ol
                        [ class "list-decimal list-inside" ]
                        [ li
                            []
                            [ text "Helping client projects by utilizing my iOS/Swift skills and experience" ]
                        , li
                            []
                            [ text "Exploring new programming languages and technology for my future work" ]
                        ]
                    ]
                , p
                    []
                    [ text "🧑🏻\u{200D}💻 My technical interests include Functional Programming, Interactive UI development, and various tools that support software development. I’ve given many presentations about these topics, the slides of which you can find at my "
                    , a
                        [ href "https://speakerdeck.com/yoching", class "underline underline-offset-4" ]
                        [ text "SpeakerDeck" ]
                    , text ". There are some experimental projects and codes on my "
                    , a
                        [ href "https://github.com/yoching?tab=repositories", class "underline underline-offset-4" ]
                        [ text "GitHub" ]
                    , text " as well. Also, I enjoy doing pair-programming and using scrum/agile methodologies when working in a team."
                    ]
                , p
                    []
                    [ text "📚 Apart from professional experience, I am passionate about interdisciplinary fields of technology and society. This relates to my Master’s degree in Interdisciplinary Information Studies at The University of Tokyo in 2013. I’m eager to find opportunities to develop this passion further." ]
                , p
                    []
                    [ text "🌏 Originally from Japan, I moved to Prague, the Czech Republic, in 2019 to gain experience working in an international environment. After working on several projects with international colleagues and clients, in 2021, I moved to Amsterdam, the Netherlands, where I can work as a freelancer, to be more flexible about technology choice and to work on a wider variety of projects. These moves were motivated by my ambition to contribute to software development culture." ]
                , p
                    []
                    [ text "✨ Besides work, I like listening to the radio, thinking about philosophical ideas, visiting art exhibitions, reading books, and so on." ]
                , p
                    []
                    [ text "If you are interested to learn more about my work experience, please read my CV or "
                    , a
                        [ href "https://linkedin.com/in/yoshikunikato", class "underline underline-offset-4" ]
                        [ text "LinkedIn" ]
                    , text ". My portfolio is also available on request."
                    ]
                , p
                    []
                    [ text "I’m looking forward to hearing from you and discussing future projects together." ]
                ]
            , div
                []
                [ h3
                    [ class "font-bold text-2xl pt-5 mt-6 mb-4" ]
                    [ text "Contacts" ]
                , ul
                    []
                    [ li
                        [ class "list-disc list-inside" ]
                        [ a
                            [ href "mailto:yoshikuni.kato.g@gmail.com", class "underline underline-offset-4" ]
                            [ text "yoshikuni.kato.g@gmail.com" ]
                        ]
                    ]
                ]
            ]
        ]


postsView : List Post -> Html Msg
postsView posts =
    div [ class "space-y-6" ] <| List.map postView posts


postView : Post -> Html Msg
postView post =
    article
        [ class "bg-white rounded-lg shadow p-5 transition active:scale-95" ]
        [ Html.header
            []
            [ h2
                [ class "text-2xl font-bold text-black/80" ]
                [ text post.title ]
            ]
        , section
            [ class "text-sm leading-relaxed text-ellipsis line-clamp-2 text-black/60 my-2" ]
            [ p
                []
                [ text post.description ]
            ]
        , footer
            [ class "text-sm text-black/60" ]
            [ text post.footerText ]
        ]
