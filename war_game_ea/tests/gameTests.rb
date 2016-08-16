class GameTest

    require_relative '../game'
    require_relative '../player'

    def initialize
        puts "Starting game mechanism tests..."
    end

    def testRemovePlayer()
        puts "TEST: Remove players"
        # Start a 2 player game
        game = Game.new(2)
        result = true

        if game.numOfPlayers() != 2
            result = false
        end

        players = game.getPlayers()

        game.removePlayer(players[0])

        if game.numOfPlayers() != 1
            result = false
        end

        if result == true
            puts "  PASSED"
        else
            puts "  FAILED"
        end
    end

    def testDistributeCards(playerCount)
        puts "TEST: Distribute Cards - #{playerCount} Player"
        game = Game.new(playerCount)

        result = true
        if game.numOfPlayers() != playerCount
            result = false
        end

        players = game.getPlayers()

        game.distributeCards()

        players.each do |player|
            size = (52/playerCount).floor
            # 3 player games give out hands of 17, 17 & 18 currently
            if (playerCount == 3 && player.handLength() == 18)
                next
            end
            if player.handLength() != size
                result = false
            end
        end

        if result == true
            puts "  PASSED"
        else
            puts "  FAILED - distribute cards"
        end
    end
end
