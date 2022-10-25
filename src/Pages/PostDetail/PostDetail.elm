module Pages.PostDetail.PostDetail exposing (..)

import Html exposing (Html, text)
import Pages.PostDetail.Post1 exposing (post1View)
import Pages.PostDetail.Post2 exposing (post2View)


postDetailView : String -> Html msg
postDetailView postId =
    if postId == "report-2022q2" then
        post1View

    else if postId == "swift-haskell" then
        post2View

    else
        text "Not Found"
