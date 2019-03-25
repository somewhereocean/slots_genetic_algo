module SlotEvolution
  module Helpers

    class WinCalculator

      def self.calculate_wins(reel_set, payouts)
        wins = calculate_win_factors(reel_set, payouts)
        wins.map do |k, r|
          r.map do |s, oc|
            payouts[k][s] * oc
          end.sum
        end.sum
      end

      def self.calculate_win_factors(reel_set, payouts)
        occurs                  = payouts.keys
        wins                    = {}

        (occurs.min..occurs.max).each do |occur|
          transformed_windows   = reel_set.windows.first(occur).map do |window|
            transform_each_window(window)
          end
          wins[occur]           = {}
          transformed_windows.first.each do |k, v|
            wins[occur][k]      = v
            transformed_windows.drop(1).each do |r|
              if r.keys.include?(k)
                wins[occur][k] *= r[k]
              else
                wins[occur][k]  = 0
                break
              end
            end
            wins[occur][k]      = 0 if !reel_set.reels[occur].nil? && reel_set.reels[occur].window.include?(k)
            wins
          end
        end
        wins
      end

      def self.transform_each_window(window)
        window.inject(Hash.new(0)) { |h, s| h[s] += 1; h }
      end

    end

  end
end
