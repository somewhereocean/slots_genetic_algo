module SlotEvolution
  module Slot

    class Reel

      attr_accessor :strip, :window, :reel_length, :screen_height

      def initialize(config, reel = [])
        @reel_length   = config.reel_length
        @strip         = reel.empty? ? create_reel_strip(config) : reel
        @screen_height = config.screen_height
        @window        = initial_window
      end

      def spin
        @strip         = rotate_strip
        @window        = @strip.first(@screen_height)
        self
      end

      private

      def create_reel_strip(config)
        Array.new(@reel_length) { |i| config.symbols.sample }
      end

      def initial_window
        @strip.first(@screen_height)
      end

      # stops at any position
      def rotate_strip
        @strip.rotate(Random.rand(@reel_length))
      end

    end

  end
end
