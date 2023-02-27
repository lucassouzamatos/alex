defmodule Alex do
  alias Alex.Tagger

  def sentence(lexicons) do
    try do
      {step1, tree_item_1} = noun_phrase(lexicons)
      {step2, tree_item_2} = verb_phrase(step1)

      trace_result(step2, {tree_item_1, tree_item_2})
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

  def trace_result(false, tree), do: {false, tree}
  def trace_result([_], tree), do: {false, tree}
  def trace_result([], tree), do: {true, tree}

  def noun_phrase(lexicons) do
    first_of_all([
      fn ->
        {step1, tree_item_1} = Tagger.det(lexicons)
        {step2, tree_item_2} = Tagger.noun(step1)

        {step2, {:noun_phrase, {tree_item_1, tree_item_2}}}
      end,
      fn ->
        {step2, tree_item_2} = Tagger.noun(lexicons)
        {step2, {:noun_phrase, {tree_item_2}}}
      end
    ])
  end

  def verb_phrase(lexicons) do
    first_of_all([
      fn ->
        {step1, tree_item_1} = Tagger.transitive_verb(lexicons)
        {step2, tree_item_2} = noun_phrase(step1)

        {step2, {:verb_phrase, {tree_item_1, tree_item_2}}}
      end,
      fn ->
        {step1, tree_item_1} = Tagger.intransitive_verb(lexicons)
        {step1, {:verb_phrase, tree_item_1}}
      end
    ])
  end
end
