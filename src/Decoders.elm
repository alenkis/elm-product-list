module Decoders exposing (..)

import Json.Decode as D


type alias Product =
    { title : String
    , price : Int
    , stock : Int
    , images : List String
    }


productsDecoder : D.Decoder (List Product)
productsDecoder =
    D.field "products" (D.list productDecoder)


productDecoder : D.Decoder Product
productDecoder =
    D.map4 Product
        (D.at [ "title" ] D.string)
        (D.at [ "price" ] D.int)
        (D.at [ "stock" ] D.int)
        (D.at [ "images" ] (D.list D.string))
