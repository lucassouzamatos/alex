# Alex

**It is only an experiment. You can't use in production _yet_. It is highly on development.**

Alex will be a toolkit to natural language grammar based on definite clause grammar. The idea is that with logic grammar we can infer the lexicons automatically.

The article [Using a Logic Grammar to Learn a Lexicon](https://aclanthology.org/C88-2111.pdf) is the main reference to this repository.

## Usage

```elixir
iex> Alex.sentence(["the", "John", "drives", "a", "car"])

{:sentence,
  {{:noun_phrase, {{:det, "the"}, {:noun, "John"}}},
  {:verb_phrase,
    {{:transitive_verb, "drives"}, {:noun_phrase, {{:det, "a"}, {:noun, "car"}}}}}}}
```

## Features

- Get grammar tree from a sentence

## Next features

- Should be provided a tokenizer
- Support for other languages
- Automatically learn mechanism
