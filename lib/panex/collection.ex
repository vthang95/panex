defmodule Panex.Collection do
  @moduledoc """
  Collection utilities
  """

  @doc """
  Get intersection from given lists.

  ## Examples
      iex> intersection([1, 2, 3, 4], [2, 3])
      [2, 3]
      iex> intersection(["index", "carousel", "header", "footer"], ["header", "footer"])
      ["header", "footer"]

  """

  @spec intersection(list(), list()) :: list()

  def intersection(first, second) do
    first |> Enum.filter(&(Enum.member?(second, &1)))
  end

  @doc """
  Returns the list dropping its last element

  ## Examples
      iex> initial([1, 2, 3, 4])
      [1, 2, 3]

  """

  @spec initial(list()) :: list()

  def initial(collection), do: _initial(collection)

  def _initial([_]), do: []
  def _initial([h|t]), do: [h| _initial(t)]

  @doc """
  Remove all falsy values in collection

  ## Examples
      iex> compact([1, 2, 3, nil, 4, nil, 5])
      [1, 2, 3, 4, 5]
      iex> compact(["hello", "hola", false, "bonjour"])
      ["hello", "hola", "bonjour"]

  """

  @spec compact(list()) :: list()

  def compact(collection) do
    Enum.reject(collection, fn
      nil   -> true
      false -> true
      _     -> false
    end)
  end

  @doc """
  Remove all elements that match the pattern in a collection

  ## Examples
      iex> reject([1, 2, 3, nil, 4, nil, 5], nil)
      [1, 2, 3, 4, 5]
      iex> reject(["morning", "afternoon", %{a: "noon"}, "night"], %{a: "noon"})
      ["morning", "afternoon", "night"]

  """

  @spec reject(list(), any()) :: list()

  def reject(collection, pattern) do
    Enum.reject(collection, fn el -> el == pattern end)
  end

  @doc """
  This method is like _.difference except that it accepts iteratee which is invoked for each element of array and values to generate the criterion by which they're compared.
  The order and references of result values are determined by the first array. The iteratee is invoked with one argument

  ## Examples
      iex> difference_by([2.1, 1.2], [2.3, 3.4], &Kernel.round/1)
      [1.2]
      iex> difference_by([%{"x" => 2}, %{"x" => 1}], [%{"x" => 1}], &(&1["x"]))
      [%{"x" => 2}]

  Iteratee shorthand

      iex> difference_by([%{"x" => 2}, %{"x" => 1}], [%{"x" => 1}], "x")
      [%{"x" => 2}]
      iex> difference_by([%{x: 2}, %{x: 1}], [%{x: 1}], :x)
      [%{x: 2}]

  """

  @spec difference_by(list(), list(), (any() -> any())) :: list()

  def difference_by(list, alist, key) when is_bitstring(key) or is_atom(key) do
    new_alist = alist |> Enum.map(&(&1[key]))
    list
    |> Enum.filter(fn el -> !Enum.member?(new_alist, el[key]) end)
  end
  def difference_by(list, alist, func) when is_function(func) do
    new_alist = alist |> Enum.map(&(func.(&1)))
    list
    |> Enum.filter(fn el -> !Enum.member?(new_alist, func.(el)) end)
  end

  @doc """
  Return a slice of array excluding elements dropped from the end.

  ## Examples
      iex> drop_right_while([1, 2, 3, 4, 5], &(&1 == 4))
      [1, 2, 3]
      iex> drop_right_while([%{a: 1, b: 2}, %{a: 2, b: 2}], &(&1.a == 2))
      [%{a: 1, b: 2}]

  """

  @spec drop_right_while(list(), (... -> boolean)) :: list()

  def drop_right_while(list, func) when is_function(func) do
    _drop_loop(list, [], func)
  end
  def _drop_loop([], acc, _func), do: acc
  def _drop_loop([h|t], acc, func), do: if func.(h), do: acc, else: _drop_loop(t, acc ++ [h], func)

  @doc """
  Fills a number of elements of a list with initial value

  ## Examples
      iex> fill(5, nil)
      [nil, nil, nil, nil, nil]
      iex> fill(3, "hi")
      ["hi", "hi", "hi"]
  """

  @spec fill(integer(), any()) :: [any()]

  def fill(num, val) when is_number(num), do: for _ <- 1..num, do: val

  @doc """
  Return a map from a list of pairs

  ## Examples
      iex> from_pairs([[:a, 1], [:b, 2]])
      %{a: 1, b: 2}
      iex> from_pairs([["vn", "Xin chao"], ["us", "hello"]])
      %{"us" => "hello", "vn" => "Xin chao"}

  """

  @spec from_pairs(list()) :: map()

  def from_pairs(list) do
    exc = fn
      (acc, key, val) when is_bitstring(key) or is_atom(key) -> Map.put(acc, key, val)
      (_, _, _) -> throw("Key must be a string or atom.")
    end
    Enum.reduce(list, %{}, fn ([key, val], acc) -> exc.(acc, key, val) end)
  end

  @doc """
  Find index from right to left.

  ## Examples
      iex> last_index_of([1, 1, 3, 4, 2], 4)
      3
      iex> last_index_of([1, 9, 3, 1, 2], 4)
      nil

  """

  @spec last_index_of(list(), any()) :: integer()

  def last_index_of(list, el) do
    list
    |> Enum.reverse()
    |> Enum.find_index(&(&1 == el))
    |> case do
      nil -> nil
      idx -> length(list) - idx - 1
    end
  end

  @doc """
  Same as `last_index_of/2` but search from the index.

  ## Examples
      iex> last_index_of([1, 1, 3, 4, 2], 4, 2)
      3
      iex> last_index_of("abbcd" |> String.graphemes, "b", 3)
      nil

  """

  @spec last_index_of(list(), any(), integer) :: integer()

  def last_index_of(list, el, from) do
    list = list |> Enum.drop(from)

    list
    |> Enum.reverse()
    |> Enum.find_index(&(&1 == el))
    |> case do
      nil -> nil
      idx -> length(list) - idx - 1 + from
    end
  end
end