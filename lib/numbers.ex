defmodule Numbers do

  def fib_stream, 
    do: Stream.resource(&zero/0, &next_fib/1, &noop/1)

  def by_3_and_5_stream,
    do: Stream.resource(&zero/0, &next_by_3_and_5/1, &noop/1)  

  defp zero, do:  0
  defp noop(x), do: x

  defp next_fib(0), do: {[0], {0,1}}
  defp next_fib({n0, n1}), do: {[n0+n1], {n1,n0+n1}}

  defp next_divisible(x, n), do: next_divisible(x,n,n)

  defp next_divisible(x, [], n), do: next_divisible(x+1,n,n)
  defp next_divisible(x, [d|_], _) when rem(x,d) == 0, do: x
  defp next_divisible(x, [_|t], n), do: next_divisible(x,t,n)

  defp next_by_3_and_5(x) do
    n = next_divisible(x,[3,5])
    {[n], n+1}
  end

end