defmodule EwikiWeb.PageController do
  use EwikiWeb, :controller
  @path "pages/"

  def index(conn, _params) do
    redirect(conn, to: Routes.page_path(conn, :show, "home"))
    #    render(conn, "index.html")
  end

  def search(conn, %{"search" => %{"stext" => stext}} = opts) do

    IO.inspect opts, label: "search opts"
    
    search_results = Ewiki.Search.search(@path, stext)
    IO.inspect search_results, label: "searchresult"

    cond do
      search_results == ["No matches."] ->
        render(conn, "no_matches.html")
      true ->
        render(conn, "search_results.html", search_results: search_results, stext: stext)
    end

  end

  def save(conn, %{"page" => page, "foo" => %{"content" => content}} = opts) do
    IO.inspect opts, label: "save opts"

    write_page(page, content)

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

  defp write_page(page, content) do
    case File.write(page_path(page), content) do
      :ok -> "ok"
      {:error, reason} -> reason
    end
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
