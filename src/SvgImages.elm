module SvgImages exposing (..)

import Html exposing (Html)
import Html.Attributes exposing (class)
import Svg
import Svg.Attributes as SvgAttr


darkModeIcon : Html msg
darkModeIcon =
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


lightModeIcon : Html msg
lightModeIcon =
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


githubIcon : Html msg
githubIcon =
    Svg.svg
        [ SvgAttr.viewBox "0 0 24 24"
        , SvgAttr.fill "none"
        , SvgAttr.stroke "currentcolor"
        , SvgAttr.strokeWidth "2"
        , SvgAttr.strokeLinecap "round"
        , SvgAttr.strokeLinejoin "round"
        ]
        [ Svg.path
            [ SvgAttr.d "M9 19c-5 1.5-5-2.5-7-3m14 6v-3.87a3.37 3.37.0 00-.94-2.61c3.14-.35 6.44-1.54 6.44-7A5.44 5.44.0 0020 4.77 5.07 5.07.0 0019.91 1S18.73.65 16 2.48a13.38 13.38.0 00-7 0C6.27.65 5.09 1 5.09 1A5.07 5.07.0 005 4.77 5.44 5.44.0 003.5 8.55c0 5.42 3.3 6.61 6.44 7A3.37 3.37.0 009 18.13V22"
            ]
            []
        ]


twitterIcon : Html msg
twitterIcon =
    Svg.svg
        [ SvgAttr.viewBox "0 0 24 24"
        , SvgAttr.fill "none"
        , SvgAttr.stroke "currentcolor"
        , SvgAttr.strokeWidth "2"
        , SvgAttr.strokeLinecap "round"
        , SvgAttr.strokeLinejoin "round"
        ]
        [ Svg.path
            [ SvgAttr.d "M23 3a10.9 10.9.0 01-3.14 1.53 4.48 4.48.0 00-7.86 3v1A10.66 10.66.0 013 4s-4 9 5 13a11.64 11.64.0 01-7 2c9 5 20 0 20-11.5a4.5 4.5.0 00-.08-.83A7.72 7.72.0 0023 3z"
            ]
            []
        ]


linkedInIcon : Html msg
linkedInIcon =
    Svg.svg
        [ SvgAttr.viewBox "0 0 24 24"
        , SvgAttr.fill "none"
        , SvgAttr.stroke "currentcolor"
        , SvgAttr.strokeWidth "2"
        , SvgAttr.strokeLinecap "round"
        , SvgAttr.strokeLinejoin "round"
        ]
        [ Svg.path
            [ SvgAttr.d "M16 8a6 6 0 016 6v7h-4v-7a2 2 0 00-2-2 2 2 0 00-2 2v7h-4v-7a6 6 0 016-6z"
            ]
            []
        , Svg.rect
            [ SvgAttr.x "2"
            , SvgAttr.y "9"
            , SvgAttr.width "4"
            , SvgAttr.height "12"
            ]
            []
        , Svg.circle
            [ SvgAttr.cx "4"
            , SvgAttr.cy "4"
            , SvgAttr.r "2"
            ]
            []
        ]
