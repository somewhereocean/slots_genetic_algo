module SlotEvolution
  module Evolution

    class Generation

      attr_accessor :next_generation_parents, :best_fit

      def initialize(params, genes_set)
        @population_size         = params[:population_size]
        @number_of_parents       = params[:number_of_parents]
        @benchmark_rtp           = params[:benchmark_rtp]

        @individuals             = Array.new(@population_size) do |i|
          genes = genes_set.empty? ? [] : genes_set[i]
          Individual.new(params, genes).fitness(@benchmark_rtp)
        end

        @next_generation_parents = choose_parents
        @best_fit                = @next_generation_parents.first
      end

      def choose_parents
        @individuals.sort_by do |i|
          i.fit_diff.abs
        end.first(@number_of_parents)
      end

    end

  end
end