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

    def testRollback()
        puts "TEST: Rollback"
        cards = self.initCards(2)
        person = Player.new("John")
        person.addCardsToHand(cards)

        cardplayed = person.playCard()
        person.addCardsPlayed(cardplayed)
        initLen = person.handLength()
        if initLen == 1
            puts "  PASSED"
        else
            puts "  FAILED - init length rollback test"
        end

        person.rollbackCard(cardplayed)

        len = person.handLength()
        if len == 2
            puts "  PASSED"
        else
            puts "  FAILED - rollback test"
        end
    end

    def testHasCard()
        puts "TEST: hasCard"
        cards = self.initCards(5)
        person = Player.new("Jimmy")
        person.addCardsToHand(cards)
        person.addManyCardsPlayed(cards)

        testCard = Card.new(4, "4")

        result = person.hasCard(testCard)
        if result == true
            puts "  PASSED"
        else
            puts "  FAILED - hasCard test"
        end
    end

end
