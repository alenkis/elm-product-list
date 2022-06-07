module Main exposing (..)

import Browser exposing (element)
import Decoders exposing (Product, productsDecoder)
import Html exposing (Html, div, h1, h2, h3, img, p, span, text)
import Html.Attributes exposing (class, src)
import Http



---- MODEL ----


type alias Model =
    { products : Maybe (List Product)
    }


init : ( Model, Cmd Msg )
init =
    ( { products = Nothing }, getProducts )



---- UPDATE ----


type Msg
    = NoOp
    | GotProducts (Result Http.Error (List Product))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        GotProducts result ->
            case result of
                Err _ ->
                    ( model, Cmd.none )

                Ok products ->
                    ( { model | products = Just products }, Cmd.none )



---- VIEW ----


renderProduct : Product -> Html Msg
renderProduct product =
    let
        defaultImage =
            "https://tailwindui.com/img/ecommerce-images/category-page-04-image-card-03.jpg"
    in
    div [ class "group" ]
        [ div
            [ class "object-contain h-5/6 aspect-w-1 aspect-h-1 bg-gray-200 rounded-lg overflow-hidden xl:aspect-w-7 xl:aspect-h-8" ]
            [ img
                [ src (product.images |> List.head |> Maybe.withDefault defaultImage)
                , class "w-full h-full object-center object-cover group-hover:opacity-75"
                ]
                []
            ]
        , h3 [ class "mt-4 text-sm text-gray-700" ] [ text product.title ]
        , p [ class "mt-1 text-lg font-medium text-gray-900" ] [ text <| "$" ++ String.fromInt product.price ]
        ]


view : Model -> Html Msg
view model =
    div [ class "max-w-2xl mx-auto py-16 px-4 sm:py-24 sm:px-6 lg:max-w-7xl lg:px-8" ]
        [ h2 [ class "sr-only" ] [ text "Products" ]
        , div [ class "grid grid-cols-1 gap-y-10 sm:grid-cols-2 gap-x-6 lg:grid-cols-3 xl:grid-cols-4 xl:gap-x-8" ]
            (model.products
                |> Maybe.withDefault []
                |> List.map renderProduct
            )
        ]



---- PROGRAM ----


getProducts : Cmd Msg
getProducts =
    Http.get
        { url = "https://dummyjson.com/products"
        , expect = Http.expectJson GotProducts productsDecoder
        }


main : Program () Model Msg
main =
    element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = always Sub.none
        }
