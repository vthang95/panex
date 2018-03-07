defmodule Panex.Map do
  @moduledoc """
  Map utilities
  """

  @doc """
  Convert arrow map to key-value map.

  ## Examples
      iex> atomize_key(%{"a" => 1, "b" => "hola"})
      %{a: 1, b: "hola"}
      iex> atomize_key(%{"a" => 1, "b" => %{"c" => 2}})
      %{a: 1, b: %{c: 2}}

  """

  @spec atomize_key(map()) :: map()

  def atomize_key(nil), do: nil
  def atomize_key(map) when is_map(map) do
    for {key, val} <- map, into: %{}, do: {String.to_atom(key), atomize_key(val)}
  end
  def atomize_key([h|t]), do: [atomize_key(h) | atomize_key(t)]
  def atomize_key(not_map), do: not_map

  @doc """
  Convert key-value map to arrow map

  ## Examples
      iex> stringify_key(%{a: 1, b: "hello"})
      %{"a" => 1, "b" => "hello"}
      iex> stringify_key(%{a: 1, b: %{"c": "nihao"}})
      %{"a" => 1, "b" => %{"c" => "nihao"}}
  """

  @spec stringify_key(map()) :: map()

  def stringify_key(nil), do: nil
  def stringify_key(map) when is_map(map) do
    for {key, val} <- map, into: %{}, do: {Atom.to_string(key), stringify_key(val)}
  end
  def stringify_key([h|t]), do: [stringify_key(h) | stringify_key(t)]
  def stringify_key(not_map), do: not_map
end