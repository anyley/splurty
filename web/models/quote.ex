defmodule Splurty.Quote do
  use Splurty.Web, :model

  schema "quotes" do
    field :saying, :string
    field :author, :string

    timestamps
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:saying, :author])
    |> validate_required([:saying, :author])
  end
end
