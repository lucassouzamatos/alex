defmodule Alex.Dcg.En do
  @behaviour Alex.Dcg.Grammar

  alias Alex.Tagger
  alias Alex.Utils

  def sentence(lexicons) do
    try do
      {step1, np} = noun_phrase(lexicons)
      {step2, vp} = verb_phrase(step1)

      tree = {:sentence, {np, vp}}

      trace_result(step2, tree)
    rescue
      value ->
        IO.puts("Caught #{inspect(value)}")
        false
    end
  end

  def trace_result(false, tree), do: {false, tree}
  def trace_result([_], tree), do: {false, tree}
  def trace_result([], tree), do: {true, tree}

  def noun_phrase(lexicons) do
    Utils.first_of_all([
      fn ->
        {step1, det} = det(lexicons)
        {step2, noun} = noun(step1)

        {step2, Tagger.noun_phrase({det, noun})}
      end,
      fn ->
        {step2, n} = noun(lexicons)
        {step2, Tagger.noun_phrase({n})}
      end
    ])
  end

  def verb_phrase(lexicons) do
    Utils.first_of_all([
      fn ->
        {step1, tv} = transitive_verb(lexicons)
        {step2, np} = noun_phrase(step1)

        {step2, Tagger.verb_phrase({tv, np})}
      end,
      fn ->
        {step1, iv} = intransitive_verb(lexicons)
        {step1, Tagger.verb_phrase(iv)}
      end
    ])
  end

  def det([value | rest]), do: {rest, Tagger.det(value)}

  def noun([value | rest]), do: {rest, Tagger.noun(value)}

  def intransitive_verb([value | rest]), do: {rest, Tagger.intransitive_verb(value)}

  def transitive_verb([value | rest]), do: {rest, Tagger.transitive_verb(value)}
end
