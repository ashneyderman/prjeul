defmodule FibStream do

    defp start, do:  0

    defp next(0), do: {[0], {0,1}}
    defp next({n0, n1}), do: {[n0+n1], {n1,n0+n1}}

    def new, do: Stream.resource( &start/0, &next/1, &(&1) )
  
end