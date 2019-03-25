module SlotEvolution
  module Evolution

    class Evolution

      attr_accessor :current_generation

      def initialize(params)

        pp = "--------------------"
        puts pp
        puts "Generation number 0".yellow
        puts pp

        @params                       = params
        @max_number_of_generations    = params[:max_number_of_generations]
        @population_size              = params[:population_size]
        @gene_length                  = params[:config].reel_length
        @evolution_genes_pool         = params[:config].symbols
        @next_generation_genes        = []

        @current_generation           = Generation.new(params, @next_generation_genes) 
        @generations                  = [ @current_generation ]
        @current_generation_number    = 0

      end

      def simulate

        1.upto(@max_number_of_generations - 1) do

          return @current_generation if @current_generation.best_fit.fit?
          @current_generation_number += 1

          pool                        = GenesPool.new(
                                                  @current_generation.next_generation_parents, 
                                                  @evolution_genes_pool,
                                                  @gene_length 
                                                )
          @next_generation_genes      = pool.generate_next_generation_genes(
                                                  @population_size, 
                                                  @current_generation_number
                                                )
          puts "Generation number #{@current_generation_number}".yellow
          puts "--------------------"
          @current_generation         = Generation.new(@params, @next_generation_genes)
          @generations               << @current_generation
        end

      end

    end

  end
end