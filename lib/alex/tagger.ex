defmodule Alex.Tagger do
  def det(value), do: {:det, value}

  def noun(value), do: {:noun, value}

  def intransitive_verb(value), do: {:intransitive_verb, value}

  def transitive_verb(value), do: {:transitive_verb, value}

  def verb_phrase(value), do: {:verb_phrase, value}

  def noun_phrase(value), do: {:noun_phrase, value}
end
