defmodule Linode.Types do
  @moduledoc """
  Documentation for Linode Types
  """

  @url "linode/types"

  @doc """
  Returns a list of maps of available types.
  """
  def index do
    Linode.process_index_body(@url, :types)
  end

  @doc """
  Returns a list of maps of available types or fails.
  """
  def index! do
    case Linode.Types.index do
      {:ok, body} -> body
      {:error, reason} -> raise reason
    end
  end

  @doc """
  Returns a map of details regarding the requested type.
  """
  def show(id) do
    url = @url <> "/" <> id
    Linode.process_show_body(url)
  end

  @doc """
  Returns a map of details regarding the requested type or fails.
  """
  def show!(id) do
    case Linode.Types.show(id) do
      {:ok, body} -> Enum.into(body, %{})
      {:error, reason} -> raise reason
    end
  end
end
