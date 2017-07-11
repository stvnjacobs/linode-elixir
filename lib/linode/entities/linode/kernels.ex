defmodule Linode.Kernels do
  @moduledoc """
  Documentation for Linode Kernels
  """

  @url "linode/kernels"

  @doc """
  Returns a list of maps of available kernels.
  """
  def index do
    Linode.process_index_body(@url, :kernels)
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
    url = @url <> "/" <> id
    Linode.process_show_body(url)
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
