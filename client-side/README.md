## Based on elm-webpack-starter-kid

Starter of bare minimum of code. Up-to-date dependencies.

# How to run
```
git clone https://github.com/wiewioraseb/tele-address-base.git
cd client-side
npm i \
npm start
```

# Knowledge sources

A curated list of useful Elm tutorials, libraries and software:  
https://github.com/isRuslan/awesome-elm

How to talk to Javascript:  
https://guide.elm-lang.org/interop/javascript.html 

YouTube Elm tutorial:
https://www.youtube.com/watch?v=zBHB9i8e3Kc

Elm project consuming PokéAPI:
https://github.com/brenopanzolini/pokelmon


map (/x-> "foo") [1,2,3,4,5]
List.map (/x-> "foo") (List.range 1 100)

List.range 1 100 |> List.map (/x-> "foo") |> List.foldr (++) ""

isOdd number = if number % 2 == 0 then False else True
List.range 1 100 |> List.filter isOdd

List.filter (\x-> isOdd x) [1,2,3,4,7,8,9]
List.filter (\x-> if x % 2 == 0  then True else False) [1,2,3,4,5,6]

[22,31,43,656,454,235,878] |> List.filter (\x-> x%2==0)


["Raz", "Dwa", "trzy"] |> List.filter (\x-> String.startsWith "t" x)

"HELLO tji" |> String.toList |> List.head |> len |> 
