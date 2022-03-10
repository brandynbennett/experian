defmodule ApiClientFun.Services.User do
  alias ApiClientFun.Core.Profile

  @behaviour ApiClientFun.Services.UserBehaviour

  @impl true
  def profile_for_name(_name) do
    Profile.new()
  end
end
