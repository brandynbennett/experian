defmodule ApiClientFun.Boundary.UserRepo do
  use GenServer

  alias ApiClientFun.Core.{User, Profile}

  def new(users \\ [], name \\ __MODULE__) do
    GenServer.start_link(__MODULE__, users, name: name)
  end

  @doc """
  Get a user's profile
  """
  def profile_for_name(server \\ __MODULE__, name) do
    GenServer.call(server, {:profile_for_name, name})
  end

  @impl true
  def init(users \\ []) do
    {:ok, users}
  end

  @impl true
  def handle_call({:profile_for_name, name}, _from, users) when is_binary(name) do
    with {:ok, user_data} <- fetch_users() do
      users = create_users(user_data)

      find_user_profile(users, name)
      |> profile_response(name, users)
    else
      {:error, server_error} ->
        {:reply, {:error, server_error}, users}

      anything_else ->
        {:reply, {:error, anything_else}, users}
    end
  end

  def handle_call({:profile_for_name, name}, _from, users) do
    {:reply, {:error, "profile_for_name/1 expects a string, got #{name}"}, users}
  end

  defp fetch_users do
    user_service().list_users()
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

  defp find_user_profile(users, name) do
    Enum.find(users, &(&1.name == name))
    |> find_user_profile()
  end

  defp find_user_profile(%User{} = user), do: user.profile
  defp find_user_profile(anything), do: anything

  defp profile_response(nil, name, users) do
    {:reply, {:error, "#{name} is not a user"}, users}
  end

  defp profile_response(profile, _name, users) do
    {:reply, profile, users}
  end
end
