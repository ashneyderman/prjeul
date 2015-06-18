defmodule P16 do

  def solve(p), do: pow(2,p) |> sdigs(0)
  
  defp pow(n, p), do: do_pow(n, p, 1)
  defp do_pow(n, 0, acc), do: acc
  defp do_pow(n, p, acc), do: do_pow(n, p - 1, acc * n)

  defp sdigs(0, a), do: a
  defp sdigs(n, a) do
    d = n |> rem(10)
    sdigs((n - d |> div(10)), a + d)
  end

end