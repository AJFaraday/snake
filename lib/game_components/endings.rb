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
      restart
    end

    def win_ending
      @player.end_level
      @worms = []
      @ending_count ||= 3
      @ending_text ||= File.read(
        File.join(
          File.join(
            File.dirname(__FILE__),
            '..', '..',
            'declarations',
            'you_won.txt'
          )
        )
      )
      get_score_display
      if @level['next']
        until @ending_count <= 0
          system('clear')
          puts @ending_text
          puts "Next level in: #{@ending_count}"
          puts @score_display
          @ending_count -= 1
          sleep 1
        end
        @ending_count = nil
        @ending_text = nil
        init_level(@level['next'])
      else
        @ended = true
      end
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
      restart
    end

    def restart
      @ending_count = 5
      if @lives > 0
        @lives -= 1
        until @ending_count <= 0
          system('clear')
          puts @ending_text
          puts "Restarting in: #{@ending_count}"
          @ending_count -= 1
          sleep 1
        end
        @ending_count = nil
        @ending_text = nil
        puts 'end'
        init_level(@level.filename)
      else
        @ended = true
      end
    end

    def get_score_display
      width = @field.width
      level_name = @level.filename.split('.')[0]
      player_times = @player.data[:levels][level_name][:times]
      player_times = player_times[0..4].collect { |time|
        time.to_i.to_s.ljust(width / 2)
      }

      board = ScoreBoard.new(level_name)
      puts board.data.inspect
      board_times = board.data[0..4].collect { |datum|
        [
          datum[:player].ljust(width / 4),
          datum[:time].to_i.to_s.ljust(width / 4)
        ].join('')
      }

      @score_display = "\n#{'Your Times'.ljust((width/2))}#{'Top Times'.ljust((width/2))}\n"
      (0..4).each do |index|
        parts = [
          (player_times[index] || ''.ljust(width/2)),
          (board_times[index] || ''.ljust(width/2))
        ]
        @score_display << parts.join('')
        @score_display << "\n"
      end
    end

  end

end