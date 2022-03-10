defmodule ApiClientFun.Services.UserBehaviour do
  alias ApiClientFun.Core.Profile

  @callback profile_for_name(String.t()) :: {:ok, Profile.t()} | {:error, String.t()}
end
