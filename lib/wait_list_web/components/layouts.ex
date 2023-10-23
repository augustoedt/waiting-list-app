defmodule WaitListWeb.Layouts do
  use WaitListWeb, :html
  IO.puts(:html)
  embed_templates "layouts/*"
end
