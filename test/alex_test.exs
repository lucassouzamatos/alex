defmodule AlexTest do
  use ExUnit.Case
  doctest Alex

  test "should be valid" do
    assert Alex.sentence(["the", "John", "drives", "a", "car"]) == true
  end

  test "should be invalid" do
    assert Alex.sentence(["drives", "John"]) == false
  end
end
