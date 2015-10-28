module GameComponents

  module Initialisers

    def initialize_targets
      @targets = []
      @level['targets'].times do
        @targets << Target.new(self)
      end
    end

    def initialize_worms
      @worms = []
      @level['worms'].each do |worm|
        @worms << Kernel.const_get(worm['class']).new(self, worm)
      end
    end

    def init_level(filename = nil)
      if filename
        @filename = filename
      else
        get_first_level
      end
      @level = Level.new(@filename, self)
      @field = Field.new(self)
      initialize_worms
      initialize_targets
    end

    def get_first_level
      if ARGV[1]
        levels = Dir.glob(
          File.join(
            File.dirname(__FILE__),
            '..','..',
            'levels',
            "#{ARGV[1]}*"
          )
        )
        level = levels[0]
        if level
          @filename = Game.new(levels[0].split('/')[-1])
        else
          raise "No Level found for #{ARGV[1]}"
        end
      else
        @filename = @config['first_level']
      end
    end

    def get_player
      name = ARGV[0]
      unless name
        puts "What is your name?"
        name = gets.strip
      end
      self.player = Player.new(name)
    end

  end

end