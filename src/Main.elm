module Main exposing (Flags, Mode, Model, Msg, main)

import Browser exposing (Document, UrlRequest(..))
import Browser.Navigation as Nav
import Entities.Post exposing (Post)
import Html exposing (..)
import Html.Attributes exposing (class, href, title)
import Html.Events exposing (onClick)
import Pages.Home.Home exposing (homeJapaneseView, homeView)
import Pages.PostDetail.PostDetail exposing (postDetailView)
import Pages.PostList.PostList exposing (postListJapaneseView, postListView)
import Pages.Profile.Profile exposing (profileJapaneseView, profileView)
import Route exposing (Language(..), Page(..), Route, routeParser)
import UIElements.SvgImages exposing (darkModeIcon, lightModeIcon)
import Url
import Url.Parser


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


type alias Flags =
    {}


type Msg
    = UrlChanged Url.Url
    | LinkClicked UrlRequest
    | ModeClicked


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


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none


view : Model -> Document Msg
view model =
    case model.route.language of
        Default ->
            case model.route.page of
                Home ->
                    { title = "Yoshikuni Kato"
                    , body = bodyList model [ homeView model.posts ]
                    }

                Profile ->
                    { title = "Profile"
                    , body = bodyList model [ profileView ]
                    }

                Blog ->
                    { title = "Blog"
                    , body = bodyList model [ postListView model.posts ]
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
                    , body = bodyList model [ postListJapaneseView ]
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
            , pageView pageContent
            ]
        ]
    ]


siteHeader : Model -> Html Msg
siteHeader model =
    let
        languagePath : String
        languagePath =
            case model.route.language of
                Default ->
                    "/"

                Japanese ->
                    "/jp/"

        languageSwitchPath : String
        languageSwitchPath =
            case model.route.language of
                Default ->
                    "./jp"

                Japanese ->
                    "/"

        languageSwitchTitle : String
        languageSwitchTitle =
            case model.route.language of
                Default ->
                    "日本語"

                Japanese ->
                    "English"

        modeIcon : Html msg
        modeIcon =
            case model.currentMode of
                Dark ->
                    darkModeIcon

                Light ->
                    lightModeIcon
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
                [ headerMenuItem
                    "Profile"
                    (languagePath ++ "profile")
                    (model.route.page == Profile)
                , headerMenuItem
                    "Blog"
                    (languagePath ++ "blog")
                    (model.route.page == Blog)
                ]
            ]
        ]


headerMenuItem : String -> String -> Bool -> Html msg
headerMenuItem name link isActive =
    let
        className : String
        className =
            if isActive then
                "font-medium border-b-2 border-current"

            else
                ""
    in
    li
        []
        [ a
            [ title name, href link ]
            [ span
                [ class className ]
                [ text name ]
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
