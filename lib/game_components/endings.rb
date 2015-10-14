module GameComponents

  module Endings

    attr_accessor :ending_text

    def dead_ending
      @ending_text = File.read(
        File.join(
          File.join(
            File.dirname(__FILE__),
            '..', '..',
            'declarations',
            'you_died.txt'
          )
        )
      )
      @ended = true
    end

    def win_ending
      @ending_text = File.read(
        File.join(
          File.join(
            File.dirname(__FILE__),
            '..', '..',
            'declarations',
            'you_won.txt'
          )
        )
      )
      @ended = true
    end

    def lose_ending(winner)
      @ending_text = File.read(
        File.join(
          File.join(
            File.dirname(__FILE__),
            '..', '..',
            'declarations',
            'you_lost.txt'
          )
        )
      )
      @ending_text << "\n The winner was as #{winner.class}\n\n"
      @ended = true
    end

  end

end