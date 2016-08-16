###
# This class represents a player in the game of war. Each player has a hand and a cards played list.
# Each game has 2-4 players and the amount of players per game is decided at the beginning of the game.
###

class Player
    # Every player is given a name: "player(2-4)"
    def initialize(player_name)
        @name = player_name
        @hand = []
    end

    # Print a player to the screen
    def displayPlayer()
        puts "*** Player Info ***"
        puts "Name: #{@name}"
        puts
    end

    def displayScore()
        puts "#{name} has #{@hand.length} cards in their deck"
    end

    # Return the top card from a player's hand
    # Returns:
    #   topCard - top card of deck
    def playCard()
        if (@hand.length == 0)
            puts "#{@name} RAN OUT OF CARDS"
            return false
        end
        topCard = @hand.shift
        return topCard
    end

    # Add card back to the top of player's deck
    # Params:
    #   card - card to be rolled back
    def rollbackCard(card)
        @hand.unshift(card)
    end

    # Adds a card to the end of the players hand
    # Params:
    #   card - card to be added
    def addCardToHand(card)
        @hand << card
    end

    # Adds cards to the end of the players hand
    # Params:
    #   cards - cards to be added
    def addCardsToHand(cards)
        @hand.concat(cards)
    end

    # Returns number of cards in players hand
    # Returns:
    #  @hand.length - number of cards in this players hand
    def handLength()
        return @hand.length
    end
  
    # Returns name of player
    # Returns:
    #   @name - name of player
    def name()
        return @name
    end

    # This method is used for testing purposes
    def getHand()
        return @hand
    end
    
    # Debugging method
    def displayHand()
        @hand.each do |card|
            card.displayCard()
        end
    end
end
