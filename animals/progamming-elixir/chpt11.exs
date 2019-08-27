defmodule MyWordUtils do
  def capitalize_sentences(text), do: capitalize_sentences(String.split(text, ". "), "")

  defp capitalize_sentences([sentence | []], result) do # last element of split should not have ". "should not have ". "
      capitalize_sentences([], "#{result}#{sentence}")
  end
  defp capitalize_sentences([sentence | tail], result) do
      capitalize_sentences(tail, "#{result}#{String.capitalize(sentence)}. ")
  end
  defp capitalize_sentences([], result), do: IO.puts result
end

defmodule SalesTax do
  def charge(orders, tax_rates) do
    Enum.map(orders, fn order ->
      order_tax_rates = tax_rates[order[:ship_to]]
      total_amount = add_tax(order[:net_amount], order_tax_rates)

      [{:total_amount, total_amount} | order]
    end)
  end

  def add_tax(net_amount, nil), do: net_amount
  def add_tax(net_amount, rate), do: (rate + 1) * net_amount
end



defmodule TaxProcessor do
  import SalesTax
  def process(file_name) do
    File.read!(file_name)
    |> format_orders
    |> SalesTax.charge([NC: 0.075, TX: 0.08])
  end

  defp format_orders(orders) do
    [head | tail] = String.split(orders, "\n", trim: true)

    headers = process_headers(head)

    Enum.map(tail, fn row ->
      Enum.zip(headers, build_row(row))
    end)

  end

  defp process_headers(data) do
    String.split(data, ",")
    |> Enum.map(&(String.to_atom(&1)))
  end

  defp build_row(row) do
    String.split(row, ",")
    |> Enum.map(&(process_value(&1)))
  end

  defp process_value(str) do
    case Float.parse(str) do
      {num, _} -> num
      :error   -> String.to_atom(String.lstrip(str, ?:))
    end
  end
end

