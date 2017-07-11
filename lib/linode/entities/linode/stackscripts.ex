defmodule Linode.Stackscripts do
  @moduledoc """
  Documentation for Linode StackScripts
  """

  @url "linode/stackscripts"

  @doc """
  Returns a list of maps of available StackScripts.
  """
  def index do
    Linode.process_index_body(@url, :stackscripts)
  end

  @doc """
  Returns a list of maps of available StackScripts or fails.
  """
  def index! do
    case Linode.Stackscripts.index do
      {:ok, body} -> body
      {:error, reason} -> raise reason
    end
  end

  @doc """
  Returns a map of details regarding the requested StackScript.
  """
  def show(id) do
    url = @url <> "/" <> id
    Linode.process_show_body(url)
  end

  @doc """
  Returns a map of details regarding the requested StackScript or fails.
  """
  def show!(id) do
    case Linode.Stackscripts.show(id) do
      {:ok, body} -> Enum.into(body, %{})
      {:error, reason} -> raise reason
    end
  end
end
