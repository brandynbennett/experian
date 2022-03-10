defmodule ApiClientFunTest do
  use ExUnit.Case
  doctest ApiClientFun

  test "greets the world" do
    assert ApiClientFun.hello() == :world
  end
end
