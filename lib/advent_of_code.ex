defmodule AdventOfCode do
  @moduledoc """
  Solves puzzles for the given year and day.
  """

  @latest_year 2024

  @typedoc "A valid Advent of Code year."
  @type year() :: 2015..2024

  @typedoc "A valid Advent of Code day."
  @type day() :: 1..25

  @doc "Returns the latest solved year."
  @spec get_latest_year() :: year()
  def get_latest_year(), do: @latest_year

  @doc "Solves the puzzle for the given year and day."
  @spec solve(day()) :: {:ok, any()} | {:error, atom()}
  @spec solve(year(), day()) :: {:ok, any()} | {:error, atom()}
  def solve(year \\ @latest_year, day) do
    {:ok, Module.concat([AdventOfCode, get_year_module(year), get_day_module(day)]).run()}
  rescue
    _ in FunctionClauseError -> {:error, :invalid_args}
    _ in UndefinedFunctionError -> {:error, :not_yet_solved}
  end

  defp get_year_module(year) when year in 2015..@latest_year do
    "Y" <> Integer.to_string(year)
  end

  defp get_day_module(day) when day in 1..25 do
    day
    |> Integer.to_string()
    |> String.pad_leading(2, "0")
    |> then(fn day -> "D" <> day end)
  end

  @doc """
  Parses year and day as positional and named command line arguments.
  """
  @spec parse_args!([String.t()]) :: {AdventOfCode.year(), AdventOfCode.day()}
  def parse_args!(args) do
    case OptionParser.parse(args, strict: [year: :integer, day: :integer]) do
      {[], opts, _} -> opts |> Enum.map(&String.to_integer/1) |> List.to_tuple() |> validated()
      {opts, [], _} -> opts |> Enum.into(%{}) |> validated()
      _ -> raise "Invalid arguments"
    end
  end

  defp validated(%{year: year, day: day}), do: (validate({year, day}) && {year, day}) || nil
  defp validated(%{day: day}), do: (validate({@latest_year, day}) && {@latest_year, day}) || nil
  defp validated({day}), do: validated({@latest_year, day})
  defp validated(v), do: (validate(v) && v) || nil

  defp validate({year, day}) when year in 2015..@latest_year and day in 1..25, do: true
  defp validate(_), do: false

  @default_inputs_dir Path.join(:code.priv_dir(:advent_of_code), "inputs")

  @doc """
  Removes the puzzle input from the cache.

  Should not be used to fetch inputs from the server repeatedly.
  """
  @spec delete_input!(AdventOfCode.day()) :: :ok
  @spec delete_input!(AdventOfCode.year(), AdventOfCode.day()) :: :ok
  def delete_input!(year \\ @latest_year, day),
    do: Path.join(inputs_dir(), filename(year, day)) |> File.rm!()

  @doc """
  Returns the puzzle input for the given year and day.

  If the input is not cached, it is retrieved from the server if `:allow_network?` is true and `:session_cookie` is configured.
  """
  @spec get_input!(AdventOfCode.day()) :: String.t()
  @spec get_input!(AdventOfCode.year(), AdventOfCode.day()) :: String.t()
  def get_input!(year \\ @latest_year, day) do
    cond do
      cached?(year, day) ->
        File.read!(Path.join(inputs_dir(), filename(year, day)))

      allow_network?() ->
        fetch!(year, day)
        |> cache_input!(year, day)

      true ->
        raise "Cache miss for day #{day} of year #{year} and `:allow_network?` is not `true`"
    end
  end

  defp fetch!(year, day) do
    HTTPoison.start()

    "https://adventofcode.com/#{year}/day/#{day}/input"
    |> HTTPoison.get([{"cookie", "session=#{session_token()}"}])
    |> then(fn
      {:ok, %{body: body}} -> body
      _ -> nil
    end)
  end

  defp cache_input!(input, year, day) do
    path = Path.join(inputs_dir(), filename(year, day))
    :ok = path |> Path.dirname() |> File.mkdir_p()
    :ok = File.write(path, input)
    input
  end

  defp cached?(year, day) do
    Path.join(inputs_dir(), filename(year, day))
    |> File.exists?()
  end

  defp filename(year, day) do
    day
    |> Integer.to_string()
    |> String.pad_leading(2, "0")
    |> then(fn day -> "#{year}/#{day}.txt" end)
  end

  defp config, do: Application.get_env(:advent_of_code, :inputs)
  defp allow_network?, do: Keyword.get(config(), :allow_network?, false)
  defp session_token, do: Keyword.get(config(), :session_token, System.get_env("AOC_SESSION_TOKEN"))
  defp inputs_dir, do: config() |> Keyword.get(:inputs_dir, @default_inputs_dir) |> Path.expand()
end
