module Pages.Profile.Profile exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, href, src)


profileView : Html msg
profileView =
    div [ class "dark:bg-zinc-900" ]
        [ div
            [ class "max-w-3xl mx-auto p-10 dark:text-white/80 text-lg" ]
            [ h1
                [ class "font-bold text-[40px]" ]
                [ text "Hello, I'm Yoshikuni!" ]
            , div
                [ class "my-8" ]
                [ img
                    [ src "require:src/static/images/profile.png", class "w-48 mx-auto my-2 rounded" ]
                    []
                ]
            , div
                [ class "space-y-5" ]
                [ p
                    []
                    [ text "I'm a software engineer with 8+ years of work experience in application development."
                    , br []
                        []
                    , text "Over the past 6 years, I’ve been writing Swift and have made 10+ native iOS apps from scratch for clients."
                    ]
                , p []
                    [ text "At the moment, I’m working as a freelance engineer and focusing on two things:" ]
                , div []
                    [ ol
                        [ class "list-decimal list-inside" ]
                        [ li
                            []
                            [ text "Helping client projects by utilizing my iOS/Swift skills and experience" ]
                        , li
                            []
                            [ text "Exploring new programming languages and technology for my future work" ]
                        ]
                    ]
                , p
                    []
                    [ text "🧑🏻\u{200D}💻 My technical interests include Functional Programming, Interactive UI development, and various tools that support software development. I’ve given many presentations about these topics, the slides of which you can find at my "
                    , a
                        [ href "https://speakerdeck.com/yoching", class "underline underline-offset-4" ]
                        [ text "SpeakerDeck" ]
                    , text ". There are some experimental projects and codes on my "
                    , a
                        [ href "https://github.com/yoching?tab=repositories", class "underline underline-offset-4" ]
                        [ text "GitHub" ]
                    , text " as well. Also, I enjoy doing pair-programming and using scrum/agile methodologies when working in a team."
                    ]
                , p
                    []
                    [ text "📚 Apart from professional experience, I am passionate about interdisciplinary fields of technology and society. This relates to my Master’s degree in Interdisciplinary Information Studies at The University of Tokyo in 2013. I’m eager to find opportunities to develop this passion further." ]
                , p
                    []
                    [ text "🌏 Originally from Japan, I moved to Prague, the Czech Republic, in 2019 to gain experience working in an international environment. After working on several projects with international colleagues and clients, in 2021, I moved to Amsterdam, the Netherlands, where I can work as a freelancer, to be more ible about technology choice and to work on a wider variety of projects. These moves were motivated by my ambition to contribute to software development culture." ]
                , p
                    []
                    [ text "✨ Besides work, I like listening to the radio, thinking about philosophical ideas, visiting art exhibitions, reading books, and so on." ]
                , p
                    []
                    [ text "If you are interested to learn more about my work experience, please read my CV or "
                    , a
                        [ href "https://linkedin.com/in/yoshikunikato", class "underline underline-offset-4" ]
                        [ text "LinkedIn" ]
                    , text ". My portfolio is also available on request."
                    ]
                , p
                    []
                    [ text "I’m looking forward to hearing from you and discussing future projects together." ]
                ]
            , div
                []
                [ h3
                    [ class "font-bold text-2xl pt-5 mt-6 mb-4" ]
                    [ text "Contacts" ]
                , ul
                    []
                    [ li
                        [ class "list-disc list-inside" ]
                        [ a
                            [ href "mailto:yoshikuni.kato.g@gmail.com", class "underline underline-offset-4" ]
                            [ text "yoshikuni.kato.g@gmail.com" ]
                        ]
                    ]
                ]
            ]
        ]


profileJapaneseView : Html msg
profileJapaneseView =
    div [] [ text "日本語のプロフィール" ]
