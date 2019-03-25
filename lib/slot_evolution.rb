require "slot_evolution/version"
require "slot_evolution/helpers/config"
require "slot_evolution/helpers/config_exporter"
require "slot_evolution/helpers/win_calculator"
require "slot_evolution/helpers/options_validator"
require "slot_evolution/helpers/colorize_output"
require "slot_evolution/helpers/nice_print"
require "slot_evolution/slot/reel"
require "slot_evolution/slot/reel_set"
require "slot_evolution/slot/game"
require "slot_evolution/slot/rtp"
require "slot_evolution/evolution/individual"
require "slot_evolution/evolution/generation"
require "slot_evolution/evolution/evolution"
require "slot_evolution/evolution/genes_pool"


module SlotEvolution
  class Error < StandardError; end
end
