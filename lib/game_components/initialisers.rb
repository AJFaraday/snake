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
      @level.unlock
      @field = Field.new(self)
      initialize_worms
      initialize_targets
    end

  end

end