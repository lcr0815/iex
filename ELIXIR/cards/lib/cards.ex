defmodule Cards do

  @moduledoc """
    The Cards module provides methods for creating and handling a deck of playing cards
  """

  @doc """
    Author:   LC\n
    Date:     13-Feb-21\n
    Name:     create_deck\n
    Purpose:  returns a string representing a deck of playing cards
  """
  def create_deck() do
    values =  ["Ace","Two","Three","Four","Five","Six","Seven","Eight","Nine","Ten","Jack","Queen","King"]
    suits = ["Spades","Clubs","Hearts","Diamonds"]

    for suit <- suits, value <- values do
      "#{value} of #{suit}"
    end

  end

  @doc """
    divides a deck into a hand and the remainder of the deck,
    the `hand_size` argument indicates how many cards should be in the hand.

  ## Examples:

        iex> deck = Cards.create_deck
        iex> {hand, _deck} = Cards.deal(deck, 1)
        iex> hand
        ["Ace of Spades"]
        
  """
  def deal(deck, hand_size) do
    #{hand, myDeck} = 
    Enum.split(deck, hand_size)
  end

  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  def load(filename) do
    case File.read(filename) do
      {:ok,     binary} -> :erlang.binary_to_term binary
      {:error, _reason} -> "The file '#{filename}' does not exist"
    end
  end

  def create_hand(hand_size) do
    Cards.create_deck   |>
    Cards.shuffle       |>
    Cards.deal(hand_size)
  end

end
