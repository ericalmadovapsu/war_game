##
###
# This is the game of war
###
##

require_relative 'Game'

print "How many players (2-4)? "
numOfPlayers = gets.to_i

# Fast or slow modes????

gameOfWar = Game.new(numOfPlayers) 

#puts "Today's warmongerers are: "

# Shuffle the deck and distribute cards to each player's hand
gameOfWar.shuffleDeck()
gameOfWar.distributeCards()

# Simulating turns here
# retrieve winner
winner = false
while !winner do
    gameOfWar.playTurn()
    # Remove losers from the game
    gameOfWar.checkForLosers()
    # Check if we have a winner
    winner = gameOfWar.checkForWinner()
#    sleep(4)
end 
