###
# This class is responsible for providing game functionality
# to the main program 'War'
###

class Game
    require_relative 'player'
    require_relative 'deck'

    def initialize(numPlayers)
        # Important variable - used for determining many things
        @numPlayers = numPlayers
        # Game deck - holds ALL cards
        @deck = Deck.new()
        # Array of players in the game. Determined by user @ beginning of the game.
        @players = Array.new(numPlayers)
        for index in 0..@players.length-1
           @players[index] = Player.new("player#{index+1}")
        end
    end

    def shuffleDeck()
        @deck.shuffle()
    end

    # Distribute cards
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
            # If a card cannot be played, the player loses and the entire turn
            # is rolled back.
            if !card
                self.checkForLosers()
                next
            else
                puts "#{player.name} has played card: "
                card.displayCard()
            end
            # Add card to game's version of the played cards
            cardsInPlay << card
            # Add card to "spoils"
            cardsForWinner << card
            # Add player to card's last pllayed by var
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
                puts "Amount of cards WON from WAR BEFORE THE CONCAT: #{cardsForWinner.length}"
                winningCard = warSpoilsHash["winningCard"]
                cardsForWinner = warSpoilsHash["spoils"]
                puts "Amount of cards won from WAR: #{cardsForWinner.length}"
            else
                # If war returns false, game is over
                return
            end
        end
        
        # TESTING - new determination of winner
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

        self.displayScore()

        # End round
        puts "***END OF ROUND***"
        puts
    end

    # War algorithm
    def invokeWar(winnersCards)
        # Holds cards in current battle
        cardsInPlay = []
        burnCardsInPlay = []
        repeat = true
        round = 1
        puts "Cards played this war:"
        while repeat == true do
            puts "*** WAR ROUND #{round} ***"
            # Each player flips over the top card of their deck
            @players.each do |player|
                burnCard = player.playCard()
                if !burnCard
                    self.checkForLosers()
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

                puts "Total # of winnings so far: #{winnersCards.length}"
            end

            largest = self.findLargest(cardsInPlay)

            # Determine if another battle has to take place
            war = self.checkForDup(largest, cardsInPlay)
            if war
                repeat = true
                # Clear our "InPlay" lists if we have to go for another round
                cardsInPlay.clear()
                burnCardsInPlay.clear()
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

    # Provides whether your largest in tied with any cards within cards
    def checkForDup(largest, cards)
        cards.each do |card|
            if (card.getValue == largest.getValue &&
               (!card.getSuit.eql?(largest.getSuit)))
                return true
            end
        end
        return false
    end

    # Called at the end of the turn
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

    # Remove player from the game
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
