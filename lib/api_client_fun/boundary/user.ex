defmodule ApiClientFun.Boundary.User do
  def profile_for_name(name) when is_binary(name) do
    user_service().list_users()
  end

  def profile_for_name(name) do
    {:error, "profile_for_name/1 expects a string, got #{name}"}
  end

  defp user_service do
    Application.get_env(:api_client_fun, :user_service)
  end
end
