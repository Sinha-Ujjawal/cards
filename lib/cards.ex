defmodule Cards do
  @moduledoc """
    Provides methods for creating and handling of standard deck of cards
  """

  @typedoc """
    Rank of the card, any one of the following values-
      [:ace, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, :jack, :queen, :king]
  """
  @type rank :: atom() | integer()

  @typedoc """
    Suit of the card, any one of the following values-
      [:diamond, :spades, :heart, :clubs]
  """
  @type suit :: atom()

  @typedoc """
    Tuple of `rank` and `suit` representing a card, or it could be the special joker card
  """
  @type card :: {rank(), suit()} | {:joker, :joker}

  @typedoc """
    List of cards representing a deck
  """
  @type deck :: list(card())

  @doc """
    Returns a standard deck of cards
  """
  @spec create_deck() :: deck()
  def create_deck do
    suits = [:diamond, :spades, :heart, :clubs]
    ranks = [:ace] ++ Enum.to_list(2..10) ++ [:jack, :queen, :king]
    joker = {:joker, :joker}

    for suit <- suits,
        rank <- ranks do
      {rank, suit}
    end ++ [joker]
  end

  @doc """
    Returns shuffled deck of cards
  """
  @spec shuffle(deck()) :: deck()
  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
    Returns true if the given card is present in the deck, else false
  """
  @spec contains?(deck(), card()) :: boolean()
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
    Splits the deck into a hand and the remainder of the deck.
    The `hand_size` argument represents how many cards are there in the card.

    ## Examples

        iex> deck = Cards.create_deck
        iex> {hand, _} = Cards.deal(deck, 1)
        iex> hand
        [ace: :diamond]
        iex> {hand, _} = Cards.deal(deck, 2)
        iex> hand
        [{:ace, :diamond}, {2, :diamond}]
  """
  @spec deal(deck(), non_neg_integer()) :: {deck(), deck()}
  def deal(deck, hand_size) when hand_size >= 0 and hand_size <= length(deck) do
    Enum.split(deck, hand_size)
  end

  @doc """
    Saves the given deck to the persistent storage
  """
  @spec save(deck(), charlist()) :: :ok
  def save(deck, filepath) do
    binary = :erlang.term_to_binary(deck)
    File.write!(filepath, binary)
  end

  @doc """
    Loads deck from the persistent storage
  """
  @spec load(charlist()) :: :ok
  def load(filepath) do
    binary = File.read!(filepath)
    :erlang.binary_to_term(binary)
  end
end
