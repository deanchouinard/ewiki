defmodule EwikiWeb.PageController do
  use EwikiWeb, :controller
  @path "pages/"

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def save(conn, %{"page" => page} = opts) do
    IO.inspect opts, label: "save opts"
  
    redirect(conn, to: Routes.page_path(conn, :show, page))

      #render(conn, "index.html")
  end

  def edit(conn, %{"page" => page} = opts) do
    #    IO.inspect opts, label: "opts"
    # IO.inspect conn, label: "conn assigns"

    content = read_page(page)

    conn = assign(conn, :page, page)

    render(conn, "edit.html", content: content)

  end

  def show(conn, %{"page" => page} = params) do
    IO.inspect params, label: "params"
    #    IO.inspect conn, label: "conn"

    content = read_page(page)

    IO.inspect content, label: "content"

    content = Earmark.as_html!(content)

    conn = assign(conn, :page, page)
    render(conn, "show.html", content: content)
  end

  def status(conn, %{"message" => message} = params) do
    IO.inspect params, label: "params"
    #    IO.inspect conn, label: "conn"
    content = case File.read("pages/home.md") do
      {:ok, text} ->
        text
      {_} ->
        "error"
    end

    IO.inspect content, label: "content"

    render(conn, "status.html", content: content)
  end

  defp read_page(page) do
    case File.read(page_path(page)) do
      {:ok, text} ->
        text
      {:error, msg} ->
        "Error: #{msg}"
    end
  end

  defp page_path(page), do: "#{@path}#{page}.md"
end
