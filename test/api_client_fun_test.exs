defmodule ApiClientFunTest do
  use ExUnit.Case

  alias ApiClientFun.Core.Profile

  import Mox
  setup :verify_on_exit!

  test "profile_for_name/1 returns the profile" do
    {:ok, pid} = ApiClientFun.Boundary.UserRepo.new()

    allow(ApiClientFun.Services.UserMock, self(), pid)

    ApiClientFun.Services.UserMock
    |> expect(:list_users, fn ->
      {:ok, [Jason.decode!(response_fixture())]}
    end)

    assert %Profile{age: 25, gender: "M", planet: "Earth", species: "Human", status: "Alive"} =
             ApiClientFun.profile_for_name("Philip J Fry")
  end

  defp response_fixture do
    ~s({"company":"Planet Express","id":1,"name":"Philip J Fry","position":"Delivery Boy","profile":{"age":25,"gender":"M","planet":"Earth","species":"Human","status":"Alive"}})
  end
end
