#!/usr/bin/env elixir

Code.require_file "lib/eux.ex"

defmodule P16 do

  def pow(n, p), do: do_pow(n, p, 1)
  def do_pow(_n, 0, acc), do: acc
  def do_pow(n, p, acc), do: do_pow(n, p - 1, acc * n)

  def sdigs(0, a), do: a
  def sdigs(n, a) do
    d = n |> rem(10)
    sdigs((n - d |> div(10)), a + d)
  end

  def print(r,p) do
    IO.puts "Sum of digits for 2 of power #{p}: #{r}"
  end

  def usage(_argv,errors) do
    IO.puts """
p16.exs: invalid option(s) -- #{Keyword.keys(errors)}
usage: p16.exs [-p <power>]

       -p, --power  power of 2 (default 1000)
    """
    System.halt
  end

end

{params, _args} = Eux.params System.argv,  strict: [power: :integer],
                                          aliases: [p: :power],
                                            usage: {P16,:usage}

p = params |> Keyword.get(:power, 1000)
P16.pow(2,p) |> P16.sdigs(0) |> P16.print(p)