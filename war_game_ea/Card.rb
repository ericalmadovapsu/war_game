###
# This class represents a card.
###

class Card
    # Every card has a value (2-14) and a suit (Hearts, Diamonds, Spades, Clovers)
    def initialize(value, suit)
        @value = value
        @suit = suit
        @lastPlayedBy = nil
    end

    # Prints a card to the screen
    def displayCard()
        puts "  Value: #{@value}"
        puts "  Suit: #{@suit}"
    end

    # Sets last player to play this card
    def setLastPlayed(player)
        @lastPlayedBy = player
    end

    def getLastPlayedBy()
        return @lastPlayedBy.name
    end

    def getValue()
        return @value
    end

    def getSuit()
        return @suit
    end
end
