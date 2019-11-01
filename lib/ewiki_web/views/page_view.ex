defmodule EwikiWeb.PageView do
  use EwikiWeb, :view

  def status() do
    "status"
  end

  def show_params(params) do
    IO.inspect(params)
  end

end
