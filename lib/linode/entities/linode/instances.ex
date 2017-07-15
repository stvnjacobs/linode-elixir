defmodule Linode.Instances do
  @moduledoc """
  Documentation for Linode Instances
  """

  @url "linode/instances"

  @doc """
  Returns a list of maps of current Linode instances.
  """
  def index do
    Linode.process_index_body(@url, :linodes)
  end

  @doc """
  Returns a list of maps of current Linode instances or fails.
  """
  def index! do
    case Linode.Instances.index do
      {:ok, body} -> body
      {:error, reason} -> raise reason
    end
  end

  @doc """
  Returns a map of details regarding the requested Linode instance.
  """
  def show(id) do
    url = @url <> "/" <> id
    Linode.process_show_body(url)
  end

  @doc """
  Returns a map of details regarding the requested Linode instance or fails.
  """
  def show!(id) do
    case Linode.Instances.show(id) do
      {:ok, body} -> Enum.into(body, %{})
      {:error, reason} -> raise reason
    end
  end
end
