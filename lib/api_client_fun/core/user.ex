defmodule ApiClientFun.Core.User do
  defstruct id: nil, company: "", name: "", position: "", profile: nil

  def new(fields) do
    struct!(__MODULE__, fields)
  end
end

# {"company":"Planet Express","id":1,"name":"Philip J Fry","position":"Delivery Boy","profile":{"age":25,"gender":"M","planet":"Earth","species":"Human","status":"Alive"}}
