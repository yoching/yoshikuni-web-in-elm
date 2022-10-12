module Main exposing (..)

-- import Hello.World exposing (hello)

import Browser exposing (..)
import Browser.Navigation as Nav
import Debug exposing (todo)
import Html exposing (..)
import Html.Attributes exposing (attribute, class, hidden, href, id, rel, src, style, tabindex, target, title)
import Html.Events exposing (onClick)
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
    [ { title = "Report - 2021 Q4"
      , description = "This is a report of my activities in 2021 Q4. Project changes, learning, and so on!\nClient work New client projects started in this period.\nCoral Thank you, Coral team.I’m looking forward to working with you again.An app project with a Japanese startup Building a new messaging app for teenagers.Using SwiftUI, Firebase, GraphQL, The Composable Architecture(TCA), and so on.An art app project with an artist based in New York Building a photo- based app with some interesting ideas...."
      , footerText = "December 24, 2021 · 2 min"
      , id = "report-2022q2"
      }
    , { title = "Haskell and Swift"
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


post1View : Html msg
post1View =
    article
        []
        [ header
            []
            [ div
                []
                [ a
                    [ href "/" ]
                    [ text "Home" ]
                , text "»"
                , a
                    [ href "/blog" ]
                    [ text "Blog" ]
                ]
            , h1
                []
                [ text "Report - 2021 Q4" ]
            , div
                []
                [ text "December 24, 2021 · 2 min" ]
            ]
        , div
            []
            [ details
                []
                [ summary
                    [ Html.Attributes.accesskey 'c'
                    , title "(Alt + C)"
                    ]
                    [ div
                        []
                        [ text "Table of Contents" ]
                    ]
                , div
                    []
                    [ ul
                        []
                        [ li
                            []
                            [ a
                                [ href "#client-work"
                                , Html.Attributes.attribute "aria-label" "Client work"
                                ]
                                [ text "Client work" ]
                            ]
                        , li []
                            [ a
                                [ href "#learning"
                                , Html.Attributes.attribute "aria-label" "Learning"
                                ]
                                [ text "Learning" ]
                            ]
                        , li []
                            [ a
                                [ href "#events"
                                , Html.Attributes.attribute "aria-label" "Events"
                                ]
                                [ text "Events" ]
                            ]
                        , li []
                            [ a
                                [ href "#work-environment"
                                , Html.Attributes.attribute "aria-label" "Work environment"
                                ]
                                [ text "Work environment" ]
                            ]
                        , li []
                            [ a
                                [ href "#output"
                                , Html.Attributes.attribute "aria-label" "Output"
                                ]
                                [ text "Output" ]
                            ]
                        , li []
                            [ a
                                [ href "#other-stuff"
                                , Html.Attributes.attribute "aria-label" "Other stuff"
                                ]
                                [ text "Other stuff" ]
                            ]
                        ]
                    ]
                ]
            ]
        , div
            []
            [ p
                []
                [ text "This is a report of my activities in 2021 Q4. Project changes, learning, and so on!" ]
            , hr
                []
                []
            , h2
                [ Html.Attributes.id "client-work" ]
                [ text "Client work"
                , a
                    [ Html.Attributes.hidden True
                    , class "anchor"
                    , Html.Attributes.attribute "aria-hidden" "true"
                    , href "#client-work"
                    ]
                    [ text "#" ]
                ]
            , p
                []
                [ text "New client projects started in this period." ]
            , ul
                []
                [ li
                    []
                    [ a
                        [ href "https://coral-app.jp/" ]
                        [ text "Coral" ]
                    , ul
                        []
                        [ li
                            []
                            [ text "Thank you, Coral team. I’m looking forward to working with you again." ]
                        ]
                    ]
                , li
                    []
                    [ text "An app project with a Japanese startup"
                    , ul
                        []
                        [ li
                            []
                            [ text "Building a new messaging app for teenagers." ]
                        , li
                            []
                            [ text "Using SwiftUI, Firebase, GraphQL,"
                            , a
                                [ href "https://github.com/pointfreeco/swift-composable-architecture"
                                ]
                                [ text "The Composable Architecture (TCA)" ]
                            , text ", and so on."
                            ]
                        ]
                    ]
                , li
                    []
                    [ text "An art app project with an artist based in New York"
                    , ul
                        []
                        [ li
                            []
                            [ text "Building a photo-based app with some interesting ideas." ]
                        , li
                            []
                            [ text "Technical consultancy work: giving technical advice and writing code together in pair-programming sessions using"
                            , a
                                [ href "https://tuple.app/" ]
                                [ text "TUPLE" ]
                            , text "."
                            ]
                        ]
                    ]
                ]
            , h2
                [ Html.Attributes.id "learning" ]
                [ text "Learning"
                , a
                    [ Html.Attributes.hidden True
                    , class "anchor"
                    , Html.Attributes.attribute "aria-hidden" "true"
                    , href "#learning"
                    ]
                    [ text "#" ]
                ]
            , ul []
                [ li []
                    [ p []
                        [ text "New programming languages"
                        , br []
                            []
                        , img
                            [ Html.Attributes.attribute "loading" "lazy"
                            , src "./images/IMG_8571_adjusted.jpg"
                            , Html.Attributes.alt ""
                            ]
                            []
                        ]
                    , ul []
                        [ li []
                            [ a
                                [ href "https://doc.rust-lang.org/book/"
                                ]
                                [ text "The Rust Programming Language" ]
                            ]
                        , li []
                            [ a
                                [ href "https://www.manning.com/books/haskell-in-depth"
                                ]
                                [ text "Haskell in Depth" ]
                            ]
                        , li []
                            [ a
                                [ href "https://www.oreilly.com/library/view/programming-typescript/9781492037644/"
                                ]
                                [ text "Programming TypeScript" ]
                            ]
                        , li []
                            [ a
                                [ href "https://eloquentjavascript.net/"
                                ]
                                [ text "Eloquent JavaScript" ]
                            ]
                        ]
                    , p []
                        [ text "These correspond to areas that I chose and explained in a post “"
                        , a
                            [ href "/blog/2021/tech-areas"
                            ]
                            [ text "Three tech areas I’m going into" ]
                        , text "”."
                        , br []
                            []
                        , text "By the way, I’m coming back to printed books as I had problems with my eyes caused by watching screens too long. I prefer reading printed books to reading them online."
                        ]
                    ]
                , li []
                    [ p []
                        [ text "New tool trials" ]
                    , ul []
                        [ li []
                            [ a
                                [ href "https://reactjs.org/docs/create-a-new-react-app.html#create-react-app"
                                ]
                                [ text "React" ]
                            ]
                        , li []
                            [ a
                                [ href "https://nextjs.org/"
                                ]
                                [ text "Next.js" ]
                            , br []
                                []
                            , text "Using Next.js was quite an interesting experience. As I used to use nodejs, I realized so many things have changed in the JS environment in the past few years."
                            ]
                        , li []
                            [ a
                                [ href "https://nixos.org/"
                                ]
                                [ text "Nix" ]
                            ]
                        ]
                    ]
                , li []
                    [ p []
                        [ a
                            [ href "https://adventofcode.com/"
                            ]
                            [ text "Advent of Code" ]
                        , text "in Rust, Haskell, etc."
                        ]
                    ]
                ]
            , h2
                [ Html.Attributes.id "events"
                ]
                [ text "Events"
                , a
                    [ Html.Attributes.hidden True
                    , class "anchor"
                    , Html.Attributes.attribute "aria-hidden" "true"
                    , href "#events"
                    ]
                    [ text "#" ]
                ]
            , ul []
                [ li []
                    [ a
                        [ href "https://v2.nl/events/a-crash-course-in-art-media-technolgy-media-art-x-painting"
                        ]
                        [ text "Crash Course in Art & Media Technology" ]
                    , text "at V2.nl"
                    , br []
                        []
                    , text "A series about “Media Art x [Painting, Sculpture, Photography, Filmmaking]”. I attended all four lectures and liked the first one about paintings the most."
                    ]
                , li []
                    [ a
                        [ href "https://ddw.nl/"
                        ]
                        [ text "Dutch Design Week" ]
                    , text "at Eindhoven"
                    , br []
                        []
                    , text "Graduation Show of The Design Academy Eindhoven was great."
                    ]
                , li []
                    [ a
                        [ href "https://re-nature.org/"
                        ]
                        [ text "RE_NATURE exhibition" ]
                    , text "at DenBosch"
                    ]
                , li []
                    [ a
                        [ href "https://www.upstreamgallery.nl/exhibitions/209/mechanical-paintings"
                        ]
                        [ text "Rafaël Rozendaal" ]
                    , text "at Upstream Gallery in Amsterdam"
                    ]
                , li []
                    [ text "Academic institute research"
                    , ul []
                        [ li []
                            [ a
                                [ href "https://www.uu.nl/masters/en/general-information/international-students/contact-and-more-information/masters-open-day"
                                ]
                                [ text "Master’s Open Day at Utrecht University" ]
                            ]
                        , li []
                            [ a
                                [ href "https://www.uva.nl/en/education/open-days/masters/masters-week/masters-week-pre-registraton.html"
                                ]
                                [ text "University of Amsterdam (UvA) Master’s Week" ]
                            ]
                        ]
                    ]
                , li []
                    [ a
                        [ href "https://www.meetup.com/Appsterdam/events/280823049"
                        ]
                        [ text "Coffee Coding meetup" ]
                    ]
                , li []
                    [ a
                        [ href "https://www.meetup.com/broadcast-amsterdam/events/281719272/"
                        ]
                        [ text "Broadcast Amsterdam meetup" ]
                    ]
                ]
            , h2
                [ Html.Attributes.id "work-environment"
                ]
                [ text "Work environment"
                , a
                    [ Html.Attributes.hidden True
                    , class "anchor"
                    , Html.Attributes.attribute "aria-hidden" "true"
                    , href "#work-environment"
                    ]
                    [ text "#" ]
                ]
            , ul []
                [ li []
                    [ p []
                        [ text "New coworking space"
                        , br []
                            []
                        , text "I started using"
                        , a
                            [ href "https://www.thestudenthotel.com/amsterdam-city/co-working-space/"
                            ]
                            [ text "TSH Collab Amsterdam City" ]
                        , text ". Come and see me!"
                        ]
                    ]
                , li []
                    [ p []
                        [ text "Monitor light bar" ]
                    , div
                        [ class "twitter-tweet twitter-tweet-rendered"
                        , Html.Attributes.style "display" "flex"
                        , Html.Attributes.style "max-width" "550px"
                        , Html.Attributes.style "width" "100%"
                        , Html.Attributes.style "margin-top" "10px"
                        , Html.Attributes.style "margin-bottom" "10px"
                        ]
                        [ iframe
                            [ Html.Attributes.id "twitter-widget-0"
                            , Html.Attributes.attribute "scrolling" "no"
                            , Html.Attributes.attribute "frameborder" "0"
                            , Html.Attributes.attribute "allowtransparency" "true"
                            , Html.Attributes.attribute "allowfullscreen" "true"
                            , class ""
                            , Html.Attributes.style "position" "static"
                            , Html.Attributes.style "visibility" "visible"
                            , Html.Attributes.style "width" "550px"
                            , Html.Attributes.style "height" "650px"
                            , Html.Attributes.style "display" "block"
                            , Html.Attributes.style "flex-grow" "1"
                            , title "Twitter Tweet"
                            , src "https://platform.twitter.com/embed/Tweet.html?dnt=false&embedId=twitter-widget-0&features=eyJ0ZndfdGltZWxpbmVfbGlzdCI6eyJidWNrZXQiOlsibGlua3RyLmVlIiwidHIuZWUiXSwidmVyc2lvbiI6bnVsbH0sInRmd19ob3Jpem9uX3RpbWVsaW5lXzEyMDM0Ijp7ImJ1Y2tldCI6InRyZWF0bWVudCIsInZlcnNpb24iOm51bGx9LCJ0ZndfdHdlZXRfZWRpdF9iYWNrZW5kIjp7ImJ1Y2tldCI6Im9uIiwidmVyc2lvbiI6bnVsbH0sInRmd19yZWZzcmNfc2Vzc2lvbiI6eyJidWNrZXQiOiJvbiIsInZlcnNpb24iOm51bGx9LCJ0ZndfY2hpbl9waWxsc18xNDc0MSI6eyJidWNrZXQiOiJjb2xvcl9pY29ucyIsInZlcnNpb24iOm51bGx9LCJ0ZndfdHdlZXRfcmVzdWx0X21pZ3JhdGlvbl8xMzk3OSI6eyJidWNrZXQiOiJ0d2VldF9yZXN1bHQiLCJ2ZXJzaW9uIjpudWxsfSwidGZ3X3NlbnNpdGl2ZV9tZWRpYV9pbnRlcnN0aXRpYWxfMTM5NjMiOnsiYnVja2V0IjoiaW50ZXJzdGl0aWFsIiwidmVyc2lvbiI6bnVsbH0sInRmd19leHBlcmltZW50c19jb29raWVfZXhwaXJhdGlvbiI6eyJidWNrZXQiOjEyMDk2MDAsInZlcnNpb24iOm51bGx9LCJ0ZndfZHVwbGljYXRlX3NjcmliZXNfdG9fc2V0dGluZ3MiOnsiYnVja2V0Ijoib24iLCJ2ZXJzaW9uIjpudWxsfSwidGZ3X3R3ZWV0X2VkaXRfZnJvbnRlbmQiOnsiYnVja2V0Ijoib2ZmIiwidmVyc2lvbiI6bnVsbH19&frame=false&hideCard=false&hideThread=false&id=1454180135989612549&lang=en&origin=https%3A%2F%2Fyoshikuni-web.com%2Fblog%2F2021%2Freport-2021q4%2F&sessionId=f4e4457c2ca4db920180a923f2d508dc2c5f3da5&theme=light&widgetsVersion=1bfeb5c3714e8%3A1661975971032&width=550px"
                            , Html.Attributes.attribute "data-tweet-id" "1454180135989612549"
                            ]
                            []
                        ]
                    , node "script"
                        [ Html.Attributes.attribute "async" ""
                        , src "https://platform.twitter.com/widgets.js"
                        ]
                        []
                    ]
                , li []
                    [ p []
                        [ text "Heavier keyboard switches"
                        , br []
                            []
                        , text "Changed the switches of my ErgoDoxEZ from"
                        , a
                            [ href "https://www.cherrymx.de/en/cherry-mx/mx-original/mx-silent-red.html"
                            ]
                            [ text "Cherry MX Silent Red" ]
                        , text "to"
                        , a
                            [ href "https://www.cherrymx.de/en/cherry-mx/mx-special/mx-clear.html"
                            ]
                            [ text "Cherry MX Clear" ]
                        , text "because I wanted heavier keys for my fingers to move more. Typing is fun with the new switches."
                        ]
                    ]
                ]
            , h2
                [ Html.Attributes.id "output"
                ]
                [ text "Output"
                , a
                    [ Html.Attributes.hidden True
                    , class "anchor"
                    , Html.Attributes.attribute "aria-hidden" "true"
                    , href "#output"
                    ]
                    [ text "#" ]
                ]
            , ul []
                [ li []
                    [ a
                        [ href "/ja/blog/2021/prague-cafe/"
                        ]
                        [ text "Cafes and Burgers in Prague" ]
                    , text "(only in Japanese), 15 October"
                    ]
                ]
            , h2
                [ Html.Attributes.id "other-stuff"
                ]
                [ text "Other stuff"
                , a
                    [ Html.Attributes.hidden True
                    , class "anchor"
                    , Html.Attributes.attribute "aria-hidden" "true"
                    , href "#other-stuff"
                    ]
                    [ text "#" ]
                ]
            , ul []
                [ li []
                    [ a
                        [ href "https://blog.rust-lang.org/2021/12/08/survey-launch.html"
                        ]
                        [ text "Rust Survey" ]
                    , text "Japanese translation help✨"
                    ]
                , li []
                    [ text "Sales activities and networking" ]
                , li []
                    [ text "Made a plan to visit Japan (and booked flights), but canceled due to entry restriction change. I’m looking for another opportunity to visit there." ]
                ]
            , hr []
                []
            , p []
                [ text "As I also wrote"
                , a
                    [ href "/blog/2021/report-2021/"
                    ]
                    [ text "2021 Summary" ]
                , text ", please read it if you have interests."
                , br []
                    []
                , text "Happy holidays🎄"
                ]
            ]
        , footer
            [ class "post-footer"
            ]
            [ nav
                [ class "paginav"
                ]
                [ a
                    [ class "prev"
                    , href "https://yoshikuni-web.com/blog/2021/report-2021/"
                    ]
                    [ span
                        [ class "title"
                        ]
                        [ text "« Prev Page" ]
                    , br []
                        []
                    , span []
                        [ text "2021 Summary - First year of freelancing" ]
                    ]
                , a
                    [ class "next"
                    , href "https://yoshikuni-web.com/blog/2021/report-2021q3/"
                    ]
                    [ span
                        [ class "title"
                        ]
                        [ text "Next Page »" ]
                    , br []
                        []
                    , span []
                        [ text "Report - July to September, 2021" ]
                    ]
                ]
            ]
        ]


post2View : Html msg
post2View =
    article
        [ class "post-single" ]
        [ postDetailHeader "Haskell and Swift" "July 23, 2021 · 4 min"
        , div
            [ class "post-content" ]
            [ postContentP []
                [ text "Hello, world. Let me share some of my findings of "
                , a
                    [ href "https://www.haskell.org/" ]
                    [ text "Haskell" ]
                , text " and "
                , a
                    [ href "https://swift.org/" ]
                    [ text "Swift" ]
                , text "."
                ]
            , postContentP []
                [ text "I got interested in functional programming, especially in Haskell, when I realized that most of my favorite Swift features come from functional programming. My favorite features include"
                , codeInline []
                    [ text "enum" ]
                , text "with associated values,"
                , codeInline []
                    [ text "Result" ]
                , text "type, higher-order functions (i.e. passing functions themselves),"
                , codeInline []
                    [ text "KeyPath" ]
                , text "type, and so on."
                ]
            , postContentP []
                [ text "After started learning Haskell, I found there are more common features between Swift and Haskell than I expected. Some data types are essentially the same, some syntax is similar, and some concepts are common. In fact, "
                , a
                    [ href "https://en.wikipedia.org/wiki/Chris_Lattner"
                    ]
                    [ text "Chris Lattner" ]
                , text ", who is the main author of Swift, confirms that Generics in Swift is inspired by Haskell according to "
                , a
                    [ href "https://www.swiftbysundell.com/podcast/100/"
                    ]
                    [ text "an interview" ]
                , text "."
                ]
            , postContentP []
                [ text "I’m gonna share some similarities I found in Haskell and Swift, and the limitations of Swift compared to Haskell." ]
            , postDetailHr
            , postDetailH2 [] [ text "Corresponding concepts" ]
            , postContentP []
                [ text "These are some syntax, data types, and concepts both languages have." ]
            , table [ class "mb-8" ]
                [ thead []
                    [ tr [ class "border-b border-gray-700" ]
                        [ th [ class "text-sm py-3 px-2 text-left" ]
                            [ text "Swift" ]
                        , th [ class "text-sm text-left py-3 px-2" ]
                            [ text "Haskell" ]
                        ]
                    ]
                , tbody []
                    [ tr [ class "border-b border-gray-700" ]
                        [ td [ class "text-lg py-3 px-2" ]
                            [ text "Generics:"
                            , br []
                                []
                            , text "e.g."
                            , codeInline []
                                [ text "struct GenericType<A, B>" ]
                            ]
                        , td [ class "text-lg py-3 px-2" ]
                            [ text "Type Constructor:"
                            , br []
                                []
                            , text "e.g."
                            , codeInline []
                                [ text "data SomeType a b" ]
                            , br []
                                []
                            , codeInline []
                                [ text "a" ]
                            , text "and"
                            , codeInline []
                                [ text "b" ]
                            , text "are called type parameters"
                            ]
                        ]
                    , tr [ class "border-b border-gray-700" ]
                        [ td [ class "text-lg py-3 px-2" ]
                            [ text "Protocol:"
                            , codeInline []
                                [ text "protocol" ]
                            ]
                        , td [ class "text-lg py-3 px-2" ]
                            [ text "Type Class:"
                            , codeInline []
                                [ text "class" ]
                            ]
                        ]
                    , tr [ class "border-b border-gray-700" ]
                        [ td [ class "text-lg py-3 px-2" ]
                            [ text "Protocol conformance:"
                            , br []
                                []
                            , codeInline []
                                [ text "extension SomeType: SomeProtocol {" ]
                            ]
                        , td [ class "text-lg py-3 px-2" ]
                            [ text "Instance declaration:"
                            , br []
                                []
                            , codeInline []
                                [ text "instance SomeClass SomeType where" ]
                            ]
                        ]
                    , tr [ class "border-b border-gray-700" ]
                        [ td [ class "text-lg py-3 px-2" ]
                            [ codeInline []
                                [ text "enum" ]
                            , text "with associated value"
                            ]
                        , td [ class "text-lg py-3 px-2" ]
                            [ a
                                [ href "https://en.wikipedia.org/wiki/Algebraic_data_type"
                                ]
                                [ text "Algebraic Data Type" ]
                            , text ":"
                            , codeInline []
                                [ text "data" ]
                            ]
                        ]
                    , tr [ class "border-b border-gray-700" ]
                        [ td [ class "text-lg py-3 px-2" ]
                            [ codeInline []
                                [ text "enum Optional<Wrapped>" ]
                            ]
                        , td [ class "text-lg py-3 px-2" ]
                            [ codeInline []
                                [ text "data Maybe a" ]
                            ]
                        ]
                    , tr [ class "border-b border-gray-700" ]
                        [ td [ class "text-lg py-3 px-2" ]
                            [ codeInline []
                                [ text "enum Result<Success, Failure>" ]
                            ]
                        , td [ class "text-lg py-3 px-2" ]
                            [ codeInline []
                                [ text "data Either a b" ]
                            ]
                        ]
                    , tr [ class "border-b border-gray-700" ]
                        [ td [ class "text-lg py-3 px-2" ]
                            [ text "Closure:"
                            , codeInline []
                                [ text "{ A -> B in ... }" ]
                            ]
                        , td [ class "text-lg py-3 px-2" ]
                            [ text "Lambda:"
                            , codeInline []
                                [ text "\\a -> ..." ]
                            ]
                        ]
                    , tr [ class "border-b border-gray-700" ]
                        [ td [ class "text-lg py-3 px-2" ]
                            [ text "Closure type declaration:"
                            , br []
                                []
                            , codeInline []
                                [ text "var foo: (A -> B -> C)" ]
                            ]
                        , td [ class "text-lg py-3 px-2" ]
                            [ text "Function signature:"
                            , br []
                                []
                            , codeInline []
                                [ text "foo :: A -> B -> C" ]
                            ]
                        ]
                    ]
                ]
            , postContentP []
                [ text "There are more common features such as:" ]
            , ul [ class "list-disc list-inside mb-5 pl-5" ]
                [ li []
                    [ text "Type inference" ]
                , li []
                    [ text "Pattern matching" ]
                , li []
                    [ codeInline []
                        [ text "KeyPath" ]
                    , text " is “Lens” (e.g. "
                    , a
                        [ href "https://www.47deg.com/blog/keypaths-optics/"
                        ]
                        [ text "Swift KeyPaths under a different optic" ]
                    , text ")"
                    ]
                ]
            , postContentP []
                [ text "By the way, “Type constructor”, “Type parameter”, “Type class”, … It seems Haskell terminology is built around "
                , strong []
                    [ text "Types" ]
                , text ", and Haskell seems to be very aware of handling types."
                ]
            , postDetailHr
            , postDetailH2
                [ id "in-haskell-but-not-in-swift" ]
                [ text "In Haskell, but not in Swift"
                , a
                    [ hidden True
                    , class "anchor"
                    , attribute "aria-hidden" "true"
                    , href "#in-haskell-but-not-in-swift"
                    ]
                    [ text "#" ]
                ]
            , postContentP []
                [ text "Even though there are a lot of similarities, there are also some patterns that cannot be written simply in Swift." ]
            , postContentH3
                [ id "higher-kinded-type" ]
                [ text "Higher-Kinded Type"
                , a
                    [ hidden True
                    , class "anchor"
                    , attribute "aria-hidden" "true"
                    , href "#higher-kinded-type"
                    ]
                    [ text "#" ]
                ]
            , postContentP []
                [ text "For example,"
                , codeInline []
                    [ text "Functor" ]
                , text "class, which is like a protocol that has"
                , codeInline []
                    [ text "fmap" ]
                , text "function in Swift terms, cannot be directly translated into Swift."
                ]
            , div
                [ class "highlight" ]
                [ pre
                    -- [ tabindex 0
                    -- , style "color" "#f8f8f2"
                    -- , style "background-color" "#272822"
                    -- , style "-moz-tab-size" "4"
                    -- , style "-o-tab-size" "4"
                    -- , style "tab-size" "4"
                    []
                    [ codeBlock
                        [ class "language-Haskell", attribute "data-lang" "Haskell" ]
                        [ span
                            [ style "display" "flex" ]
                            [ span []
                                [ span
                                    [ style "color" "#75715e" ]
                                    [ text "-- Haskell" ]
                                ]
                            ]
                        , span
                            [ style "display" "flex"
                            ]
                            [ span []
                                [ span
                                    [ style "color" "#66d9ef"
                                    ]
                                    [ text "class " ]
                                , span
                                    [ style "color" "#66d9ef"
                                    ]
                                    [ text "Functor " ]
                                , text "f "
                                , span
                                    [ style "color" "#66d9ef"
                                    ]
                                    [ text "where" ]
                                ]
                            ]
                        , span
                            [ style "display" "flex"
                            ]
                            [ span []
                                [ text "    fmap"
                                , span
                                    [ style "color" "#f92672"
                                    ]
                                    [ text " :: " ]
                                , text "(a"
                                , span
                                    [ style "color" "#f92672"
                                    ]
                                    [ text " -> " ]
                                , text "b)"
                                , span
                                    [ style "color" "#f92672"
                                    ]
                                    [ text " -> " ]
                                , text "f a"
                                , span
                                    [ style "color" "#f92672"
                                    ]
                                    [ text " -> " ]
                                , text "f b"
                                ]
                            ]
                        , span
                            [ style "display" "flex"
                            ]
                            [ span []
                                [ span
                                    [ style "color" "#f92672"
                                    ]
                                    [ text "    ..." ]
                                ]
                            ]
                        ]
                    ]
                , button
                    [ class "copy-code"
                    ]
                    [ text "copy" ]
                ]
            , div
                [ class "highlight"
                ]
                [ pre
                    [ tabindex 0
                    , style "color" "#f8f8f2"
                    , style "background-color" "#272822"
                    , style "-moz-tab-size" "4"
                    , style "-o-tab-size" "4"
                    , style "tab-size" "4"
                    ]
                    [ codeBlock
                        [ class "language-Swift hljs"
                        , attribute "data-lang" "Swift"
                        ]
                        [ span
                            [ style "display" "flex"
                            ]
                            [ span []
                                [ span
                                    [ style "color" "#75715e"
                                    ]
                                    [ span
                                        [ class "hljs-comment"
                                        ]
                                        [ text "// Psuedo-Swift" ]
                                    ]
                                ]
                            ]
                        , span
                            [ style "display" "flex"
                            ]
                            [ span []
                                [ span
                                    [ style "color" "#66d9ef"
                                    ]
                                    [ span
                                        [ class "hljs-class"
                                        ]
                                        [ span
                                            [ class "hljs-keyword"
                                            ]
                                            [ text "protocol " ]
                                        ]
                                    ]
                                , span
                                    [ class "hljs-class"
                                    ]
                                    []
                                , span
                                    [ style "color" "#a6e22e"
                                    ]
                                    [ span
                                        [ class "hljs-class"
                                        ]
                                        [ span
                                            [ class "hljs-title"
                                            ]
                                            [ text "Functor " ]
                                        ]
                                    ]
                                , span
                                    [ class "hljs-class"
                                    ]
                                    [ span
                                        [ class "hljs-title"
                                        ]
                                        [ text "F " ]
                                    ]
                                , text "{ "
                                , span
                                    [ style "color" "#75715e"
                                    ]
                                    [ span
                                        [ class "hljs-comment"
                                        ]
                                        [ text "// `F` needs to be a type constructor. General type constructor cannot be written in Swift." ]
                                    ]
                                ]
                            ]
                        , span
                            [ style "display" "flex"
                            ]
                            [ span []
                                [ span
                                    [ style "color" "#66d9ef"
                                    ]
                                    [ span
                                        [ class "hljs-function"
                                        ]
                                        [ span
                                            [ class "hljs-keyword"
                                            ]
                                            [ text "    func " ]
                                        ]
                                    ]
                                , span
                                    [ class "hljs-function"
                                    ]
                                    []
                                , span
                                    [ style "color" "#a6e22e"
                                    ]
                                    [ span
                                        [ class "hljs-function"
                                        ]
                                        [ span
                                            [ class "hljs-title"
                                            ]
                                            [ text "fmap" ]
                                        ]
                                    ]
                                , span
                                    [ class "hljs-function"
                                    ]
                                    [ text "<A, B>"
                                    , span
                                        [ class "hljs-params"
                                        ]
                                        [ text "(" ]
                                    ]
                                , span
                                    [ style "color" "#66d9ef"
                                    ]
                                    [ span
                                        [ class "hljs-function"
                                        ]
                                        [ span
                                            [ class "hljs-params"
                                            ]
                                            [ span
                                                [ class "hljs-number"
                                                ]
                                                [ text "_ " ]
                                            ]
                                        ]
                                    ]
                                , span
                                    [ class "hljs-function"
                                    ]
                                    [ span
                                        [ class "hljs-params"
                                        ]
                                        [ text "f: "
                                        , span
                                            [ class "hljs-params"
                                            ]
                                            [ text "(A) " ]
                                        ]
                                    ]
                                , text "-> "
                                , span
                                    [ class "hljs-type"
                                    ]
                                    [ text "B" ]
                                , text ") -> "
                                , span
                                    [ class "hljs-type"
                                    ]
                                    [ text "F" ]
                                , text "<"
                                , span
                                    [ class "hljs-type"
                                    ]
                                    [ text "A" ]
                                , text "> -> "
                                , span
                                    [ class "hljs-type"
                                    ]
                                    [ text "F" ]
                                , text "<"
                                , span
                                    [ class "hljs-type"
                                    ]
                                    [ text "B" ]
                                , text ">"
                                ]
                            ]
                        , span
                            [ style "display" "flex"
                            ]
                            [ span []
                                [ text "    ..." ]
                            ]
                        , span
                            [ style "display" "flex"
                            ]
                            [ span []
                                [ text "}" ]
                            ]
                        ]
                    ]
                , button
                    [ class "copy-code"
                    ]
                    [ text "copy" ]
                ]
            , postContentP []
                [ codeInline []
                    [ text "F" ]
                , text "could be"
                , codeInline []
                    [ text "Optional" ]
                , text "(not"
                , codeInline []
                    [ text "Optional<A>" ]
                , text "), or"
                , codeInline []
                    [ text "Result<Int, /* some general type parameter */>" ]
                , text ". However, Swift hasn’t supported this kind of syntax."
                , br []
                    []
                , text "Higher-Kinded Type (HKT) support is necessary for this. "
                , a
                    [ href "https://bow-swift.io/"
                    ]
                    [ text "Bow-Swift" ]
                , text " includes a great document about this topic "
                , a
                    [ href "https://bow-swift.io/docs/fp-concepts/higher-kinded-types/"
                    ]
                    [ text "here" ]
                , text "."
                ]
            , postContentH3
                [ id "io-type" ]
                [ text "IO type"
                , a
                    [ hidden True
                    , class "anchor"
                    , attribute "aria-hidden" "true"
                    , href "#io-type"
                    ]
                    [ text "#" ]
                ]
            , postContentP []
                [ text "In Haskell, since all functions are pure, side effects can be written only in a type called"
                , codeInline []
                    [ text "IO" ]
                , text ". On the other hand, in Swift, side effects can be written anywhere."
                , br []
                    []
                , text "As limiting the place to write side effects leads to more robust and testable codes, I sometimes miss this feature when I go back to writing Swift."
                ]
            , postContentH3
                [ id "and-more-and-more"
                ]
                [ text "And, more and more!"
                , a
                    [ hidden True
                    , class "anchor"
                    , attribute "aria-hidden" "true"
                    , href "#and-more-and-more"
                    ]
                    [ text "#" ]
                ]
            , postContentP []
                [ text "The Haskell world is vast. There are numerous interesting concepts and ways of thinking about programming, that don’t exist in other languages." ]
            , postDetailHr
            , postDetailH2
                [ id "references" ]
                [ text "References"
                , a
                    [ hidden True
                    , class "anchor"
                    , attribute "aria-hidden" "true"
                    , href "#references"
                    ]
                    [ text "#" ]
                ]
            , postContentH3
                [ id "for-swift-programmers"
                ]
                [ text "For Swift programmers"
                , a
                    [ hidden True
                    , class "anchor"
                    , attribute "aria-hidden" "true"
                    , href "#for-swift-programmers"
                    ]
                    [ text "#" ]
                ]
            , postContentP []
                [ text "If you’re a Swift programmer, these materials are excellent to get into functional programming. I learned a lot from these. Highly recommended." ]
            , ul [ class "list-disc mb-5 block pl-5" ]
                [ li []
                    [ a
                        [ href "https://www.pointfree.co/"
                        ]
                        [ text "Point-Free" ]
                    , text ": A video series exploring functional programming and Swift."
                    ]
                , li []
                    [ a
                        [ href "https://bow-swift.io/"
                        ]
                        [ text "Bow-Swift" ]
                    , text ": A library for Typed Functional Programming in Swift"
                    ]
                ]
            , postContentH3
                [ id "start-learning-haskell"
                ]
                [ text "Start learning Haskell"
                , a
                    [ hidden True
                    , class "anchor"
                    , attribute "aria-hidden" "true"
                    , href "#start-learning-haskell"
                    ]
                    [ text "#" ]
                ]
            , ul [ class "list-disc mb-5 pl-5" ]
                [ li []
                    [ a
                        [ href "http://learnyouahaskell.com/"
                        ]
                        [ text "Learn You a Haskell for Great Good!" ]
                    , br []
                        []
                    , text "A famous book. Good for beginners."
                    ]
                , li []
                    [ a
                        [ href "https://haskellbook.com/"
                        ]
                        [ text "Haskell Programming from first principles" ]
                    , br []
                        []
                    , text "I’m reading this too. This covers more topics than the one above."
                    ]
                ]
            , postContentH3
                [ id "haskell-conferencesevents"
                ]
                [ text "Haskell conferences/events"
                , a
                    [ hidden True
                    , class "anchor"
                    , attribute "aria-hidden" "true"
                    , href "#haskell-conferencesevents"
                    ]
                    [ text "#" ]
                ]
            , ul [ class "list-disc mb-5 pl-5" ]
                [ li []
                    [ a
                        [ href "https://zfoh.ch/zurihac2021/"
                        ]
                        [ text "ZuriHac" ]
                    , text ": June 18-20, 2021"
                    , br []
                        []
                    , text "I attended this year. Great talks and a very welcoming atmosphere!"
                    ]
                , li []
                    [ a
                        [ href "https://utrechtsummerschool.nl/courses/science//applied-functional-programming-in-haskell"
                        ]
                        [ text "Applied Functional Programming in Haskell" ]
                    , text "at Summer School Utrecht, July 05-09, 2021"
                    , br []
                        []
                    , text "I also attended this course this summer. There were a lot of intermediate/advanced topics. It’s also nice to know how Haskell is discussed in academics."
                    ]
                , li []
                    [ a
                        [ href "https://haskell.love/"
                        ]
                        [ text "Haskell Love Conference" ]
                    , text ": Sep 10, 2021, online"
                    ]
                , li []
                    [ a
                        [ href "https://skillsmatter.com/conferences/13256-haskell-exchange-2021"
                        ]
                        [ text "Haskell eXchange" ]
                    , text ": Nov 16-17, 2021, online"
                    , br []
                        []
                    , text "Looking forward to these two this fall."
                    ]
                ]
            , postDetailHr
            , postContentP []
                [ text "Thank you for reading! Please reach out to "
                , a
                    [ href "https://twitter.com/yoshikuni_kato"
                    ]
                    [ text "@yoshikuni_kato" ]
                , text " if you have any questions or comments. Enjoy functional programming!"
                ]
            ]
        , footer
            [ class "post-footer mt-14 block" ]
            [ nav
                [ class "paginav flex rounded-lg bg-gray-700 leading-8" ]
                [ a
                    [ class "prev w-3/6 px-3 text-left"
                    , href "https://yoshikuni-web.com/blog/2021/presentations/"
                    ]
                    [ span
                        [ class "title text-sm tracking-widest uppercase opacity-50" ]
                        [ text "« Prev Page" ]
                    , br []
                        []
                    , span []
                        [ text "My past presentations" ]
                    ]
                , a
                    [ class "next w-3/6 px-3 text-right"
                    , href "https://yoshikuni-web.com/blog/2021/report-2021q2/"
                    ]
                    [ span
                        [ class "title text-sm tracking-widest uppercase opacity-50" ]
                        [ text "Next Page »" ]
                    , br []
                        []
                    , span []
                        [ text "Report - April to June, 2021" ]
                    ]
                ]
            ]
        ]


postDetailHeader : String -> String -> Html msg
postDetailHeader title date =
    header
        [ class "my-6" ]
        [ div
            [ class "leading-6" ]
            [ a
                [ href "/" ]
                [ text "Home" ]
            , text "»"
            , a
                [ href "/blog" ]
                [ text "Blog" ]
            ]
        , h1
            [ class "text-4xl font-bold" ]
            [ text title ]
        , div
            [ class "text-sm" ]
            [ text date ]
        ]


postDetailHr : Html msg
postDetailHr =
    hr
        [ class "my-7 h-0.5 bg-white opacity-20" ]
        []


postDetailH2 : List (Attribute msg) -> List (Html msg) -> Html msg
postDetailH2 attributes content =
    h2 (class "text-3xl font-bold mt-8 mb-6" :: attributes)
        content


descriptionA : String -> String -> Html msg
descriptionA title link =
    a [ href link, class "underline underline-offset-4" ]
        [ text title ]


postContentP : List (Attribute msg) -> List (Html msg) -> Html msg
postContentP attributes contents =
    p (attributes ++ [ class "mb-5" ])
        contents


postContentH3 : List (Attribute msg) -> List (Html msg) -> Html msg
postContentH3 attributes content =
    h3 (class "text-2xl font-bold mt-6 mb-4" :: attributes)
        content


codeInline : List (Attribute msg) -> List (Html msg) -> Html msg
codeInline attr content =
    code (class "bg-gray-700 mx-1 px-2 py-1 text-base font-mono" :: attr)
        content


codeBlock : List (Attribute msg) -> List (Html msg) -> Html msg
codeBlock attr content =
    code (class "block bg-gray-700 p-2 text-base font-mono rounded-lg overflow-x-auto" :: attr)
        content
