defmodule ApiClientFun.Services.UserStub do
  @behaviour ApiClientFun.Services.UserBehaviour

  @impl true
  def list_users do
    {:ok, [%{}]}
  end

  @impl true
  def get_user(_id) do
    {:ok, %{}}
  end
end
