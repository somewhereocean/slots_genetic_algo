module SlotEvolution
  module Evolution

    class Individual

      attr_accessor :reel_set, :rtp, :fit_diff

      def initialize(params, genes)
        @reel_set     = SlotEvolution::Slot::ReelSet.new(params[:config], genes)
        @rtp          = SlotEvolution::Slot::RTP.new(params.merge({reel_set: @reel_set})).simulate
        @fit_diff     = nil
      end

      def fitness(benchmark)
        puts @rtp
        @fit_diff     = (@rtp - benchmark).abs / benchmark
        self
      end 

      def fit?
        return false if @fit_diff.nil? || @fit_diff.abs >= 0.005
        true
      end
    end

  end
end
