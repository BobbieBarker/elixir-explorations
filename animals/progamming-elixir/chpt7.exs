
defmodule Utility do
  def reduce([], value, _fun) do
    value
  end

  def reduce([head | tail ], value, fun) do
    reduce(tail, fun.(head, value), fun)
  end

  def map([], _func) do
    []
  end

  def map([head | tail ], func) do
    [func.(head) | map(tail, func)]
  end

  def filter([], _func) do
    []
  end

  def filter([head | tail], func) do
    if func.(head) do
      [head | filter(tail, func)]
    else
      filter(tail, func)
    end
  end

  def all?([], _func) do
    true
  end

  def all?([head | tail], func) do
    if func.(head), do: all?(tail, func), else: false
  end

  def split(list, n) when n >= 0, do: _split(list, n, [])
  def split(list, n) when n < 0, do: _split(list, n + length(list), [])
  defp _split([head | tail], n, result) when length(result) < n do
    _split(tail, n, result ++ [head])
  end
  defp _split(list, _n, result), do: { result, list }

  def flatten([]), do: []
  def flatten([head | tail]) when is_list(head), do: flatten(head) ++ flatten(tail)
  def flatten([head | tail]) when not is_list(head), do: [head] ++ flatten(tail)


  # def take() do

  # end
end

defmodule MyList do
  def mapsum(list, func) do
    Utility.map(list, func)
    |> Utility.reduce(0, &(&1 + &2))
  end

  def max(list) do
    comparator = fn
      a, highwater when a > highwater -> a
      a, highwater when a < highwater -> highwater
    end

    Utility.reduce(list, 0, comparator)
  end

  def ceasar(list, n) do
    cipher = fn
      val when val + n < 122 -> val + n
      val -> '?'
    end

    Utility.map(list, cipher)
    |> to_string
  end

  def span(from, to) when from > to, do: []

  def span(from, to) do
    from..to
    |> Enum.to_list
  end
end


tax_rates = [NC: 0.075, TX: 0.08]
orders = [
  [id: 123, ship_to: :NC, net_amount: 100.00],
  [id: 124, ship_to: :OK, net_amount:  35.50],
  [id: 125, ship_to: :TX, net_amount:  24.00],
  [id: 126, ship_to: :TX, net_amount:  44.80],
  [id: 127, ship_to: :NC, net_amount:  25.00],
  [id: 128, ship_to: :MA, net_amount:  10.00],
  [id: 129, ship_to: :CA, net_amount: 102.00],
  [id: 130, ship_to: :NC, net_amount:  50.00],
]

defmodule SalesTax do
  def calcTax(amount, rate) do
    amount + amount * rate
  end
  def applyTax(order, tax_rates) do
    case order do
      [_id, {:ship_to, :NC}, _net_amount] -> [total_amount: calcTax(order[:net_amount], tax_rates[:NC])] ++ order
      [_id, {:ship_to, :TX}, _net_amount] -> [total_amount: calcTax(order[:net_amount], tax_rates[:TX])] ++ order
      _ -> [total_amount: order[:net_amount]] ++ order
    end
  end

  def charge(orders, tax_rates) do
    for order <- orders, do: applyTax(order, tax_rates)
  end
end

IO.inspect SalesTax.charge(orders, tax_rates)
