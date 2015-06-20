defmodule Eux do

  def params(argv, spec) do
    {usage_mod, usage_fn} = case (spec |> Keyword.get(:usage)) do
                              nil   -> {__MODULE__, :usage}
                              {m,f} -> {m,f}
                            end
    spec = spec |> Keyword.delete(:usage)
    case OptionParser.parse(argv, spec) do
      {p, a, []} -> 
        {p, a}
      {_p, _a, e} ->
        apply(usage_mod,usage_fn,[argv,e])
    end
  end

  def usage(_argv, e) do
    IO.puts "Unrecognized params: #{inspect e}"
  end

end
