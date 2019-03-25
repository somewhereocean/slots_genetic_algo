module SlotEvolution
  module Helpers

    class Config

      attr_accessor :raw_config, :reel_length, :screen_height, :number_of_reels, :paytable, :symbols

      def initialize(path, file)
        json             = read_config(path, file)
        @raw_config      = JSON.parse(json)

        @reel_length     = @raw_config["reel_length"]
        @screen_height   = @raw_config["screen_height"]
        @number_of_reels = @raw_config["number_of_reels"]
        @paytable        = Paytable.new(@raw_config["paytable"])
        @symbols         = find_symbols
      end

      private

      def read_config(path, file)
        IO.read(
          File.join(__dir__, '..', '..', '..', path, "#{file}.json")
        )
      end

      def find_symbols
        @paytable.payouts.values.map {|h| h.keys}.flatten.uniq
      end

    end

    class Paytable

      attr_accessor :payouts

      def initialize(params)
        @payouts = params.transform_keys { |key| key.to_i }
      end

    end

  end
end