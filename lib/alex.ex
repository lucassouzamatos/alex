defmodule ValidationError do
  defexception message: "Sentence is invalid"
end

defmodule Alex do
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
    {step1, tree_item_1} = det(lexicons)
    {step2, tree_item_2} = noun(step1)

    {step2, {:noun_phrase, {tree_item_1, tree_item_2}}}
  end

  def verb_phrase(lexicons) do
    first_of_all([
      fn ->
        {step1, tree_item_1} = transitive_verb(lexicons)
        {step2, tree_item_2} = noun_phrase(step1)

        {step2, {:verb_phrase, {tree_item_1, tree_item_2}}}
      end,
      fn ->
        {step1, tree_item_1} = intransitive_verb(lexicons)
        {step1, {:verb_phrase, tree_item_1}}
      end
    ])
  end

  def det([value | rest]), do: {rest, {:det, value}}

  def noun([value | rest]), do: {rest, {:noun, value}}

  def intransitive_verb([value | rest]), do: {rest, {:intransitive_verb, value}}

  def transitive_verb([value | rest]), do: {rest, {:transitive_verb, value}}
end
