defmodule EwikiWeb.PageView do
  use EwikiWeb, :view

  def remove_angle_brackets(str) do
    str
    |> String.replace("<", "")
    |> String.replace(">", "")
  end

  def status() do
    "status"
  end

  def show_params(params) do
    IO.inspect(params)
  end

end
