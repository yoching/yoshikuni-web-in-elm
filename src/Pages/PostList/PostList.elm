module Pages.PostList.PostList exposing (..)

import Entities.Post exposing (Post)
import Html exposing (..)
import Html.Attributes exposing (class)
import UIElements.PostEntryView exposing (postView)


postsView : List Post -> Html msg
postsView posts =
    div [ class "space-y-6" ] <| List.map postView posts


postsJapaneseView : Html msg
postsJapaneseView =
    div [] [ text "日本語のブログ" ]
