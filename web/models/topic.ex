defmodule Todo.Topic do
  use Todo.Web, :model

  schema "topics" do
    field :title, :string
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params,[:title])
    |> validate_required([:title])
  end

end
