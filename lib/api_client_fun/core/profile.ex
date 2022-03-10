defmodule ApiClientFun.Core.Profile do
  defstruct age: 0, gender: "", planet: "", species: "", status: ""

  def new(fields) do
    struct!(__MODULE__, fields)
  end
end

# {"company":"Planet Express","id":1,"name":"Philip J Fry","position":"Delivery Boy","profile":{"age":25,"gender":"M","planet":"Earth","species":"Human","status":"Alive"}}
