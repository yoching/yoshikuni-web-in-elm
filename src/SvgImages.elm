module SvgImages exposing (..)

import Html exposing (Html)
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
