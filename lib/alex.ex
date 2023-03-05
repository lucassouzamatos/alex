defmodule Alex do
  alias Alex.Dcg

  def sentence(lexicons) do
    Dcg.En.sentence(lexicons)
  end
end
