module Post1 exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, href, src, title)
import PostDetailElements exposing (..)


post1View : Html msg
post1View =
    article
        []
        [ header
            []
            [ div
                []
                [ a
                    [ href "/" ]
                    [ text "Home" ]
                , text "»"
                , a
                    [ href "/blog" ]
                    [ text "Blog" ]
                ]
            , h1
                []
                [ text "Report - 2021 Q4" ]
            , div
                []
                [ text "December 24, 2021 · 2 min" ]
            ]
        , div
            []
            [ details
                []
                [ summary
                    [ Html.Attributes.accesskey 'c'
                    , title "(Alt + C)"
                    ]
                    [ div
                        []
                        [ text "Table of Contents" ]
                    ]
                , div
                    []
                    [ ul
                        []
                        [ li
                            []
                            [ a
                                [ href "#client-work"
                                , Html.Attributes.attribute "aria-label" "Client work"
                                ]
                                [ text "Client work" ]
                            ]
                        , li []
                            [ a
                                [ href "#learning"
                                , Html.Attributes.attribute "aria-label" "Learning"
                                ]
                                [ text "Learning" ]
                            ]
                        , li []
                            [ a
                                [ href "#events"
                                , Html.Attributes.attribute "aria-label" "Events"
                                ]
                                [ text "Events" ]
                            ]
                        , li []
                            [ a
                                [ href "#work-environment"
                                , Html.Attributes.attribute "aria-label" "Work environment"
                                ]
                                [ text "Work environment" ]
                            ]
                        , li []
                            [ a
                                [ href "#output"
                                , Html.Attributes.attribute "aria-label" "Output"
                                ]
                                [ text "Output" ]
                            ]
                        , li []
                            [ a
                                [ href "#other-stuff"
                                , Html.Attributes.attribute "aria-label" "Other stuff"
                                ]
                                [ text "Other stuff" ]
                            ]
                        ]
                    ]
                ]
            ]
        , div
            []
            [ p
                []
                [ text "This is a report of my activities in 2021 Q4. Project changes, learning, and so on!" ]
            , hr
                []
                []
            , h2
                [ Html.Attributes.id "client-work" ]
                [ text "Client work"
                , a
                    [ Html.Attributes.hidden True
                    , class "anchor"
                    , Html.Attributes.attribute "aria-hidden" "true"
                    , href "#client-work"
                    ]
                    [ text "#" ]
                ]
            , p
                []
                [ text "New client projects started in this period." ]
            , ul
                []
                [ li
                    []
                    [ a
                        [ href "https://coral-app.jp/" ]
                        [ text "Coral" ]
                    , ul
                        []
                        [ li
                            []
                            [ text "Thank you, Coral team. I’m looking forward to working with you again." ]
                        ]
                    ]
                , li
                    []
                    [ text "An app project with a Japanese startup"
                    , ul
                        []
                        [ li
                            []
                            [ text "Building a new messaging app for teenagers." ]
                        , li
                            []
                            [ text "Using SwiftUI, Firebase, GraphQL,"
                            , a
                                [ href "https://github.com/pointfreeco/swift-composable-architecture"
                                ]
                                [ text "The Composable Architecture (TCA)" ]
                            , text ", and so on."
                            ]
                        ]
                    ]
                , li
                    []
                    [ text "An art app project with an artist based in New York"
                    , ul
                        []
                        [ li
                            []
                            [ text "Building a photo-based app with some interesting ideas." ]
                        , li
                            []
                            [ text "Technical consultancy work: giving technical advice and writing code together in pair-programming sessions using"
                            , a
                                [ href "https://tuple.app/" ]
                                [ text "TUPLE" ]
                            , text "."
                            ]
                        ]
                    ]
                ]
            , h2
                [ Html.Attributes.id "learning" ]
                [ text "Learning"
                , a
                    [ Html.Attributes.hidden True
                    , class "anchor"
                    , Html.Attributes.attribute "aria-hidden" "true"
                    , href "#learning"
                    ]
                    [ text "#" ]
                ]
            , ul []
                [ li []
                    [ p []
                        [ text "New programming languages"
                        , br []
                            []
                        , img
                            [ Html.Attributes.attribute "loading" "lazy"
                            , src "./images/IMG_8571_adjusted.jpg"
                            , Html.Attributes.alt ""
                            ]
                            []
                        ]
                    , ul []
                        [ li []
                            [ a
                                [ href "https://doc.rust-lang.org/book/"
                                ]
                                [ text "The Rust Programming Language" ]
                            ]
                        , li []
                            [ a
                                [ href "https://www.manning.com/books/haskell-in-depth"
                                ]
                                [ text "Haskell in Depth" ]
                            ]
                        , li []
                            [ a
                                [ href "https://www.oreilly.com/library/view/programming-typescript/9781492037644/"
                                ]
                                [ text "Programming TypeScript" ]
                            ]
                        , li []
                            [ a
                                [ href "https://eloquentjavascript.net/"
                                ]
                                [ text "Eloquent JavaScript" ]
                            ]
                        ]
                    , p []
                        [ text "These correspond to areas that I chose and explained in a post “"
                        , a
                            [ href "/blog/2021/tech-areas"
                            ]
                            [ text "Three tech areas I’m going into" ]
                        , text "”."
                        , br []
                            []
                        , text "By the way, I’m coming back to printed books as I had problems with my eyes caused by watching screens too long. I prefer reading printed books to reading them online."
                        ]
                    ]
                , li []
                    [ p []
                        [ text "New tool trials" ]
                    , ul []
                        [ li []
                            [ a
                                [ href "https://reactjs.org/docs/create-a-new-react-app.html#create-react-app"
                                ]
                                [ text "React" ]
                            ]
                        , li []
                            [ a
                                [ href "https://nextjs.org/"
                                ]
                                [ text "Next.js" ]
                            , br []
                                []
                            , text "Using Next.js was quite an interesting experience. As I used to use nodejs, I realized so many things have changed in the JS environment in the past few years."
                            ]
                        , li []
                            [ a
                                [ href "https://nixos.org/"
                                ]
                                [ text "Nix" ]
                            ]
                        ]
                    ]
                , li []
                    [ p []
                        [ a
                            [ href "https://adventofcode.com/"
                            ]
                            [ text "Advent of Code" ]
                        , text "in Rust, Haskell, etc."
                        ]
                    ]
                ]
            , h2
                [ Html.Attributes.id "events"
                ]
                [ text "Events"
                , a
                    [ Html.Attributes.hidden True
                    , class "anchor"
                    , Html.Attributes.attribute "aria-hidden" "true"
                    , href "#events"
                    ]
                    [ text "#" ]
                ]
            , ul []
                [ li []
                    [ a
                        [ href "https://v2.nl/events/a-crash-course-in-art-media-technolgy-media-art-x-painting"
                        ]
                        [ text "Crash Course in Art & Media Technology" ]
                    , text "at V2.nl"
                    , br []
                        []
                    , text "A series about “Media Art x [Painting, Sculpture, Photography, Filmmaking]”. I attended all four lectures and liked the first one about paintings the most."
                    ]
                , li []
                    [ a
                        [ href "https://ddw.nl/"
                        ]
                        [ text "Dutch Design Week" ]
                    , text "at Eindhoven"
                    , br []
                        []
                    , text "Graduation Show of The Design Academy Eindhoven was great."
                    ]
                , li []
                    [ a
                        [ href "https://re-nature.org/"
                        ]
                        [ text "RE_NATURE exhibition" ]
                    , text "at DenBosch"
                    ]
                , li []
                    [ a
                        [ href "https://www.upstreamgallery.nl/exhibitions/209/mechanical-paintings"
                        ]
                        [ text "Rafaël Rozendaal" ]
                    , text "at Upstream Gallery in Amsterdam"
                    ]
                , li []
                    [ text "Academic institute research"
                    , ul []
                        [ li []
                            [ a
                                [ href "https://www.uu.nl/masters/en/general-information/international-students/contact-and-more-information/masters-open-day"
                                ]
                                [ text "Master’s Open Day at Utrecht University" ]
                            ]
                        , li []
                            [ a
                                [ href "https://www.uva.nl/en/education/open-days/masters/masters-week/masters-week-pre-registraton.html"
                                ]
                                [ text "University of Amsterdam (UvA) Master’s Week" ]
                            ]
                        ]
                    ]
                , li []
                    [ a
                        [ href "https://www.meetup.com/Appsterdam/events/280823049"
                        ]
                        [ text "Coffee Coding meetup" ]
                    ]
                , li []
                    [ a
                        [ href "https://www.meetup.com/broadcast-amsterdam/events/281719272/"
                        ]
                        [ text "Broadcast Amsterdam meetup" ]
                    ]
                ]
            , h2
                [ Html.Attributes.id "work-environment"
                ]
                [ text "Work environment"
                , a
                    [ Html.Attributes.hidden True
                    , class "anchor"
                    , Html.Attributes.attribute "aria-hidden" "true"
                    , href "#work-environment"
                    ]
                    [ text "#" ]
                ]
            , ul []
                [ li []
                    [ p []
                        [ text "New coworking space"
                        , br []
                            []
                        , text "I started using"
                        , a
                            [ href "https://www.thestudenthotel.com/amsterdam-city/co-working-space/"
                            ]
                            [ text "TSH Collab Amsterdam City" ]
                        , text ". Come and see me!"
                        ]
                    ]
                , li []
                    [ p []
                        [ text "Monitor light bar" ]
                    , div
                        [ class "twitter-tweet twitter-tweet-rendered"
                        , Html.Attributes.style "display" "flex"
                        , Html.Attributes.style "max-width" "550px"
                        , Html.Attributes.style "width" "100%"
                        , Html.Attributes.style "margin-top" "10px"
                        , Html.Attributes.style "margin-bottom" "10px"
                        ]
                        [ iframe
                            [ Html.Attributes.id "twitter-widget-0"
                            , Html.Attributes.attribute "scrolling" "no"
                            , Html.Attributes.attribute "frameborder" "0"
                            , Html.Attributes.attribute "allowtransparency" "true"
                            , Html.Attributes.attribute "allowfullscreen" "true"
                            , class ""
                            , Html.Attributes.style "position" "static"
                            , Html.Attributes.style "visibility" "visible"
                            , Html.Attributes.style "width" "550px"
                            , Html.Attributes.style "height" "650px"
                            , Html.Attributes.style "display" "block"
                            , Html.Attributes.style "flex-grow" "1"
                            , title "Twitter Tweet"
                            , src "https://platform.twitter.com/embed/Tweet.html?dnt=false&embedId=twitter-widget-0&features=eyJ0ZndfdGltZWxpbmVfbGlzdCI6eyJidWNrZXQiOlsibGlua3RyLmVlIiwidHIuZWUiXSwidmVyc2lvbiI6bnVsbH0sInRmd19ob3Jpem9uX3RpbWVsaW5lXzEyMDM0Ijp7ImJ1Y2tldCI6InRyZWF0bWVudCIsInZlcnNpb24iOm51bGx9LCJ0ZndfdHdlZXRfZWRpdF9iYWNrZW5kIjp7ImJ1Y2tldCI6Im9uIiwidmVyc2lvbiI6bnVsbH0sInRmd19yZWZzcmNfc2Vzc2lvbiI6eyJidWNrZXQiOiJvbiIsInZlcnNpb24iOm51bGx9LCJ0ZndfY2hpbl9waWxsc18xNDc0MSI6eyJidWNrZXQiOiJjb2xvcl9pY29ucyIsInZlcnNpb24iOm51bGx9LCJ0ZndfdHdlZXRfcmVzdWx0X21pZ3JhdGlvbl8xMzk3OSI6eyJidWNrZXQiOiJ0d2VldF9yZXN1bHQiLCJ2ZXJzaW9uIjpudWxsfSwidGZ3X3NlbnNpdGl2ZV9tZWRpYV9pbnRlcnN0aXRpYWxfMTM5NjMiOnsiYnVja2V0IjoiaW50ZXJzdGl0aWFsIiwidmVyc2lvbiI6bnVsbH0sInRmd19leHBlcmltZW50c19jb29raWVfZXhwaXJhdGlvbiI6eyJidWNrZXQiOjEyMDk2MDAsInZlcnNpb24iOm51bGx9LCJ0ZndfZHVwbGljYXRlX3NjcmliZXNfdG9fc2V0dGluZ3MiOnsiYnVja2V0Ijoib24iLCJ2ZXJzaW9uIjpudWxsfSwidGZ3X3R3ZWV0X2VkaXRfZnJvbnRlbmQiOnsiYnVja2V0Ijoib2ZmIiwidmVyc2lvbiI6bnVsbH19&frame=false&hideCard=false&hideThread=false&id=1454180135989612549&lang=en&origin=https%3A%2F%2Fyoshikuni-web.com%2Fblog%2F2021%2Freport-2021q4%2F&sessionId=f4e4457c2ca4db920180a923f2d508dc2c5f3da5&theme=light&widgetsVersion=1bfeb5c3714e8%3A1661975971032&width=550px"
                            , Html.Attributes.attribute "data-tweet-id" "1454180135989612549"
                            ]
                            []
                        ]
                    , node "script"
                        [ Html.Attributes.attribute "async" ""
                        , src "https://platform.twitter.com/widgets.js"
                        ]
                        []
                    ]
                , li []
                    [ p []
                        [ text "Heavier keyboard switches"
                        , br []
                            []
                        , text "Changed the switches of my ErgoDoxEZ from"
                        , a
                            [ href "https://www.cherrymx.de/en/cherry-mx/mx-original/mx-silent-red.html"
                            ]
                            [ text "Cherry MX Silent Red" ]
                        , text "to"
                        , a
                            [ href "https://www.cherrymx.de/en/cherry-mx/mx-special/mx-clear.html"
                            ]
                            [ text "Cherry MX Clear" ]
                        , text "because I wanted heavier keys for my fingers to move more. Typing is fun with the new switches."
                        ]
                    ]
                ]
            , h2
                [ Html.Attributes.id "output"
                ]
                [ text "Output"
                , a
                    [ Html.Attributes.hidden True
                    , class "anchor"
                    , Html.Attributes.attribute "aria-hidden" "true"
                    , href "#output"
                    ]
                    [ text "#" ]
                ]
            , ul []
                [ li []
                    [ a
                        [ href "/ja/blog/2021/prague-cafe/"
                        ]
                        [ text "Cafes and Burgers in Prague" ]
                    , text "(only in Japanese), 15 October"
                    ]
                ]
            , h2
                [ Html.Attributes.id "other-stuff"
                ]
                [ text "Other stuff"
                , a
                    [ Html.Attributes.hidden True
                    , class "anchor"
                    , Html.Attributes.attribute "aria-hidden" "true"
                    , href "#other-stuff"
                    ]
                    [ text "#" ]
                ]
            , ul []
                [ li []
                    [ a
                        [ href "https://blog.rust-lang.org/2021/12/08/survey-launch.html"
                        ]
                        [ text "Rust Survey" ]
                    , text "Japanese translation help✨"
                    ]
                , li []
                    [ text "Sales activities and networking" ]
                , li []
                    [ text "Made a plan to visit Japan (and booked flights), but canceled due to entry restriction change. I’m looking for another opportunity to visit there." ]
                ]
            , hr []
                []
            , p []
                [ text "As I also wrote"
                , a
                    [ href "/blog/2021/report-2021/"
                    ]
                    [ text "2021 Summary" ]
                , text ", please read it if you have interests."
                , br []
                    []
                , text "Happy holidays🎄"
                ]
            ]
        , footer
            [ class "post-footer"
            ]
            [ nav
                [ class "paginav"
                ]
                [ a
                    [ class "prev"
                    , href "https://yoshikuni-web.com/blog/2021/report-2021/"
                    ]
                    [ span
                        [ class "title"
                        ]
                        [ text "« Prev Page" ]
                    , br []
                        []
                    , span []
                        [ text "2021 Summary - First year of freelancing" ]
                    ]
                , a
                    [ class "next"
                    , href "https://yoshikuni-web.com/blog/2021/report-2021q3/"
                    ]
                    [ span
                        [ class "title"
                        ]
                        [ text "Next Page »" ]
                    , br []
                        []
                    , span []
                        [ text "Report - July to September, 2021" ]
                    ]
                ]
            ]
        ]
