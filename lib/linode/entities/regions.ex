defmodule Linode.Regions do
  @moduledoc """
  Documentation for Linode Regions
  """

  @url "regions"

  @doc """
  Returns a list of maps of available regions.
  """
  def index do
    Linode.process_index_body(@url, :regions)
  end

  @doc """
  Returns a list of maps of available regions or fails.
  """
  def index! do
    case Linode.Regions.index do
      {:ok, body} -> body
      {:error, reason} -> raise reason
    end
  end

  @doc """
  Returns a map of details regarding the requested region.
  """
  def show(id) do
    url = @url <> "/" <> id
    Linode.process_show_body(url)
  end

  @doc """
  Returns a map of details regarding the requested region or fails.
  """
  def show!(id) do
    case Linode.Regions.show(id) do
      {:ok, body} -> Enum.into(body, %{})
      {:error, reason} -> raise reason
    end
  end
end
