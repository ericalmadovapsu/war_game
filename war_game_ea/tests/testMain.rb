###########################################################################
#                                                                         #
# This is the program that will run all of the unit tests for Game of War #
#                                                                         #
###########################################################################

require_relative 'gametests'
require_relative 'playertests'

puts "*** START OF TESTS ***"
puts

puts "Starting tests for the Game of War!"
playertests = PlayerTest.new()
playertests.testAddCardsToHand()
puts
gametests = GameTest.new()
gametests.testRemovePlayer()
(2..4).each do |i|
    gametests.testDistributeCards(i)
end

puts
puts "*** END OF TESTS ***" 
