module SlotEvolution
  module Evolution

    class GenesPool

      def initialize(parents, evolution_genes_pool, gene_length)
        @parents               = parents
        @evolution_genes_pool  = evolution_genes_pool
        @genes_pool            = generate_best_genes_pool
        @gene_length           = gene_length
      end

      def generate_next_generation_genes(population_size, generation_number)
        mutated_genes_pool     = mutate_genes_pool(@genes_pool, generation_number)
        
        (1..population_size).map do
          mutated_genes_pool.map do |p|
            p.shuffle.first(@gene_length)
          end
        end
      end

      private

      def generate_best_genes_pool
        puts "--------------------"
        puts "Parents for next generation:".green
        @parents.each {|p| puts p.rtp }
        puts "--------------------"

        weighted_genes_pool    = weigh_genes_pool(@parents)
        @genes_pool            = recombine_genes(weighted_genes_pool)
      end

      def weigh_genes_pool(parents)
        total_weight           = parents.map {|p| 1/p.fit_diff }.sum
        weighted_genes         = parents.map do |p|
          p.reel_set.reels.map do |r|
            weight             = (1/p.fit_diff/total_weight*100).round
            r.strip            * weight
          end  
        end
      end

      def recombine_genes(genes)
        genes.transpose.map do |g|
          g.flatten.shuffle
        end
      end

      def mutate_genes_pool(genes_pool, generation_number)
        genes_pool.map do |genes_set|
          random_gene          = @evolution_genes_pool.sample
          # insert at position 0 since the array will be shuffled later anyway
          genes_set[0]         = random_gene
          if generation_number>= 10
            genes_set = genes_set.concat(@evolution_genes_pool).shuffle
          end
          genes_set
        end
      end

    end

  end
end
