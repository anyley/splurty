defmodule Splurty.QuoteController do
  use Splurty.Web, :controller

  def index(conn, _params) do
    conn
    |> assign(:quotes, Repo.all(Splurty.Quote))
    |> render("index.html")
  end

  def new(conn, _params) do
    conn
    |> render("new.html")
  end

  def create(conn, %{"quote" => %{"saying" => saying, "author" => author}}) do
    q = %Splurty.Quote{saying: saying, author: author}
    Repo.insert(q)
    redirect conn, to: quote_path(conn, :index)
  end

  def show(conn, %{"id" => id}) do
    {id, _} = Integer.parse(id)
    q = Repo.get(Splurty.Quote, id)
    conn
    |> assign(:quote, q)
    |> render("show.html")
  end

  def edit(conn, %{"id" => id}) do
    {id, _} = Integer.parse(id)
    q = Repo.get(Splurty.Quote, id)
    conn
    |> assign(:quote, q)
    |> render("edit.html")
  end

  def update(conn, %{"id" => id, "quote" => %{"saying" => saying, "author" => author}}) do
    q = Repo.get(Splurty.Quote, id)
    changeset = Splurty.Quote.changeset(q, %{saying: saying, author: author})

    case Repo.update(changeset) do
      {:ok, q} ->
        conn
        |> put_flash(:info, "Quote updated successfully.")
        |> redirect(to: quote_path(conn, :show, q))
      {:error, changeset} ->
        render(conn, "edit.html", quote: q, changeset: changeset)
    end
  end

end
