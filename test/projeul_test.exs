defmodule ProjectEulerTest do
  use ExUnit.Case

  test "Problem 2" do
    assert 4613732 == FibStream.new 
                        |> Stream.take_while(&(&1 <= 4000000))
                        |> Stream.filter(&(rem(&1,2) == 0)) 
                        |> Enum.sum

  end

  test "Problem 3" do
    number = 600851475143
    start = round(:math.sqrt(number))
    assert 6857 == Primes.stream(start, true) 
                        |> Stream.filter(&(rem(number, &1) == 0)) 
                        |> Enum.take(1)
                        |> hd
  end

  test "Problem 15" do
    n = 20
    assert 137846528820 == [1,1] 
                              |> P15.expand(1, n) 
                              |> P15.shrink
                              |> hd
  end

  test "Problem 16" do
    p = 1000
    assert 1366 == P16.pow(2,p) |> P16.sdigs(0)
  end

end