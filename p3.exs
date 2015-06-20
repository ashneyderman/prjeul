#!/usr/bin/env elixir

Code.require_file "lib/eux.ex"
Code.require_file "lib/primes.ex"

defmodule P3 do

  def print(r,number) do
    IO.puts "Largest prime factor for #{number} is #{r}"
  end

  def usage(_argv,errors) do
    IO.puts """
p3.exs: invalid option(s) -- #{Keyword.keys(errors)}
usage: p3.exs [-n <number>]

       -n, --number  number whose largest prime factor we are looking for 
                     default is 600851475143
    """
    System.halt
  end

end

{params, _args} = Eux.params System.argv,  strict: [number: :integer],
                                          aliases: [n:      :number],
                                            usage: {P3, :usage}

number = params |> Keyword.get(:number, 600851475143)
start = round(:math.sqrt(number))

Primes.stream(start, true) 
  |> Stream.filter(&(rem(number, &1) == 0)) 
  |> Enum.take(1)
  |> hd
  |> P3.print(number)
