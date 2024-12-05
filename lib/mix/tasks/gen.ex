defmodule Mix.Tasks.Gen do
  @moduledoc """
  Generates boilerplate code for the given year and day.
  """
  use Mix.Task

  @impl Mix.Task
  def run(argv) do
    {year, day} = AdventOfCode.parse_args!(argv)

    AdventOfCode.get_input!(year, day)

    title = get_puzzle_title(year, day)

    solution_content =
      EEx.eval_file("templates/solution.eex",
        year: to_string(year),
        day: to_string(day),
        title: title
      )

    solution_test_content =
      EEx.eval_file("templates/solution_test.eex", year: to_string(year), day: to_string(day))

    day
    |> Integer.to_string()
    |> String.pad_leading(2, "0")
    |> then(fn day -> "lib/#{year}/#{day}.ex" end)
    |> create_file(solution_content)

    day
    |> Integer.to_string()
    |> String.pad_leading(2, "0")
    |> then(fn day -> "test/#{year}/#{day}_test.exs" end)
    |> create_file(solution_test_content)
  end

  defp get_puzzle_title(year, day) do
    HTTPoison.start()

    "https://adventofcode.com/#{year}/day/#{day}"
    |> HTTPoison.get()
    |> then(fn
      {:ok, %HTTPoison.Response{body: body}} -> body
      _ -> nil
    end)
    |> Floki.parse_document!()
    |> Floki.find("h2")
    |> Floki.text()
  rescue
    _ -> ""
  end

  defp create_file(path, content) do
    :ok = path |> Path.dirname() |> File.mkdir_p()

    unless File.exists?(path) do
      File.write(path, content)
    end
  end
end
