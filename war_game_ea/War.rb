##
###
# This is the game of war
###
##

require_relative 'Game'

print "How many players (2-4)? "
numOfPlayers = gets.to_i

gameOfWar = Game.new(numOfPlayers) 

# Shuffle the deck and distribute cards to each player's hand
gameOfWar.shuffleDeck()
gameOfWar.distributeCards()

# Now we let the game play
winner = false
while !winner do
    gameOfWar.playTurn()
    # Remove losers from the game
    gameOfWar.checkForLosers()
    # Check if we have a winner
    winner = gameOfWar.checkForWinner()
end 
