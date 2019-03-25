module SlotEvolution
  module Slot

    class RTP 

      def initialize(params)
        @number_of_simulations  = params[:number_of_simulations]
        @game                   = Game.new(params)
        @total_bet              = 0.0
        @total_win              = 0.0
        @rtp                    = 0.0
      end

      def simulate
        1.upto(@number_of_simulations) do |_|
          @game.play
          @total_bet += @game.bet
          @total_win += @game.win
        end

        @rtp = @total_win / @total_bet
        refresh_win_bet
        @rtp
      end

      private

      def refresh_win_bet
        @total_bet              = 0.0
        @total_win              = 0.0
      end

    end

  end
end
