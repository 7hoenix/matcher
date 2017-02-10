defmodule Matchr.Repo do
  use Ecto.Repo, otp_app: :matchr

  defmacro __using__(_) do
    quote do
      alias Matchr.Repo
      import Ecto
      import Ecto.Changeset
      import Ecto.Query
    end
  end
end
