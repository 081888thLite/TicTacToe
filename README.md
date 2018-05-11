# TicTacToe
Tic Tac Toe Game Written in Elm

To run you'll first need to [install Elm](https://guide.elm-lang.org/install.html).

## Build

1. Clone the repo:

```
git clone https://github.com/081888thLite/TicTacToe.git
```

2. Change directories into the project root:
```
cd TicTacToe
```

4. Run `elm-make` to install packages and compile application.
[--debug is optional but nifty](http://elm-lang.org/blog/the-perfect-bug-report)
```
elm-make src/Main.elm --output index.js --debug
```

3. Start up `elm-reactor`:
```
elm-reactor
```

4. Now open up your browser and navigate to `http://localhost:8000/index.html`

## To Run the Test

1. To run the test you may need to download the `elm-test` package first by running `elm-package install elm-community/elm-test`

_(Hit `y` + Enter when you are prompted: May I add that to elm-package.json for you?)_

2. Then run `elm-test`

### That's all there is to it!


