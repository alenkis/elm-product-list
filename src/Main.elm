module Main exposing (..)

import Browser exposing (element)
import Decoders exposing (Product, productsDecoder)
import Html exposing (Html, div, h1, img, span, text)
import Html.Attributes exposing (src)
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
    div []
        [ h1 [] [ text product.title ]
        , span [] [ text <| "$" ++ String.fromInt product.price ]
        , span [] [ text <| "stock: " ++ String.fromInt product.stock ]
        ]


view : Model -> Html Msg
view model =
    div []
        [ img [ src "/logo.svg" ] []
        , div []
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
