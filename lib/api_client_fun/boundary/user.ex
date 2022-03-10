defmodule ApiClientFun.Boundary.User do
  alias ApiClientFun.Core.{User, Profile}

  def profile_for_name(name) when is_binary(name) do
    {:ok, user_data} = user_service().list_users()
    create_users(user_data["users"])
  end

  def profile_for_name(name) do
    {:error, "profile_for_name/1 expects a string, got #{name}"}
  end

  defp user_service do
    Application.get_env(:api_client_fun, :user_service)
  end

  defp create_users(data) do
    Enum.map(data, fn raw ->
      user_data_to_field_list(raw)
      |> User.new()
    end)
  end

  defp user_data_to_field_list(raw_data) do
    Map.keys(raw_data)
    |> Enum.reduce(Keyword.new(), fn key, acc ->
      Keyword.put(acc, String.to_existing_atom(key), extract_value(key, raw_data[key]))
    end)
  end

  defp extract_value("profile", value) do
    user_data_to_field_list(value)
    |> Profile.new()
  end

  defp extract_value(_key, value), do: value
end
