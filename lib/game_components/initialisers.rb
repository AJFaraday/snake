module GameComponents

  module Initialisers

    def initialize_targets
      @targets = []
      @config['targets'].times do
        @targets << Target.new(self)
      end
    end

    def initialize_worms
      @worms = []
      @config['worms'].each do |kls|
        @worms << Kernel.const_get(kls).new(self)
      end
    end

  end

end