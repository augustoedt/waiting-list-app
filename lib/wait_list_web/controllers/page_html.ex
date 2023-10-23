defmodule WaitListWeb.PageHTML do
  use WaitListWeb, :html

  embed_templates("page_html/*")

  @doc """
  Renders a header link.
  """
  attr :url, :string
  attr :label, :string
  attr :class, :string, default: ""

  def hlink(assigns)
end
