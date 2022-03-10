defmodule ApiClientFun.Core.Profile do
  @type t :: %__MODULE__{
          age: integer(),
          gender: String.t(),
          planet: String.t(),
          species: String.t(),
          status: String.t()
        }

  defstruct age: 0, gender: "", planet: "", species: "", status: ""

  def new(fields \\ []) do
    struct!(__MODULE__, fields)
  end
end

# {"company":"Planet Express","id":1,"name":"Philip J Fry","position":"Delivery Boy","profile":{"age":25,"gender":"M","planet":"Earth","species":"Human","status":"Alive"}}
