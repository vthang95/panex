defmodule Panex.String do

  @moduledoc """
  String utilities
  """

  @doc """
  Return camel-case from a given string.

  ## Examples
      iex> camel_case("ha noi")
      "haNoi"
      iex> camel_case("Ha noi")
      "haNoi"
      iex> camel_case("ha-noi")
      "haNoi"

  """

  @spec camel_case(String.t) :: String.t

  def camel_case(string) do
    string
    |> String.split(~r"[^a-zA-Z]", trim: true)
    |> Enum.with_index()
    |> Enum.map(
      fn
        {el, 0} -> String.downcase(el)

        {el, _idx} -> String.capitalize(el)
      end
    )
    |> Enum.join("")
  end

  @doc """
  Return kebab-case from a given string.

  ## Examples
      iex> kebab_case("ha noi")
      "ha-noi"
      iex> kebab_case("Panex Utilities")
      "panex-utilities"

  """

  @spec kebab_case(String.t) :: String.t

  def kebab_case(string) do
    string
    |> String.split()
    |> Enum.join("-")
    |> String.downcase
  end


  @doc """
  Get index of a substring from a pattern.

  ## Examples
      iex> substring_index("abcdef", "cde")
      2
      iex> substring_index("{% sections 'header' %}", "{% endschema %}")
      nil

  """

  @spec substring_index(String.t, String.t) :: integer() | nil

  def substring_index(pattern, substring) do
    case String.split(pattern, substring, parts: 2) do
      [left, _] -> String.length(left)
      [_] -> nil
    end
  end

  @doc """
  Truncates string if it's longer than the given maximum string length

  ## Examples
      iex> truncate("asdfasdfasjdfkasdfjkadsfjk", 10)
      "asdfasdfasj..."

  """

  @spec truncate(String.t, integer()) :: String.t
  def truncate(string, num), do: String.slice(string, 0..num) <> "..."

  @doc """
  Same as `truncate/2` but can use custom omission.

  ## Examples
      iex> truncate("One two three four five six", 12, " and so on")
      "One two three and so on"

  """

  @spec truncate(String.t, integer(), String.t) :: String.t
  def truncate(string, num, str) when is_bitstring(str), do: String.slice(string, 0..num) <> str
end