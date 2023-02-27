defmodule ValidationError do
  defexception message: "Sentence is invalid"
end

defmodule Alex do
  def sentence(lexicons) do
    try do
      lexicons
        |> noun_phrase
        |> verb_phrase
        |> trace_result
    rescue
      value ->
        IO.puts("Caught #{inspect(value)}")
        false
    end
  end

  def first_of_all([fun]) do
    fun.()
  end

  def first_of_all([fun | next]) do
    first_of_all(fun, next)
  end

  def first_of_all(fun, next) do
    try do
      fun.()
    rescue
      e ->
        IO.puts("Caught #{inspect(e)}")
        first_of_all(next)
    end
  end

  def trace_result(false), do: false
  def trace_result([_]), do: false
  def trace_result([]), do: true

  def check(false), do: raise ValidationError
  def check(result), do: result

  def noun_phrase(lexicons) do
    lexicons
      |> det
      |> noun
  end

  def verb_phrase(lexicons) do
    first_of_all([
      fn () -> lexicons
        |> transitive_verb
        |> noun_phrase
      end,
      fn () ->
        lexicons |> intransitive_verb
      end
    ])
  end

  def det([value | rest]), do: lex_lookup(value, :det, rest)

  def noun([value | rest]), do: lex_lookup(value, :noun, rest)

  def intransitive_verb([value | rest]), do: lex_lookup(value, :intransitive_verb, rest)

  def transitive_verb([value | rest]), do: lex_lookup(value, :transitive_verb, rest)

  def lex_lookup(value, :det, rest) when value === "the", do: rest
  def lex_lookup(value, :det, rest) when value === "a", do: rest
  def lex_lookup(value, :noun, rest) when value === "John", do: rest
  def lex_lookup(value, :noun, rest) when value === "car", do: rest
  def lex_lookup(value, :transitive_verb, rest) when value === "drives", do: rest
  def lex_lookup(value, :transitive_verb, rest) when value === "to", do: rest

  def lex_lookup(_value, _, rest), do: rest
end
