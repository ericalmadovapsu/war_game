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
end
