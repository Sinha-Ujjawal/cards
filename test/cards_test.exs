defmodule CardsTest do
  use ExUnit.Case
  doctest Cards

  test "create_deck makes a standard deck of cards" do
    assert Cards.create_deck() == [
             {:ace, :diamond},
             {2, :diamond},
             {3, :diamond},
             {4, :diamond},
             {5, :diamond},
             {6, :diamond},
             {7, :diamond},
             {8, :diamond},
             {9, :diamond},
             {10, :diamond},
             {:jack, :diamond},
             {:queen, :diamond},
             {:king, :diamond},
             {:ace, :spades},
             {2, :spades},
             {3, :spades},
             {4, :spades},
             {5, :spades},
             {6, :spades},
             {7, :spades},
             {8, :spades},
             {9, :spades},
             {10, :spades},
             {:jack, :spades},
             {:queen, :spades},
             {:king, :spades},
             {:ace, :heart},
             {2, :heart},
             {3, :heart},
             {4, :heart},
             {5, :heart},
             {6, :heart},
             {7, :heart},
             {8, :heart},
             {9, :heart},
             {10, :heart},
             {:jack, :heart},
             {:queen, :heart},
             {:king, :heart},
             {:ace, :clubs},
             {2, :clubs},
             {3, :clubs},
             {4, :clubs},
             {5, :clubs},
             {6, :clubs},
             {7, :clubs},
             {8, :clubs},
             {9, :clubs},
             {10, :clubs},
             {:jack, :clubs},
             {:queen, :clubs},
             {:king, :clubs},
             {:joker, :joker}
           ]
  end

  test "shuffling the deck randomizes the deck" do
    deck = Cards.create_deck()
    shuffled_deck = Cards.shuffle(deck)
    assert deck != shuffled_deck and MapSet.new(deck) == MapSet.new(shuffled_deck)
  end

  test "deadling deck with hand_size = 1" do
    deck = Cards.create_deck()
    {hand, _} = Cards.deal(deck, 1)
    assert hand == [{:ace, :diamond}]
  end

  test "deadling deck with hand_size = 3" do
    deck = Cards.create_deck()
    {hand, _} = Cards.deal(deck, 3)
    assert hand == [{:ace, :diamond}, {2, :diamond}, {3, :diamond}]
  end

  test "saving the deck to persistent storage" do
    filepath = "test_deck"
    deck = Cards.create_deck()
    Cards.save(deck, filepath)
    File.rm!(filepath)
  end

  test "saving the deck to persistent storage, and then loading it" do
    filepath = "test_deck"
    deck = Cards.create_deck()
    Cards.save(deck, filepath)
    assert deck == Cards.load(filepath)
    File.rm!(filepath)
  end
end
