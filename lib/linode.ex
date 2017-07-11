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

  def process_index_body(url, key) do
    case Linode.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} -> {:ok, body[key]}
      {:ok, %HTTPoison.Response{status_code: 404, body: [errors: [%{"reason" => reason}]]}} -> {:error, reason}
      {:error, %HTTPoison.Error{reason: reason}} -> {:error, reason}
    end
  end

  def process_show_body(url) do
    case Linode.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} -> {:ok, Enum.into(body, %{})}
      {:ok, %HTTPoison.Response{status_code: 404, body: [errors: [%{"reason" => reason}]]}} -> {:error, reason}
      {:error, %HTTPoison.Error{reason: reason}} -> {:error, reason}
    end
  end
end

