module Pages.PostPage.PostDetailElements exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, href, title)


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
