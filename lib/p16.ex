defmodule P16 do

  def pow(n, p), do: do_pow(n, p, 1)
  def do_pow(_n, 0, acc), do: acc
  def do_pow(n, p, acc), do: do_pow(n, p - 1, acc * n)

  def sdigs(0, a), do: a
  def sdigs(n, a) do
    d = n |> rem(10)
    sdigs((n - d |> div(10)), a + d)
  end

end