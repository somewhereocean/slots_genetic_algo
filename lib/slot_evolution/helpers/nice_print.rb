module SlotEvolution
  module Helpers

    class NicePrint

      @@pretty_print     = ("♥♦♣♠"*12)
      @@reel_width       = 12

      def self.print_screen(rows)
        puts @@pretty_print
        rows.transpose.each do |row|
          s_row = row.map do |symbol|
            "#{symbol}#{" "*(@@reel_width - symbol.length - 1)}|"
          end
          puts s_row.join.yellow
        end
        puts @@pretty_print
      end

      def self.print_win(win, bet)
        puts "\nYour win is : #{win}   #{win == 0 ? "ಠ_ಠ" : (win < bet*2 ? "(╯°□°)╯" : "༼ つ ◕_◕ ༽つ")}".cyan
      end

      def self.print_balance(balance)
        puts "\nYour balance is : #{balance}\n".cyan
      end

      def self.print_goodbye
        puts "Bye!".red.italic
      end

      def self.print_control
        puts "Press enter to spin reels or type exit to quit".green
      end

    end
  end
end