# Session 1

reate an application that queries https://dummyjson.com/products and:

- grabs a list of products (use provided 100 results for the first page of paginated response)
- renders a product card for each displaying `name` , `price` and `quantity`

_BONUS: create a text field that we can use to supply the product id so we can get a single product from the API_

You’ll encounter some new stuff we haven’t worked with:

- how to create the application in the first place (hint: take a look at create-elm-app)
- how to create AJAX request (https://guide.elm-lang.org/effects/http.html)
- how to decode received data (https://guide.elm-lang.org/effects/json.html, https://thoughtbot.com/blog/pipeline-decoders-in-elm)
- how to render components (elm guide)
