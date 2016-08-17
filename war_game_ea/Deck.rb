###
# This class represents a traditional, standard deck of 52 american playing cards
###


class Deck
    require_relative 'card'

    # Constants that represent face card values
    A = 14
    K = 13
    Q = 12
    J = 11

    # Initialize to a 52 traditional standard card deck
    def initialize()
        @deck = []
        # Spades
        @deck << Card.new(A, "Spades")
        @deck << Card.new(K, "Spades")
        @deck << Card.new(Q, "Spades")
        @deck << Card.new(J, "Spades")
        @deck << Card.new(10, "Spades")
        @deck << Card.new(9, "Spades")
        @deck << Card.new(8, "Spades")
        @deck << Card.new(7, "Spades")
        @deck << Card.new(6, "Spades")
        @deck << Card.new(5, "Spades")
        @deck << Card.new(4, "Spades")
        @deck << Card.new(3, "Spades")
        @deck << Card.new(2, "Spades")
        # Diamonds
        @deck << Card.new(A, "Diamonds")
        @deck << Card.new(K, "Diamonds")
        @deck << Card.new(Q, "Diamonds")
        @deck << Card.new(J, "Diamonds")
        @deck << Card.new(10, "Diamonds")
        @deck << Card.new(9, "Diamonds")
        @deck << Card.new(8, "Diamonds")
        @deck << Card.new(7, "Diamonds")
        @deck << Card.new(6, "Diamonds")
        @deck << Card.new(5, "Diamonds")
        @deck << Card.new(4, "Diamonds")
        @deck << Card.new(3, "Diamonds")
        @deck << Card.new(2, "Diamonds")        
        # Clovers
        @deck << Card.new(A, "Clovers")
        @deck << Card.new(K, "Clovers")
        @deck << Card.new(Q, "Clovers")
        @deck << Card.new(J, "Clovers")
        @deck << Card.new(10, "Clovers")
        @deck << Card.new(9, "Clovers")
        @deck << Card.new(8, "Clovers")
        @deck << Card.new(7, "Clovers")
        @deck << Card.new(6, "Clovers")
        @deck << Card.new(5, "Clovers")
        @deck << Card.new(4, "Clovers")
        @deck << Card.new(3, "Clovers")
        @deck << Card.new(2, "Clovers")
        # Hearts        
        @deck << Card.new(A, "Hearts")
        @deck << Card.new(K, "Hearts")
        @deck << Card.new(Q, "Hearts")
        @deck << Card.new(J, "Hearts")
        @deck << Card.new(10, "Hearts")
        @deck << Card.new(9, "Hearts")
        @deck << Card.new(8, "Hearts")
        @deck << Card.new(7, "Hearts")
        @deck << Card.new(6, "Hearts")
        @deck << Card.new(5, "Hearts")
        @deck << Card.new(4, "Hearts")
        @deck << Card.new(3, "Hearts")
        @deck << Card.new(2, "Hearts")
    end

    # Returns the top card of the deck
    # Returns:
    #   card - top card of the deck
    def removeTopCard()
        return @deck.shift
    end

    # Shuffles the deck of cards
    def shuffle()
        @deck.shuffle!
    end
    
    # Debugging method
    def displayDeck()
        @deck.each do |card|
            card.displayCard()
        end
    end
end
