###
# This class is responsible for providing game functionality
# to the main program 'War'
###

class Game
    require_relative 'player'
    require_relative 'deck'

    def initialize(numPlayers)
        # Holds current number of players in the game
        @numPlayers = numPlayers
        # Game deck - holds ALL cards
        @deck = Deck.new()
        # Array of players in the game. Determined by user @ beginning of the game.
        @players = Array.new(numPlayers)
        for index in 0..@players.length-1
           @players[index] = Player.new("player#{index+1}")
        end
    end

    # Shuffle game deck
    def shuffleDeck()
        @deck.shuffle()
    end

    # Distribute cards to all players
    def distributeCards()
        i = 0
        52.times do |j|
            card = @deck.removeTopCard()
            @players[i].addCardToHand(card)
            i += 1
            if i == @numPlayers
                i = 0
            end
        end
    end

    # Method responsible for playing an entire turn of 'game of war'
    def playTurn()
        puts "*** START OF ROUND ***"
        # Holds cards in current battle to be compared
        cardsInPlay = []
        # Holds ALL cards from the round to go to the winner
        cardsForWinner = []
        # Each player flips over the top card of their deck
        puts "Cards played this battle:"
        @players.each do |player|
            card = player.playCard()
            # If a card cannot be played, the player is removed and the game continues
            # with the next player
            if !card
                self.checkForLosers()
                next
            else
                puts "#{player.name} has played card: "
                card.displayCard()
            end

            cardsInPlay << card
            cardsForWinner << card
            card.setLastPlayed(player)
        end

        largest = self.findLargest(cardsInPlay)
        winningCard = largest

        # Determine if a war has to take place otherwise select winner of round
        war = self.checkForDup(largest, cardsInPlay)
        warSpoilsHash = {}
        if war
            puts "WARRRRRRRRR!!!!!!!!"
            warSpoilsHash = invokeWar(cardsForWinner)
            if warSpoilsHash
                winningCard = warSpoilsHash["winningCard"]
                cardsForWinner = warSpoilsHash["spoils"]
            else
                # If war returns false, game is over
                return
            end
        end
        
        # Determine winner of round based on the last player who played the winner card
        winner = nil
        @players.each do |player|
            if winningCard.getLastPlayedBy.eql?(player.name())
                winner = player
                break
            end
        end
        
        puts "#{winner.name()} has won the round with card: "
        winningCard.displayCard()
        # Pass them their winnings
        puts "TOTAL AMOUNT OF CARDS WON AFTER ROUND: #{cardsForWinner.length}"
        winner.addCardsToHand(cardsForWinner)
        
        puts "SCOREBOARD:"
        self.displayScore()

        puts "***END OF ROUND***"
        puts
    end

    # Method responsible for the functionality of a war
    # Params:
    #   winnersCards - Cards won in the round so far
    # Returns:
    #   winnings - results of the war in a hash
    #   False - if the game is over
    def invokeWar(winnersCards)
        # Holds cards in current battle (resets each war)
        cardsInPlay = []
        repeat = true
        round = 1
        puts "Cards played this war:"
        while repeat == true do
            puts "*** WAR ROUND #{round} ***"
            # Each player flips over the top card of their deck
            @players.each do |player|
                burnCard = player.playCard()
                # If a card can't be played, remove that player and continue on
                if !burnCard
                    self.checkForLosers()
                    # If the game is over, the war is over
                    if @numPlayers == 1
                        return false
                    end
                    next
                end

                card = player.playCard()
                if !card
                    # Need to make sure and add burn card 
                    # to spoils if we lose a player
                    winnersCards << burnCard
                    self.checkForLosers()
                    # If the game is over, the war is over
                    if @numPlayers == 1
                        return false
                    end
                    next
                else
                    puts "#{player.name} has played card: "
                    card.displayCard()
                end
                # Add card to game's version of the played cards
                cardsInPlay << card
                # Add card to "spoils"
                winnersCards << card
                winnersCards << burnCard
                # Add card played to player's cards played list
                card.setLastPlayed(player)
                burnCard.setLastPlayed(player)
            end

            largest = self.findLargest(cardsInPlay)

            # Determine if another battle has to take place
            war = self.checkForDup(largest, cardsInPlay)
            if war
                repeat = true
                # Clear our "InPlay" lists if we have to go for another round
                cardsInPlay.clear()
                round += 1
            else
                repeat = false
            end
        end

        winnings = { "winningCard" => largest,
                     "spoils" => winnersCards,
                   }
        puts "***END OF WAR***"
        puts
        return winnings
    end

    # Provides whether your largest is tied with any cards within cards
    # Returns:
    #   true/false - if largest has a dup in cards
    def checkForDup(largest, cards)
        cards.each do |card|
            if (card.getValue == largest.getValue &&
               (!card.getSuit.eql?(largest.getSuit)))
                return true
            end
        end
        return false
    end

    # Checks for losers and removes them from the game
    # Returns:
    #   true/false - true if a player was removed, false otherwise
    def checkForLosers()
        @players.each do |player|
            # Remove players with no cards left from the game
            if player.handLength() == 0
                puts "#{player.name} lost and has been removed from the game"
                puts
                removePlayer(player)
                return true
            end
        end
        return false
    end

    # Returns true/false based on if we have a winner or not in our game
    # Returns:
    #   true - if 1 or 0 players are left in the game, the game is over
    #   false - if we have 2 or more players
    def checkForWinner()
        if @numPlayers == 1
            puts "#{@players[0].name} is the winner!!"
            return true
        elsif @numPlayers == 0
            puts "It seems we have a tie!"
            return true
        else
            return false
        end
    end

    # Remove player from the game and decrement the number of players
    def removePlayer(to_remove)
        # Search for this player and remove them from the game list
        @players.delete(to_remove)
        @numPlayers -= 1
    end
    
    def displayScore()
        @players.each do |player|
            player.displayScore()
        end
    end

    # Takes an array of cards and returns the card with the largest value
    # Params:
    # cards - Array of cards
    #
    # Returns:
    # largest - card with the largest value
    def findLargest(cards)
        largest = cards[0]
        stop = cards.length-1
        (0..stop).each do |k|
            if largest.getValue < cards[k].getValue
                largest = cards[k]
            end
        end
        return largest
    end
    
    # This method is used for testing purposes
    def numOfPlayers()
        return @numPlayers
    end

    # This method is used for testing purposes
    def getPlayers()
        return @players
    end
    
    # Debugging/test method
    def displayPlayers()
        @players.each do |player|
            player.displayPlayer()
            player.displayHand()
        end
    end

    # Debugging/test method
    def displayDeckOfCards()
        @deck.displayDeck()
    end
end
