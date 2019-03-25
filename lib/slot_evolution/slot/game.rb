module SlotEvolution
  module Slot

    class Game

      attr_accessor :bet, :reel_set, :win, :payouts

      def initialize(params)
        @bet        = params[:bet]
        @reel_set   = params[:reel_set]
        @win        = 0.0
        @payouts    = params[:config].paytable.payouts
      end

      def play
        @reel_set.spin
        @win = SlotEvolution::Helpers::WinCalculator.calculate_wins(@reel_set, @payouts)
        self
      end

    end

  end
end
