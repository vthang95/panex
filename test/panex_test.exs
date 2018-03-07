defmodule PanexTest do
  use ExUnit.Case
  doctest Panex
  doctest Panex.Collection, import: true
  doctest Panex.String, import: true
  doctest Panex.Map, import: true
end
