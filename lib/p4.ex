defmodule P4 do

  import String

  def largest_palindrome(n) do
    f = from(n)
    t = to(n)
    (for i <- f..t, j <- f..t , is_palindrome(i*j), do: i * j) |> Enum.max
  end

  def is_palindrome(n), do: (Integer.to_string(n) |> reverse) == Integer.to_string(n)

  def from(n), do: ("1" <> duplicate("0", n-1)) |> to_integer
  def to(n), do: duplicate("9", n) |> to_integer

end