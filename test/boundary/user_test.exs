defmodule ApiClientFun.Boundary.UserTest do
  use ExUnit.Case, async: true
  alias ApiClientFun.Boundary.User

  import Mox
  setup :verify_on_exit!

  test "profile_for_name/1 error if not string" do
    ApiClientFun.Services.UserMock
    |> expect(:profile_for_name, fn :foo ->
      {:error, "profile_for_name/1 expects a string, got #{:foo}"}
    end)

    User.profile_for_name(:foo)
  end
end
