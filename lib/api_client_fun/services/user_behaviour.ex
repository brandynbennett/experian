defmodule ApiClientFun.Services.UserBehaviour do
  @callback list_users() :: {:ok, list(map())} | {:error, String.t()}
  @callback get_user(String.t()) :: {:ok, map()} | {:error, String.t()}
end
