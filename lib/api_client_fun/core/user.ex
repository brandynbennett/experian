defmodule ApiClientFun.Core.User do
  defstruct id: nil, company: "", name: "", position: "", profile: nil

  def new(fields) do
    struct!(__MODULE__, fields)
  end
end
