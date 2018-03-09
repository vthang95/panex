defmodule Panex.Math do
  @doc """
  Compute the sum with itegratee.

  Can use the shorthand way with stringify key.

  ## Examples
      iex> sum_by([1, 2, 3], &(&1 * 2))
      12
      iex> sum_by([%{val: 1}, %{val: 2}, %{val: 3}], &(&1.val))
      6
      iex> sum_by([%{a: %{b: 2}}, %{a: %{b: 6}}, %{a: %{b: 7}}], "a.b")
      15

  """

  def sum_by(enumerable, func) when is_function(func) do
    enumerable
    |> Enum.map(&(func.(&1)))
    |> Enum.sum()
  end
  def sum_by(enumerable, key) when is_bitstring(key) do
    nested_keys = key |> String.trim() |> String.split(".")
    enumerable
    |> Panex.Map.stringify_key()
    |> Enum.map(&(get_in(&1, nested_keys)))
    |> Enum.sum()
  end
end