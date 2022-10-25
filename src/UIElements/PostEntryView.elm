module UIElements.PostEntryView exposing (..)

import Entities.Post exposing (..)
import Html exposing (..)
import Html.Attributes exposing (class, href)


postEntryView : Post -> Html msg
postEntryView post =
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
