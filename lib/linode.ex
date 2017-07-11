defmodule Linode do
  @moduledoc false

  use HTTPoison.Base

  @endpoint Application.fetch_env!(:linode, :endpoint)
  @access_token Application.fetch_env!(:linode, :access_token)

  def process_url(url) do
    @endpoint <> url
  end

  def process_response_body(body) do
    body
    |> Poison.decode!
    |> Enum.map(fn({k, v}) -> {String.to_atom(k), v} end)
  end

end

