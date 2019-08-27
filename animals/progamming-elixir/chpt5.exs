defmodule Times do
  def double(n) do
    n * 2
  end

  def triple(n) do
    n * 3
  end

  def quadruple(n) do
    double n
    |> double
  end
end


defmodule Summation do
  def sum(1) do
    1
  end
  def sum(n) do
    n + sum(n - 1)
  end
end

defmodule CommonDivisors do
  def gcd(a, 0) do
    a
  end
  def gcd(a, b) do
    gcd(b, (Integer.mod(a, b)))
  end
end

defmodule Chop do
  def middle(min, max) do
    div(min + max, 2)
  end
  def guess(secret, rangeMin..rangeMax) when div(rangeMin + rangeMax, 2) > secret do
    IO.puts "Is it #{middle(rangeMin, rangeMax)}?"
    guess secret, rangeMin..middle(rangeMin, rangeMax)
  end
  def guess(secret, rangeMin..rangeMax) when div(rangeMin + rangeMax, 2) < secret do
    IO.puts "Is it #{middle(rangeMin, rangeMax)}"
    guess secret, middle(rangeMin, rangeMax)..rangeMax
  end
  def guess(secret, rangeMin..rangeMax) do
    IO.puts middle rangeMin, rangeMax
  end
end

defmodule Stuffage do
  import Path, only: [extname: 1]
  def getEnvVar (varname) do
    System.get_env(varname)
  end

  def getFileExtension (path) do
    extname(path)
  end

  def workingDir do
    File.cwd()
  end

  def doCmd do
    System.cmd("echo", ["hello"])
  end

  def stringSTuff (float) do
    :erlang.float_to_binary(float, decimals: 2)
  end
end

