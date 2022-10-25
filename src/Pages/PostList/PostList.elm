module Pages.PostList.PostList exposing (..)

import Entities.Post exposing (Post)
import Html exposing (..)
import Html.Attributes exposing (class)
import UIElements.PostEntryView exposing (postEntryView)


postListView : List Post -> Html msg
postListView posts =
    div [ class "space-y-6" ] <| List.map postEntryView posts


postListJapaneseView : Html msg
postListJapaneseView =
    div [] [ text "日本語のブログ" ]
