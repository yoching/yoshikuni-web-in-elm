module Pages.PostDetail.PostDetail exposing (..)

import Html exposing (Html, text)
import Pages.PostDetail.HaskellAndSwift exposing (haskellAndSwiftDetailView)


postDetailView : String -> Html msg
postDetailView postId =
    if postId == "swift-haskell" then
        haskellAndSwiftDetailView

    else
        text "Not Found"
