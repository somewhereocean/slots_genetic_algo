module SlotEvolution
  module Slot

    class ReelSet

      attr_accessor :reels, :windows

      def initialize(config, reels = [])
        @reels         = Array.new(config.number_of_reels) do |i|
          reels.empty? ? Reel.new(config) : Reel.new(config, reels[i])
        end
        @windows       = @reels.map {|r| r.window}
      end

      def spin
        @reels         = @reels.each {|r| r.spin }
        @windows       = @reels.map  {|r| r.window}
        self
      end

    end

  end
end
