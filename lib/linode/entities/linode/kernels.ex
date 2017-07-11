defmodule Linode.Kernels do
  @moduledoc """
  Documentation for Linode Kernels
  """

  @url "linode/kernels"

  @doc """
  Returns a list of maps of available kernels.
  """
  def index do
    case Linode.get(@url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} -> {:ok, body[:kernels]}
      {:ok, %HTTPoison.Response{status_code: 404, body: [errors: [%{"reason" => reason}]]}} -> {:error, reason}
      {:error, %HTTPoison.Error{reason: reason}} -> {:error, reason}
    end
  end

  @doc """
  Returns a list of maps of available kernels or fails.
  """
  def index! do
    case Linode.Kernels.index do
      {:ok, body} -> body
      {:error, reason} -> raise reason
    end
  end

  @doc """
  Returns a map of details regarding the requested kernel.
  """
  def show(id) do
    case Linode.get(@url <> "/" <> id) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} -> {:ok, Enum.into(body, %{})}
      {:ok, %HTTPoison.Response{status_code: 404, body: [errors: [%{"reason" => reason}]]}} -> {:error, reason}
      {:error, %HTTPoison.Error{reason: reason}} -> {:error, reason}
    end
  end
  
  @doc """
  Returns a map of details regarding the requested kernel or fails.
  """
  def show!(id) do
    case Linode.Kernels.show(id) do
      {:ok, body} -> Enum.into(body, %{})
      {:error, reason} -> raise reason
    end
  end
end
