defmodule ValidationError do
  defexception message: "Sentence is invalid"
end

defmodule Alex do
  def sentence(lexicons) do
    try do
      lexicons
        |> noun_phrase
        |> check
        |> verb_phrase
        |> trace_result
    rescue
      _ in ValidationError -> false
      e -> e
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
      |> check
      |> noun
  end

  def verb_phrase(lexicons) do
    lexicons
      |> intransitive_verb

    or

    lexicons
      |> transitive_verb
      |> check
      |> noun_phrase
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

  def lex_lookup(_value, _, _rest), do: false
end
