defmodule ApiClientFun.Services.User do
  @behaviour ApiClientFun.Services.UserBehaviour

  # @user_url "https://blooming-savannah-20593.herokuapp.com/api/users"

  @impl true
  def list_users do
    # HTTPoison.get!(@user_url, [], recv_timeout: 1000)
    {:ok, [%{}]}
  end

  @impl true
  def get_user(_id) do
    {:ok, %{}}
  end
end
