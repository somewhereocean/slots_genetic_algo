module SlotEvolution
  module Helpers

    class OptionsValidator

      def self.validate_options!(opts)
        if opts[:number_of_parents] >= opts[:population_size]  
          raise ArgumentError.new('Number of parents can not be equal or greater than the population size')  
        end
        if opts[:import_path].nil?
          raise ArgumentError.new('Please specify the output folder for generated in the future reels strips')  
        end
      end

    end

  end
end