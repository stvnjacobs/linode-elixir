defmodule Linode.Distributions do
  @moduledoc """
  Documentation for Linode Distributions
  """

  @url "linode/distributions"

  @doc """
  Returns a list of maps of available distributions.
  """
  def index do
    case Linode.get(@url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} -> {:ok, body[:distributions]}
      {:ok, %HTTPoison.Response{status_code: 404, body: [errors: [%{"reason" => reason}]]}} -> {:error, reason}
      {:error, %HTTPoison.Error{reason: reason}} -> {:error, reason}
    end
  end

  @doc """
  Returns a list of maps of available distributions or fails.
  """
  def index! do
    case Linode.Distributions.index do
      {:ok, body} -> body
      {:error, reason} -> raise reason
    end
  end

  @doc """
  Returns a map of details regarding the requested distribution.
  """
  def show(id) do
    case Linode.get(@url <> "/" <> id) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} -> {:ok, Enum.into(body, %{})}
      {:ok, %HTTPoison.Response{status_code: 404, body: [errors: [%{"reason" => reason}]]}} -> {:error, reason}
      {:error, %HTTPoison.Error{reason: reason}} -> {:error, reason}
    end
  end
  
  @doc """
  Returns a map of details regarding the requested distribution or fails.
  """
  def show!(id) do
    case Linode.Distributions.show(id) do
      {:ok, body} -> Enum.into(body, %{})
      {:error, reason} -> raise reason
    end
  end
end
