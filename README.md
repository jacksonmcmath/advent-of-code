# Advent of Code

[site](https://adventofcode.com/) | [subreddit](https://reddit.com/r/adventofcode/)

Advent of Code puzzle solutions written in elixir.

## Getting started

Install dependencies:

```console
mix deps.get
```

Save session token as configuration item:

```elixir
# config/config.exs
import Config

config :advent_of_code, AdventOfCode.Input, allow_network?: true

import_config "secrets.exs"

# config/secrets.exs
import Config

config :advent_of_code, AdventOfCode.Input,
  session_token: "<session token>"
```

Or as the environment variable `AOC_SESSION_TOKEN`.

Get solution for a particular year and day:

```console
mix solve <day> # defaults to current year
mix solve <year> <day>
mix solve --year <year> --day <day>
```

## Adding a new day

Generate boilerplate for a particular year and day:

```console
mix gen <day> # defaults to current year
mix gen <year> <day>
mix gen --year <year> --day <day>
```

This generates a new solution module and corresponding test module.
This also fetchs and caches the puzzle input from the server, if configured.

## Testing

```console
mix test
```


