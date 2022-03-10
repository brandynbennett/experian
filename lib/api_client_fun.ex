defmodule ApiClientFun do
  @moduledoc """
  Find user data
  """

  alias ApiClientFun.Boundary.UserRepo

  @doc """
  Get a user's profile from their name
  """
  def profile_for_name(name) do
    UserRepo.new()
    UserRepo.profile_for_name(name)
  end
end
