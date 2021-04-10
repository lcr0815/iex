defmodule CardsTest do
  use ExUnit.Case
  doctest Cards

  test "create_deck makes 20 cards" do
    deck_length = length(Cards.create_deck)
    assert deck_length == 52
  end

  test "show the cards " do
    assert Cards.create_deck() == Cards.create_deck()
  end

#  test "shuffle the cards " do
#    assert Cards.shuffle(1) == 'will show the deck here'
#  end

end
