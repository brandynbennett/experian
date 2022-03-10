defmodule ApiClientFun.Boundary.User do
  def profile_for_name(name) do
    user_service().profile_for_name(name)
  end

  defp user_service do
    Application.get_env(:api_client_fun, :user_service)
  end
end
