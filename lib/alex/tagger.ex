defmodule Alex.Tagger do
  def det([value | rest]), do: {rest, {:det, value}}

  def noun([value | rest]), do: {rest, {:noun, value}}

  def intransitive_verb([value | rest]), do: {rest, {:intransitive_verb, value}}

  def transitive_verb([value | rest]), do: {rest, {:transitive_verb, value}}
end
