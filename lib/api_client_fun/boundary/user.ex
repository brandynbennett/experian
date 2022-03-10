defmodule ApiClientFun.Boundary.User do
  alias ApiClientFun.Core.{User, Profile}

  def profile_for_name(name) when is_binary(name) do
    {:ok, user_data} = user_service().list_users()

    create_users(user_data)
    |> Enum.find(&(&1.name == name))
    |> Map.get(:profile)
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
      if field_allowed?(key) do
        Keyword.put(acc, String.to_existing_atom(key), extract_value(key, raw_data[key]))
      else
        acc
      end
    end)
  end

  defp field_allowed?(key) do
    Enum.map(allowed_fields(), &Atom.to_string(&1))
    |> Enum.member?(key)
  end

  defp allowed_fields do
    Enum.concat(Map.keys(User.__struct__()), Map.keys(Profile.__struct__()))
  end

  defp extract_value("profile", value) do
    user_data_to_field_list(value)
    |> Profile.new()
  end

  defp extract_value(_key, value), do: value
end
