defmodule XtrabytesRichlist.Scraper do
  import Excrawl

  ## todo: add comments
  parser :fetch_xby_rich_list do
    text(name: :headinig, css: "h1")

    groups name: :rows, css: "tr" do
      text(name: :address, css: "td:first-child")
      text(name: :balance, css: "td:last-child")
    end
  end

  def fetch_rich_data() do
    markup = HTTPotion.get("http://borzalom.hu/richlist.html")

    case markup do
      %HTTPotion.Response{body: body, status_code: 200} ->
        scraped_data = XtrabytesRichlist.Scraper.fetch_xby_rich_list(body)
        format_data(scraped_data)

      _ ->
        nil
    end
  end

  def format_data(%{headinig: heading} = rich_list_data) do
    block_no =
      String.split(heading, " ")
      |> Enum.at(3)
      |> String.to_integer()

    rich_list_data
    |> Map.put(:block_number, block_no)
  end
end
