defmodule AdventOfCode.Input do
  @moduledoc """
  Manages puzzle input files and parsing command line arguments.
  """

  @latest_year AdventOfCode.get_latest_year()

  @default_inputs_dir Path.join(:code.priv_dir(:advent_of_code), "inputs")

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

  @doc """
  Removes the puzzle input from the cache.

  Should not be used to fetch inputs from the server repeatedly.
  """
  @spec delete!(AdventOfCode.day()) :: :ok
  @spec delete!(AdventOfCode.year(), AdventOfCode.day()) :: :ok
  def delete!(year \\ @latest_year, day),
    do: Path.join(inputs_dir(), filename(year, day)) |> File.rm!()

  @doc """
  Returns the puzzle input for the given year and day.

  If the input is not cached, it is retrieved from the server if `:allow_network?` is true and `:session_cookie` is configured.
  """
  @spec get!(AdventOfCode.day()) :: binary()
  @spec get!(AdventOfCode.year(), AdventOfCode.day()) :: binary()
  def get!(year \\ @latest_year, day) do
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

  defp config, do: Application.get_env(:advent_of_code, __MODULE__)
  defp allow_network?, do: Keyword.get(config(), :allow_network?, false)
  defp session_token, do: Keyword.get(config(), :session_token, System.get_env("SESSION_TOKEN"))
  defp inputs_dir, do: config() |> Keyword.get(:inputs_dir, @default_inputs_dir) |> Path.expand()
end
