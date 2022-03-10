defmodule ApiClientFun.Boundary.UserRepoTest do
  use ExUnit.Case, async: true
  alias ApiClientFun.Boundary.UserRepo
  alias ApiClientFun.Core.Profile

  import Mox
  setup :verify_on_exit!

  test "profile_for_name/1 error if not string" do
    UserRepo.new()

    assert UserRepo.profile_for_name(:foo) ==
             {:error, "profile_for_name/1 expects a string, got #{:foo}"}
  end

  test "profile_for_name/1 gets all users if they are not cached" do
    {:ok, pid} = UserRepo.new()

    allow(ApiClientFun.Services.UserMock, self(), pid)

    ApiClientFun.Services.UserMock
    |> expect(:list_users, fn ->
      {:ok,
       [
         Jason.decode!(
           ~s({"company":"Planet Express","id":1,"name":"Philip J Fry","position":"Delivery Boy","profile":{"age":25,"gender":"M","planet":"Earth","species":"Human","status":"Alive"}})
         )
       ]}
    end)

    assert %Profile{age: 25, gender: "M", planet: "Earth", species: "Human", status: "Alive"} =
             UserRepo.profile_for_name("Philip J Fry")
  end

  test "profile_for_name/1 returns error for non existant user" do
    {:ok, pid} = UserRepo.new()

    allow(ApiClientFun.Services.UserMock, self(), pid)

    ApiClientFun.Services.UserMock
    |> expect(:list_users, fn ->
      {:ok,
       [
         Jason.decode!(
           ~s({"company":"Planet Express","id":1,"name":"Philip J Fry","position":"Delivery Boy","profile":{"age":25,"gender":"M","planet":"Earth","species":"Human","status":"Alive"}})
         )
       ]}
    end)

    assert {:error, "foo is not a user"} = UserRepo.profile_for_name("foo")
  end

  test "profile_for_name/1 returns server errors if no data" do
    {:ok, pid} = UserRepo.new()

    allow(ApiClientFun.Services.UserMock, self(), pid)

    ApiClientFun.Services.UserMock
    |> expect(:list_users, fn ->
      {:error, "Stuff broke"}
    end)

    assert {:error, "Stuff broke"} = UserRepo.profile_for_name("Philip J Fry")
  end
end
