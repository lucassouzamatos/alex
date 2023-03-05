defmodule Alex.Utils do
  def first_of_all([fun]) do
    fun.()
  end

  def first_of_all([fun | next]) do
    first_of_all(fun, next)
  end

  defp first_of_all(fun, next) do
    try do
      fun.()
    rescue
      e ->
        IO.puts("Caught #{inspect(e)}")
        first_of_all(next)
    end
  end
end
