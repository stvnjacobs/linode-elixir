defmodule Linode.Distributions do
  @moduledoc """
  Documentation for Linode Distributions
  """

  @url "linode/distributions"

  @doc """
  Returns a list of maps of available distributions.
  """
  def index do
    Linode.process_index_body(@url, :distributions)
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
    url = @url <> "/" <> id
    Linode.process_show_body(url)
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
