defmodule Flightex.Users.CreateOrUpdate do
  alias Flightex.Users.{Agent, User}

  def call(params) do
    Agent.get(params.id)
    |> handle_call(params)
  end

  defp handle_call({:error, _reason}, %User{name: name, email: email, cpf: cpf}) do
    case User.build(name, email, cpf) do
      {:ok, user} -> Agent.save(user)
      {:error, reason} -> {:error, reason}
    end
  end

  defp handle_call({:ok, _user}, %User{} = params) do
    Agent.save(params)
  end
end
