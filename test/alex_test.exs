defmodule AlexTest do
  use ExUnit.Case
  doctest Alex

  test "should be valid" do
    assert Alex.sentence(["the", "John", "drives", "a", "car"]) ==
             {true,
              {{:noun_phrase, {{:det, "the"}, {:noun, "John"}}},
               {:verb_phrase,
                {{:transitive_verb, "drives"}, {:noun_phrase, {{:det, "a"}, {:noun, "car"}}}}}}}

    assert Alex.sentence(["the", "John", "drives"]) ==
             {true,
              {{:noun_phrase, {{:det, "the"}, {:noun, "John"}}},
               {:verb_phrase, {:intransitive_verb, "drives"}}}}
  end

  test "should be invalid" do
    # assert Alex.sentence(["drives", "John"]) == false
  end
end
