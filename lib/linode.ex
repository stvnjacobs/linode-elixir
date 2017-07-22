defmodule Linode do
  @moduledoc """
  An Elixir client for the Linode API v4.
  """

  use HTTPoison.Base

  @endpoint Application.fetch_env!(:linode, :endpoint)
  @access_token Application.fetch_env!(:linode, :access_token)
  @user_agent Application.get_env(:linode, :user_agent, "linode-elixir")

  @doc """
  Adds `Authorization` string to request headers.

  Authorization to the Linode API is handled using OAuth2 tokens.
  Details for obtaining an access token can be found [in their documentation](https://developers.linode.com/v4/access).
  Once a token is acquired, it can be used by setting appropiate `Authorization` header.

  ## Examples

      iex> Linode.authorization_header([], %{access_token: "keep-it-like-a-secret"})
      [{"Authorization", "token keep-it-like-a-secret"}]
  """
  def authorization_header(headers, %{access_token: token}) do
    headers ++ [{"Authorization", "token #{token}"}]
  end

  @doc """
  Adds `User-Agent` string to the request headers.

  If `:user_agent` is set in your mix config for `:linode`, that user agent string is used.
  If there is no `:user_agent` config value, `linode-elixir` is used.

  ## Examples

      iex> Linode.user_agent_header([], %{user_agent: "linode-elixir"})
      [{"User-Agent", "linode-elixir"}]
  """
  def user_agent_header(headers, %{user_agent: user_agent}) do
    headers ++ [{"User-Agent", user_agent}]
  end

  def process_url(url) do
    @endpoint <> url
  end

  def process_request_headers(headers) do
    headers
    |> authorization_header(%{access_token: @access_token})
    |> user_agent_header(%{user_agent: @user_agent})
  end

  def process_response_body(body) do
    body
    |> Poison.decode!
    |> Enum.map(fn({k, v}) -> {String.to_atom(k), v} end)
  end

  def process_index_body(url, key) do
    case Linode.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} -> {:ok, body[key]}
      {:ok, %HTTPoison.Response{status_code: 401, body: [errors: [%{"reason" => reason}]]}} -> {:error, reason}
      {:ok, %HTTPoison.Response{status_code: 404, body: [errors: [%{"reason" => reason}]]}} -> {:error, reason}
      {:error, %HTTPoison.Error{reason: reason}} -> {:error, reason}
    end
  end

  def process_show_body(url) do
    case Linode.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} -> {:ok, Enum.into(body, %{})}
      {:ok, %HTTPoison.Response{status_code: 401, body: [errors: [%{"reason" => reason}]]}} -> {:error, reason}
      {:ok, %HTTPoison.Response{status_code: 404, body: [errors: [%{"reason" => reason}]]}} -> {:error, reason}
      {:error, %HTTPoison.Error{reason: reason}} -> {:error, reason}
    end
  end

  def process_post_body(url) do
    case Linode.post(url, Poison.encode!(%{})) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} -> {:ok, Enum.into(body, %{})}
      {:ok, %HTTPoison.Response{status_code: 400, body: [errors: [%{"reason" => reason}]]}} -> {:error, reason}
      {:ok, %HTTPoison.Response{status_code: 401, body: [errors: [%{"reason" => reason}]]}} -> {:error, reason}
      {:ok, %HTTPoison.Response{status_code: 404, body: [errors: [%{"reason" => reason}]]}} -> {:error, reason}
      {:error, %HTTPoison.Error{reason: reason}} -> {:error, reason}
    end
  end
end

