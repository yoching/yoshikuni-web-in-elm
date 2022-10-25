module Main exposing (..)

-- import Hello.World exposing (hello)

import Browser exposing (..)
import Browser.Navigation as Nav
import Html exposing (..)
import Html.Attributes exposing (class, href, rel, src, target, title)
import Html.Events exposing (onClick)
import Post1 exposing (post1View)
import Post2 exposing (post2View)
import Route exposing (..)
import SvgImages exposing (..)
import Time exposing (..)
import Url
import Url.Parser



-- MODEL


type alias Post =
    { title : String
    , description : String
    , footerText : String
    , id : String
    }


type alias Model =
    { posts : List Post
    , currentMode : Mode
    , key : Nav.Key
    , url : Url.Url
    , route : Route
    }


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



-- MAIN


type alias Flags =
    {}


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
    [ { title = "Haskell and Swift"
      , description = "Hello, world. Let me share some of my findings of Haskell and Swift.\nI got interested in functional programming, especially in Haskell, when I realized that most of my favorite Swift features come from functional programming. My favorite features include enum with associated values, Result type, higher-order functions (i.e. passing functions themselves), KeyPath type, and so on."
      , footerText = "July 23, 2021 · 4 min"
      , id = "swift-haskell"
      }
    ]


init : Flags -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url key =
    case Url.Parser.parse routeParser url of
        Just route ->
            ( Model initialPosts Dark key url route, Cmd.none )

        Nothing ->
            ( Model initialPosts Dark key url { page = Home, language = Default }, Cmd.none )



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
    case model.route.language of
        Default ->
            case model.route.page of
                Home ->
                    { title = "Yoshikuni Kato"
                    , body = bodyList model [ homeView model ]
                    }

                Profile ->
                    { title = "Profile"
                    , body = bodyList model [ profileView ]
                    }

                Blog ->
                    { title = "Blog"
                    , body = bodyList model [ postsView model.posts ]
                    }

                Route.Post postId ->
                    { title = postId
                    , body = bodyList model [ postDetailView postId ]
                    }

        Japanese ->
            case model.route.page of
                Home ->
                    { title = "かとうよしくに"
                    , body = bodyList model [ homeJapaneseView ]
                    }

                Profile ->
                    { title = "Profile"
                    , body = bodyList model [ profileJapaneseView ]
                    }

                Blog ->
                    { title = "Blog"
                    , body = bodyList model [ postsJapaneseView ]
                    }

                Route.Post postId ->
                    { title = postId
                    , body = bodyList model [ postDetailView postId ]
                    }


bodyList : Model -> List (Html Msg) -> List (Html Msg)
bodyList model pageContent =
    [ div
        [ class <| modeClassName model.currentMode ]
        [ div
            [ class "bg-stone-100 dark:bg-zinc-900 min-h-screen" ]
            [ siteHeader model
            , pageView
                pageContent
            ]
        ]
    ]


siteHeader : Model -> Html Msg
siteHeader model =
    let
        languagePath =
            case model.route.language of
                Default ->
                    "/"

                Japanese ->
                    "/jp/"

        languageSwitchPath =
            case model.route.language of
                Default ->
                    "./jp"

                Japanese ->
                    "/"

        languageSwitchTitle =
            case model.route.language of
                Default ->
                    "日本語"

                Japanese ->
                    "English"

        modeIcon =
            case model.currentMode of
                Dark ->
                    darkModeIcon

                Light ->
                    lightModeIcon

        activePageClass =
            "font-medium border-b-2 border-current"
    in
    header
        [ class "dark:bg-zinc-900" ]
        [ nav
            [ class "flex max-w-5xl mx-auto h-16 justify-between dark:text-white/80  leading-[4rem]" ]
            [ div
                [ class "flex mx-6" ]
                [ a
                    [ title "Yoshikuni Kato", href "/", class "font-bold text-2xl leading-[4rem]" ]
                    [ text "Yoshikuni Kato" ]
                , span
                    [ class "mx-1 inline-flex leading-[4rem]" ]
                    [ button
                        [ class "mx-1 text-2xl leading-[4rem] pt-1", onClick ModeClicked ]
                        [ modeIcon ]
                    , ul
                        [ class "flex" ]
                        [ li
                            [ class "mx-1" ]
                            [ text "|" ]
                        , li
                            [ class "mx-1 text-base leading-[4rem]" ]
                            [ a
                                [ title languageSwitchTitle, href languageSwitchPath ]
                                [ text languageSwitchTitle ]
                            ]
                        ]
                    ]
                ]
            , ul
                [ class "flex space-x-6 mx-6" ]
                [ li
                    []
                    [ a
                        [ title "Profile", href <| languagePath ++ "profile" ]
                        [ span
                            [ class <|
                                case model.route.page of
                                    Profile ->
                                        activePageClass

                                    _ ->
                                        ""
                            ]
                            [ text "Profile" ]
                        ]
                    ]
                , li
                    []
                    [ a
                        [ title "Blog", href <| languagePath ++ "blog" ]
                        [ span
                            [ class <|
                                case model.route.page of
                                    Blog ->
                                        activePageClass

                                    _ ->
                                        ""
                            ]
                            [ text "Blog" ]
                        ]
                    ]
                ]
            ]
        ]


pageView : List (Html Msg) -> Html Msg
pageView contents =
    main_
        [ class "dark:bg-zinc-900" ]
        [ div
            [ class "max-w-3xl mx-auto p-6 dark:text-white/80 text-lg" ]
            contents
        ]


profileView : Html Msg
profileView =
    div [ class "dark:bg-zinc-900" ]
        [ div
            [ class "max-w-3xl mx-auto p-10 dark:text-white/80 text-lg" ]
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
                    [ text "🌏 Originally from Japan, I moved to Prague, the Czech Republic, in 2019 to gain experience working in an international environment. After working on several projects with international colleagues and clients, in 2021, I moved to Amsterdam, the Netherlands, where I can work as a freelancer, to be more ible about technology choice and to work on a wider variety of projects. These moves were motivated by my ambition to contribute to software development culture." ]
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


profileJapaneseView : Html Msg
profileJapaneseView =
    div [] [ text "日本語のプロフィール" ]


postsView : List Post -> Html Msg
postsView posts =
    div [ class "space-y-6" ] <| List.map postView posts


postsJapaneseView : Html Msg
postsJapaneseView =
    div [] [ text "日本語のブログ" ]


postView : Post -> Html Msg
postView post =
    article
        [ class "relative bg-white dark:bg-[#2e2e33] rounded-lg shadow p-5 transition active:scale-95" ]
        [ header
            []
            [ h2
                [ class "text-2xl font-bold text-black/80 dark:text-white/80" ]
                [ text post.title ]
            ]
        , section
            [ class "text-sm leading-relaxed text-ellipsis line-clamp-2 text-black/60 my-2 dark:text-white/60" ]
            [ p
                []
                [ text post.description ]
            ]
        , footer
            [ class "text-sm text-black/60 dark:text-white/60" ]
            [ text post.footerText ]
        , a
            [ class "absolute inset-0"
            , href ("./blog/" ++ post.id)
            ]
            []
        ]


homeView : Model -> Html Msg
homeView model =
    div [ class "space-y-6" ] <|
        homeTopArticleView
            :: List.map postView model.posts


homeJapaneseView : Html Msg
homeJapaneseView =
    div [] [ text "日本語のホーム" ]


homeTopArticleView : Html Msg
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


postDetailView : String -> Html msg
postDetailView postId =
    if postId == "report-2022q2" then
        post1View

    else if postId == "swift-haskell" then
        post2View

    else
        text "Not Found"
