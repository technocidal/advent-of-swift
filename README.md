# Advent of Swift

Hey! It's good to see you.
I've started this repository
to implement Advent of Code challenges in Swift.
I'm not trying to be competitive
so don't expect any groundbreaking solutions.

If you want to use Advent of Code as a motivation
to learn Swift, feel free to fork this repository an get going.

*Have fun!*

## What is in here?

At its heart this project is a very simple Swift executable
using [ArgumentParser](https://github.com/apple/swift-argument-parser)
to provide you with a easy-to-use command-line interface.

I'm currently adding all solutions
to the [AdventOfSwift.swift](/Sources/AdventOfSwift/AdventOfSwift.swift) file.

There is also a [Utils.swift](/Sources/AdventOfSwift/Utils.swift) file. It
currently contains a small helper function to get the input of a specific day.
As this input is specific to each participant you'll need to provide a token.

### How do I get a token?

- Log in at [Advent of Code](https://adventofcode.com)
- Open your [browsers console](https://balsamiq.com/support/faqs/browserconsole/#:~:text=To%20do%20that%2C%20go%20into,shortcut%20Option%20%2B%20%E2%8C%98%20%2B%20C%20.) 
- Find the [Cookie Storage](https://www.cookieyes.com/blog/how-to-check-cookies-on-your-website-manually/#:~:text=To%20view%20all%20cookies%20stored,all%20cookies%20and%20site%20data.)
- Copy the value of the cookie called `session`
- Store it as a environment variable called `AOC_TOKEN`
    - Some kind of `.env` file. I'm using oh-my-zsh [built-in version](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/dotenv)
    - Prefix the command with `AOC_TOKEN=[Your token]`
    
## How do I run stuff?

Make sure you've Swift installed. Open the package folder in
your favorite terminal emulator and run `swift run aoswift`.
You should get a list of all available commands. Each day has
it's own command, e.g. 01.12 is `swift run aoswift first`.

## How do I add stuff?

Open [AdventOfSwift.swift](/Sources/AdventOfSwift/AdventOfSwift.swift) 
and create a a new `AsyncParsableCommand`.

```swift
struct Second: AsyncParsableCommand {
    
    func run() async throws {
        
    }
}
```

Inside `run()` you can start implementing your solution.
Before you can run this command make sure to add it to 
the `CommandConfiguration` inside the `AdventOfSwift` struct 
to the array of the `subcommands` parameter. 

```swift
static var configuration = CommandConfiguration(
    abstract: "Solutions for AoC problems",
    subcommands: [
        First.self,
        Second.self
    ]
)
```

Now you can run `swift run aoswift second` to 
test your implementation. 

## How does the leaderboard work?

Set the environment variable `AOC_LEADERBOARD` to a
private leaderboard token. 

### Current Standings

```swift
swift run aoswift leaderboard
```

By default this will print the current Top 10 by their local score 
on the specified leaderboard.

You can customize this behavior by providing a number of results.

```swift
// Get results for the first 5 members
swift run aoswift leaderboard --number-of-results 5

// Get results for all members
swift run aoswift leaderboard --number-of-results all
```

## Todo

[X] Leaderboard support  
[] Linux Support
