module SlotEvolution
  module Helpers

    class ConfigExporter

      def self.export(path, config, rtp, strips)
        pp = "--------------------"
        puts pp
        puts "Best reel set :".cyan
        puts pp

        strips.each.with_index(1) do |s, i|
          puts "Strips #{i} : #{s.to_s}".yellow
          puts pp
        end

        puts "RTP of this set : #{rtp}".green

        config["rtp"]   = rtp
        config["reels"] = {}
        strips.each.with_index(1) do |strip, i|
          config["reels"][i.to_s] = strip
        end

        config_name = "RTP #{(rtp * 100).round(2)}% #{Time.now.utc}"

        File.open("#{path}/#{config_name}.json","w") do |f|
          f.write(config.to_json)
        end

      end

    end

  end
end
