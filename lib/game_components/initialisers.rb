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

    def init_level(filename)
      @level = Level.new(filename)
      @field = Field.new(self)
      initialize_worms
      initialize_targets
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