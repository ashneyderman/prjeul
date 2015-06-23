#!/usr/bin/env elixir

Code.require_file "lib/eux.ex"
Code.require_file "lib/p4.ex"

usage = fn(_argv,errors) ->
    IO.puts """
p4.exs: invalid option(s) -- #{Keyword.keys(errors)}
usage: p4.exs [-n <number>]

       -n, --number  number of digits (default 3)
    """
  System.halt
end

print = fn(r,number) ->
  IO.puts "Largest palindrom of the product of #{number} numbers: #{r}"
end

{params, _args} = Eux.params System.argv,  strict: [number: :integer],
                                          aliases: [n:   :number],
                                            usage: {:function, usage}

number = params |> Keyword.get(:number, 3)

P4.largest_palindrome(number) |> print.(number)
