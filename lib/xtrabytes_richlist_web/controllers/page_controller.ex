defmodule XtrabytesRichlistWeb.PageController do
  use XtrabytesRichlistWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
