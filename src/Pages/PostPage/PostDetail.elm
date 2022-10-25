module Pages.PostPage.PostDetail exposing (..)

import Html exposing (Html, text)
import Pages.PostPage.Post1 exposing (post1View)
import Pages.PostPage.Post2 exposing (post2View)


postDetailView : String -> Html msg
postDetailView postId =
    if postId == "report-2022q2" then
        post1View

    else if postId == "swift-haskell" then
        post2View

    else
        text "Not Found"
