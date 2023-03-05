defmodule Alex.Dcg.Grammar do
  @type result :: {
          boolean(),
          # @todo: create type to tree structure
          any()
        }

  @callback sentence(lexicons :: list(String.t())) :: result()
end
