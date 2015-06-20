defmodule Primes do

  @first_100_primes [
   1,   2,   3,   5,   7,  11,  13,  17,  19,  23,  29,  31,  37,  41,  43,  47,  
  53,  59,  61,  67,  71,  73,  79,  83,  89,  97, 101, 103, 107, 109, 113, 127, 
 131, 137, 139, 149, 151, 157, 163, 167, 173, 179, 181, 191, 193, 197, 199, 211, 
 223, 227, 229, 233, 239, 241, 251, 257, 263, 269, 271, 277, 281, 283, 293, 307, 
 311, 313, 317, 331, 337, 347, 349, 353, 359, 367, 373, 379, 383, 389, 397, 401, 
 409, 419, 421, 431, 433, 439, 443, 449, 457, 461, 463, 467, 479, 487, 491, 499, 
 503, 509, 521, 523, 541]

  def stream(max, reverse \\ false) do
    if reverse do
      Stream.resource( start(max+1), &prev/1, noop )
    else
      Stream.resource( start(1), 
        fn(n) when n < max ->
            p = next_prime(n)
            {[p], p}
          (n) -> 
            {:halt, n}
        end, noop )
    end
  end

  def stream, do: Stream.resource( start(1), &next/1, noop )

  defp start(x), do: fn -> x end
  defp noop(), do: fn(x) -> x end

  defp next(n) do
    p = next_prime(n)
    {[p], p}
  end

  defp prev(n) do
    p = prev_prime(n)
    {[p], p}
  end

  def next_prime(n) do
    if is_prime?(n+1),
      do: n+1,
    else: next_prime(n+1)
  end

  def prev_prime(2), do: 2
  def prev_prime(n) do
    if is_prime?(n-1),
      do: n-1,
    else: prev_prime(n-1)
  end

  def is_prime?(n) when n in @first_100_primes, do: true
  def is_prime?(n), do: check_prime?(n, round(:math.sqrt(n)))
  
  defp check_prime?(_number, 1), do: true
  defp check_prime?(number,factor) do
    if rem(number, factor) == 0, 
      do: false,
      else: check_prime?(number,factor-1)
  end
  
end