class PlayerTest
    require_relative '../player'
    require_relative '../card'

    def initialize
        puts "Starting player tests..."
    end

    def initCards(size)
        cards = []
        (0..size-1).each do |i|
            cards << Card.new(i, i.to_s)
        end
        return cards
    end

    def testAddCardsToHand()
        puts "TEST: Add cards to hand"
        cards = self.initCards(2)
        person = Player.new("John")
        person.addCardsToHand(cards)
        len = person.handLength()

        if len == 2
            puts "  PASSED"
        else
            puts "  FAILED - len test"
        end
    end

    def testPlayCard()
        puts "TEST: Play Card"
        person = Player.new("Player1")
        result = person.playCard()
        if result == false
            puts "  PASSED"
        else
            puts "  FAILED - play card test"
        end

        cards = self.initCards(5)
        person.addCardsToHand(cards)
        result = person.playCard()
        len = person.handLength()
        if len == 4
            puts "  PASSED"
        else
            puts "  FAILED"
        end

        if result != false
            puts "  PASSED"
        else
            puts "  FAILED"
        end
    end
end
