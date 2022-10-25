module Pages.PostDetail.Post2 exposing (..)

import Html exposing (..)
import Html.Attributes exposing (attribute, class, hidden, href, id, style, tabindex)
import Pages.PostDetail.PostDetailElements exposing (..)


post2View : Html msg
post2View =
    article
        [ class "post-single" ]
        [ postDetailHeader "Haskell and Swift" "July 23, 2021 · 4 min"
        , div
            [ class "post-content" ]
            [ postContentP []
                [ text "Hello, world. Let me share some of my findings of "
                , a
                    [ href "https://www.haskell.org/" ]
                    [ text "Haskell" ]
                , text " and "
                , a
                    [ href "https://swift.org/" ]
                    [ text "Swift" ]
                , text "."
                ]
            , postContentP []
                [ text "I got interested in functional programming, especially in Haskell, when I realized that most of my favorite Swift features come from functional programming. My favorite features include"
                , codeInline []
                    [ text "enum" ]
                , text "with associated values,"
                , codeInline []
                    [ text "Result" ]
                , text "type, higher-order functions (i.e. passing functions themselves),"
                , codeInline []
                    [ text "KeyPath" ]
                , text "type, and so on."
                ]
            , postContentP []
                [ text "After started learning Haskell, I found there are more common features between Swift and Haskell than I expected. Some data types are essentially the same, some syntax is similar, and some concepts are common. In fact, "
                , a
                    [ href "https://en.wikipedia.org/wiki/Chris_Lattner" ]
                    [ text "Chris Lattner" ]
                , text ", who is the main author of Swift, confirms that Generics in Swift is inspired by Haskell according to "
                , a
                    [ href "https://www.swiftbysundell.com/podcast/100/" ]
                    [ text "an interview" ]
                , text "."
                ]
            , postContentP []
                [ text "I’m gonna share some similarities I found in Haskell and Swift, and the limitations of Swift compared to Haskell." ]
            , postDetailHr
            , postDetailH2
                []
                [ text "Corresponding concepts" ]
            , postContentP
                []
                [ text "These are some syntax, data types, and concepts both languages have." ]
            , table
                [ class "mb-8" ]
                [ thead
                    []
                    [ tr
                        [ class "border-b border-gray-700" ]
                        [ th
                            [ class "text-sm py-3 px-2 text-left" ]
                            [ text "Swift" ]
                        , th
                            [ class "text-sm text-left py-3 px-2" ]
                            [ text "Haskell" ]
                        ]
                    ]
                , tbody
                    []
                    [ tr
                        [ class "border-b border-gray-700" ]
                        [ td
                            [ class "text-lg py-3 px-2" ]
                            [ text "Generics:"
                            , br
                                []
                                []
                            , text "e.g."
                            , codeInline
                                []
                                [ text "struct GenericType<A, B>" ]
                            ]
                        , td
                            [ class "text-lg py-3 px-2" ]
                            [ text "Type Constructor:"
                            , br
                                []
                                []
                            , text "e.g."
                            , codeInline
                                []
                                [ text "data SomeType a b" ]
                            , br
                                []
                                []
                            , codeInline
                                []
                                [ text "a" ]
                            , text "and"
                            , codeInline
                                []
                                [ text "b" ]
                            , text "are called type parameters"
                            ]
                        ]
                    , tr
                        [ class "border-b border-gray-700" ]
                        [ td
                            [ class "text-lg py-3 px-2" ]
                            [ text "Protocol:"
                            , codeInline
                                []
                                [ text "protocol" ]
                            ]
                        , td
                            [ class "text-lg py-3 px-2" ]
                            [ text "Type Class:"
                            , codeInline
                                []
                                [ text "class" ]
                            ]
                        ]
                    , tr
                        [ class "border-b border-gray-700" ]
                        [ td
                            [ class "text-lg py-3 px-2" ]
                            [ text "Protocol conformance:"
                            , br
                                []
                                []
                            , codeInline
                                []
                                [ text "extension SomeType: SomeProtocol {" ]
                            ]
                        , td
                            [ class "text-lg py-3 px-2" ]
                            [ text "Instance declaration:"
                            , br
                                []
                                []
                            , codeInline
                                []
                                [ text "instance SomeClass SomeType where" ]
                            ]
                        ]
                    , tr
                        [ class "border-b border-gray-700" ]
                        [ td
                            [ class "text-lg py-3 px-2" ]
                            [ codeInline
                                []
                                [ text "enum" ]
                            , text "with associated value"
                            ]
                        , td
                            [ class "text-lg py-3 px-2" ]
                            [ a
                                [ href "https://en.wikipedia.org/wiki/Algebraic_data_type" ]
                                [ text "Algebraic Data Type" ]
                            , text ":"
                            , codeInline
                                []
                                [ text "data" ]
                            ]
                        ]
                    , tr
                        [ class "border-b border-gray-700" ]
                        [ td
                            [ class "text-lg py-3 px-2" ]
                            [ codeInline
                                []
                                [ text "enum Optional<Wrapped>" ]
                            ]
                        , td
                            [ class "text-lg py-3 px-2" ]
                            [ codeInline
                                []
                                [ text "data Maybe a" ]
                            ]
                        ]
                    , tr
                        [ class "border-b border-gray-700" ]
                        [ td
                            [ class "text-lg py-3 px-2" ]
                            [ codeInline
                                []
                                [ text "enum Result<Success, Failure>" ]
                            ]
                        , td
                            [ class "text-lg py-3 px-2" ]
                            [ codeInline
                                []
                                [ text "data Either a b" ]
                            ]
                        ]
                    , tr
                        [ class "border-b border-gray-700" ]
                        [ td
                            [ class "text-lg py-3 px-2" ]
                            [ text "Closure:"
                            , codeInline
                                []
                                [ text "{ A -> B in ... }" ]
                            ]
                        , td
                            [ class "text-lg py-3 px-2" ]
                            [ text "Lambda:"
                            , codeInline
                                []
                                [ text "\\a -> ..." ]
                            ]
                        ]
                    , tr
                        [ class "border-b border-gray-700" ]
                        [ td
                            [ class "text-lg py-3 px-2" ]
                            [ text "Closure type declaration:"
                            , br
                                []
                                []
                            , codeInline
                                []
                                [ text "var foo: (A -> B -> C)" ]
                            ]
                        , td
                            [ class "text-lg py-3 px-2" ]
                            [ text "Function signature:"
                            , br
                                []
                                []
                            , codeInline
                                []
                                [ text "foo :: A -> B -> C" ]
                            ]
                        ]
                    ]
                ]
            , postContentP
                []
                [ text "There are more common features such as:" ]
            , ul
                [ class "list-disc list-inside mb-5 pl-5" ]
                [ li
                    []
                    [ text "Type inference" ]
                , li
                    []
                    [ text "Pattern matching" ]
                , li
                    []
                    [ codeInline
                        []
                        [ text "KeyPath" ]
                    , text " is “Lens” (e.g. "
                    , a
                        [ href "https://www.47deg.com/blog/keypaths-optics/" ]
                        [ text "Swift KeyPaths under a different optic" ]
                    , text ")"
                    ]
                ]
            , postContentP
                []
                [ text "By the way, “Type constructor”, “Type parameter”, “Type class”, … It seems Haskell terminology is built around "
                , strong
                    []
                    [ text "Types" ]
                , text ", and Haskell seems to be very aware of handling types."
                ]
            , postDetailHr
            , postDetailH2
                [ id "in-haskell-but-not-in-swift" ]
                [ text "In Haskell, but not in Swift"
                , a
                    [ hidden True
                    , class "anchor"
                    , attribute "aria-hidden" "true"
                    , href "#in-haskell-but-not-in-swift"
                    ]
                    [ text "#" ]
                ]
            , postContentP
                []
                [ text "Even though there are a lot of similarities, there are also some patterns that cannot be written simply in Swift." ]
            , postContentH3
                [ id "higher-kinded-type" ]
                [ text "Higher-Kinded Type"
                , a
                    [ hidden True
                    , class "anchor"
                    , attribute "aria-hidden" "true"
                    , href "#higher-kinded-type"
                    ]
                    [ text "#" ]
                ]
            , postContentP
                []
                [ text "For example,"
                , codeInline
                    []
                    [ text "Functor" ]
                , text "class, which is like a protocol that has"
                , codeInline
                    []
                    [ text "fmap" ]
                , text "function in Swift terms, cannot be directly translated into Swift."
                ]
            , div
                [ class "highlight" ]
                [ pre
                    -- [ tabindex 0
                    -- , style "color" "#f8f8f2"
                    -- , style "background-color" "#272822"
                    -- , style "-moz-tab-size" "4"
                    -- , style "-o-tab-size" "4"
                    -- , style "tab-size" "4"
                    []
                    [ codeBlock
                        [ class "language-Haskell", attribute "data-lang" "Haskell" ]
                        [ span
                            [ style "display" "flex" ]
                            [ span
                                []
                                [ span
                                    [ style "color" "#75715e" ]
                                    [ text "-- Haskell" ]
                                ]
                            ]
                        , span
                            [ style "display" "flex" ]
                            [ span
                                []
                                [ span
                                    [ style "color" "#66d9ef" ]
                                    [ text "class " ]
                                , span
                                    [ style "color" "#66d9ef" ]
                                    [ text "Functor " ]
                                , text "f "
                                , span
                                    [ style "color" "#66d9ef" ]
                                    [ text "where" ]
                                ]
                            ]
                        , span
                            [ style "display" "flex" ]
                            [ span []
                                [ text "    fmap"
                                , span
                                    [ style "color" "#f92672" ]
                                    [ text " :: " ]
                                , text "(a"
                                , span
                                    [ style "color" "#f92672" ]
                                    [ text " -> " ]
                                , text "b)"
                                , span
                                    [ style "color" "#f92672" ]
                                    [ text " -> " ]
                                , text "f a"
                                , span
                                    [ style "color" "#f92672" ]
                                    [ text " -> " ]
                                , text "f b"
                                ]
                            ]
                        , span
                            [ style "display" "flex" ]
                            [ span
                                []
                                [ span
                                    [ style "color" "#f92672" ]
                                    [ text "    ..." ]
                                ]
                            ]
                        ]
                    ]
                , button
                    [ class "copy-code" ]
                    [ text "copy" ]
                ]
            , div
                [ class "highlight" ]
                [ pre
                    [ tabindex 0
                    , style "color" "#f8f8f2"
                    , style "background-color" "#272822"
                    , style "-moz-tab-size" "4"
                    , style "-o-tab-size" "4"
                    , style "tab-size" "4"
                    ]
                    [ codeBlock
                        [ class "language-Swift hljs"
                        , attribute "data-lang" "Swift"
                        ]
                        [ span
                            [ style "display" "flex" ]
                            [ span
                                []
                                [ span
                                    [ style "color" "#75715e" ]
                                    [ span
                                        [ class "hljs-comment" ]
                                        [ text "// Psuedo-Swift" ]
                                    ]
                                ]
                            ]
                        , span
                            [ style "display" "flex" ]
                            [ span
                                []
                                [ span
                                    [ style "color" "#66d9ef" ]
                                    [ span
                                        [ class "hljs-class" ]
                                        [ span
                                            [ class "hljs-keyword" ]
                                            [ text "protocol " ]
                                        ]
                                    ]
                                , span
                                    [ class "hljs-class" ]
                                    []
                                , span
                                    [ style "color" "#a6e22e" ]
                                    [ span
                                        [ class "hljs-class" ]
                                        [ span
                                            [ class "hljs-title" ]
                                            [ text "Functor " ]
                                        ]
                                    ]
                                , span
                                    [ class "hljs-class" ]
                                    [ span
                                        [ class "hljs-title" ]
                                        [ text "F " ]
                                    ]
                                , text "{ "
                                , span
                                    [ style "color" "#75715e" ]
                                    [ span
                                        [ class "hljs-comment" ]
                                        [ text "// `F` needs to be a type constructor. General type constructor cannot be written in Swift." ]
                                    ]
                                ]
                            ]
                        , span
                            [ style "display" "flex" ]
                            [ span
                                []
                                [ span
                                    [ style "color" "#66d9ef" ]
                                    [ span
                                        [ class "hljs-function" ]
                                        [ span
                                            [ class "hljs-keyword" ]
                                            [ text "    func " ]
                                        ]
                                    ]
                                , span
                                    [ class "hljs-function" ]
                                    []
                                , span
                                    [ style "color" "#a6e22e" ]
                                    [ span
                                        [ class "hljs-function" ]
                                        [ span
                                            [ class "hljs-title" ]
                                            [ text "fmap" ]
                                        ]
                                    ]
                                , span
                                    [ class "hljs-function" ]
                                    [ text "<A, B>"
                                    , span
                                        [ class "hljs-params" ]
                                        [ text "(" ]
                                    ]
                                , span
                                    [ style "color" "#66d9ef" ]
                                    [ span
                                        [ class "hljs-function" ]
                                        [ span
                                            [ class "hljs-params" ]
                                            [ span
                                                [ class "hljs-number" ]
                                                [ text "_ " ]
                                            ]
                                        ]
                                    ]
                                , span
                                    [ class "hljs-function" ]
                                    [ span
                                        [ class "hljs-params" ]
                                        [ text "f: "
                                        , span
                                            [ class "hljs-params" ]
                                            [ text "(A) " ]
                                        ]
                                    ]
                                , text "-> "
                                , span
                                    [ class "hljs-type" ]
                                    [ text "B" ]
                                , text ") -> "
                                , span
                                    [ class "hljs-type" ]
                                    [ text "F" ]
                                , text "<"
                                , span
                                    [ class "hljs-type" ]
                                    [ text "A" ]
                                , text "> -> "
                                , span
                                    [ class "hljs-type" ]
                                    [ text "F" ]
                                , text "<"
                                , span
                                    [ class "hljs-type" ]
                                    [ text "B" ]
                                , text ">"
                                ]
                            ]
                        , span
                            [ style "display" "flex" ]
                            [ span
                                []
                                [ text "    ..." ]
                            ]
                        , span
                            [ style "display" "flex" ]
                            [ span
                                []
                                [ text "}" ]
                            ]
                        ]
                    ]
                , button
                    [ class "copy-code" ]
                    [ text "copy" ]
                ]
            , postContentP
                []
                [ codeInline
                    []
                    [ text "F" ]
                , text "could be"
                , codeInline
                    []
                    [ text "Optional" ]
                , text "(not"
                , codeInline
                    []
                    [ text "Optional<A>" ]
                , text "), or"
                , codeInline
                    []
                    [ text "Result<Int, /* some general type parameter */>" ]
                , text ". However, Swift hasn’t supported this kind of syntax."
                , br
                    []
                    []
                , text "Higher-Kinded Type (HKT) support is necessary for this. "
                , a
                    [ href "https://bow-swift.io/" ]
                    [ text "Bow-Swift" ]
                , text " includes a great document about this topic "
                , a
                    [ href "https://bow-swift.io/docs/fp-concepts/higher-kinded-types/" ]
                    [ text "here" ]
                , text "."
                ]
            , postContentH3
                [ id "io-type" ]
                [ text "IO type"
                , a
                    [ hidden True
                    , class "anchor"
                    , attribute "aria-hidden" "true"
                    , href "#io-type"
                    ]
                    [ text "#" ]
                ]
            , postContentP
                []
                [ text "In Haskell, since all functions are pure, side effects can be written only in a type called"
                , codeInline
                    []
                    [ text "IO" ]
                , text ". On the other hand, in Swift, side effects can be written anywhere."
                , br
                    []
                    []
                , text "As limiting the place to write side effects leads to more robust and testable codes, I sometimes miss this feature when I go back to writing Swift."
                ]
            , postContentH3
                [ id "and-more-and-more" ]
                [ text "And, more and more!"
                , a
                    [ hidden True
                    , class "anchor"
                    , attribute "aria-hidden" "true"
                    , href "#and-more-and-more"
                    ]
                    [ text "#" ]
                ]
            , postContentP
                []
                [ text "The Haskell world is vast. There are numerous interesting concepts and ways of thinking about programming, that don’t exist in other languages." ]
            , postDetailHr
            , postDetailH2
                [ id "references" ]
                [ text "References"
                , a
                    [ hidden True
                    , class "anchor"
                    , attribute "aria-hidden" "true"
                    , href "#references"
                    ]
                    [ text "#" ]
                ]
            , postContentH3
                [ id "for-swift-programmers" ]
                [ text "For Swift programmers"
                , a
                    [ hidden True
                    , class "anchor"
                    , attribute "aria-hidden" "true"
                    , href "#for-swift-programmers"
                    ]
                    [ text "#" ]
                ]
            , postContentP
                []
                [ text "If you’re a Swift programmer, these materials are excellent to get into functional programming. I learned a lot from these. Highly recommended." ]
            , ul
                [ class "list-disc mb-5 block pl-5" ]
                [ li
                    []
                    [ a
                        [ href "https://www.pointfree.co/" ]
                        [ text "Point-Free" ]
                    , text ": A video series exploring functional programming and Swift."
                    ]
                , li
                    []
                    [ a
                        [ href "https://bow-swift.io/" ]
                        [ text "Bow-Swift" ]
                    , text ": A library for Typed Functional Programming in Swift"
                    ]
                ]
            , postContentH3
                [ id "start-learning-haskell" ]
                [ text "Start learning Haskell"
                , a
                    [ hidden True
                    , class "anchor"
                    , attribute "aria-hidden" "true"
                    , href "#start-learning-haskell"
                    ]
                    [ text "#" ]
                ]
            , ul
                [ class "list-disc mb-5 pl-5" ]
                [ li
                    []
                    [ a
                        [ href "http://learnyouahaskell.com/" ]
                        [ text "Learn You a Haskell for Great Good!" ]
                    , br
                        []
                        []
                    , text "A famous book. Good for beginners."
                    ]
                , li
                    []
                    [ a
                        [ href "https://haskellbook.com/" ]
                        [ text "Haskell Programming from first principles" ]
                    , br
                        []
                        []
                    , text "I’m reading this too. This covers more topics than the one above."
                    ]
                ]
            , postContentH3
                [ id "haskell-conferencesevents" ]
                [ text "Haskell conferences/events"
                , a
                    [ hidden True
                    , class "anchor"
                    , attribute "aria-hidden" "true"
                    , href "#haskell-conferencesevents"
                    ]
                    [ text "#" ]
                ]
            , ul
                [ class "list-disc mb-5 pl-5" ]
                [ li
                    []
                    [ a
                        [ href "https://zfoh.ch/zurihac2021/" ]
                        [ text "ZuriHac" ]
                    , text ": June 18-20, 2021"
                    , br
                        []
                        []
                    , text "I attended this year. Great talks and a very welcoming atmosphere!"
                    ]
                , li
                    []
                    [ a
                        [ href "https://utrechtsummerschool.nl/courses/science//applied-functional-programming-in-haskell" ]
                        [ text "Applied Functional Programming in Haskell" ]
                    , text "at Summer School Utrecht, July 05-09, 2021"
                    , br
                        []
                        []
                    , text "I also attended this course this summer. There were a lot of intermediate/advanced topics. It’s also nice to know how Haskell is discussed in academics."
                    ]
                , li
                    []
                    [ a
                        [ href "https://haskell.love/" ]
                        [ text "Haskell Love Conference" ]
                    , text ": Sep 10, 2021, online"
                    ]
                , li
                    []
                    [ a
                        [ href "https://skillsmatter.com/conferences/13256-haskell-exchange-2021" ]
                        [ text "Haskell eXchange" ]
                    , text ": Nov 16-17, 2021, online"
                    , br
                        []
                        []
                    , text "Looking forward to these two this fall."
                    ]
                ]
            , postDetailHr
            , postContentP
                []
                [ text "Thank you for reading! Please reach out to "
                , a
                    [ href "https://twitter.com/yoshikuni_kato" ]
                    [ text "@yoshikuni_kato" ]
                , text " if you have any questions or comments. Enjoy functional programming!"
                ]
            ]

        -- , footer
        --     [ class "post-footer mt-14 block" ]
        --     [ nav
        --         [ class "paginav flex rounded-lg bg-gray-700 leading-8" ]
        --         [ a
        --             [ class "prev w-3/6 px-3 text-left"
        --             , href "https://yoshikuni-web.com/blog/2021/presentations/"
        --             ]
        --             [ span
        --                 [ class "title text-sm tracking-widest uppercase opacity-50" ]
        --                 [ text "« Prev Page" ]
        --             , br
        --                 []
        --                 []
        --             , span
        --                 []
        --                 [ text "My past presentations" ]
        --             ]
        --         , a
        --             [ class "next w-3/6 px-3 text-right"
        --             , href "https://yoshikuni-web.com/blog/2021/report-2021q2/"
        --             ]
        --             [ span
        --                 [ class "title text-sm tracking-widest uppercase opacity-50" ]
        --                 [ text "Next Page »" ]
        --             , br
        --                 []
        --                 []
        --             , span
        --                 []
        --                 [ text "Report - April to June, 2021" ]
        --             ]
        --         ]
        --     ]
        ]
