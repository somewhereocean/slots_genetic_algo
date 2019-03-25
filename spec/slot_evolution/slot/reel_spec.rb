require 'spec_helper'
require 'json'

describe SlotEvolution::Slot::Reel do

  let(:path) { 'spec/fixtures' }
  let(:file) { 'test_config_1' }

  let(:config) { SlotEvolution::Helpers::Config.new(path, file) }

  context 'When no reel is passed to initializer' do

    let(:reel) do

      SlotEvolution::Slot::Reel.new(config)

    end
    let(:strip) do 

      ["Ace", "King", "Queen", "Jack", "Ten", "Nine", "Jack", "Queen", "King", "King"]

    end
    let(:rotated_strip) do

      ["Ten", "Nine", "Jack", "Queen", "King", "King", "Ace", "King", "Queen", "Jack"]

    end
    let(:window) do

      ["Ace", "King", "Queen"]

    end
    let(:rotated_window) do 

      ["Ten", "Nine", "Jack"]
    end

    before(:each) do
      allow_any_instance_of(SlotEvolution::Slot::Reel).to receive(:create_reel_strip).and_return(strip)
      allow(Random).to receive(:rand).and_return(4)
    end

    it "creates a reel with attributes" do
      expect(reel.reel_length).to   eq(10)
      expect(reel.screen_height).to eq(3)
      expect(reel.strip.length).to  eq(10)
      expect(reel.strip.length).to  eq(10)
      expect(reel.window).to        eq(window)
    end

    it "spins a reel by N positions" do
      expect(reel.spin).to have_attributes(:strip => rotated_strip, :window => rotated_window)
    end

  end

  context 'When a reel is passed to initializer' do

    let(:predefined_strip) do

      ["Ten", "Nine", "King", "Queen", "Jack", "Ace", "Nine", "Queen", "King", "Ten"] 
    
    end
    let(:reel_with_predefined_strip) do 

      SlotEvolution::Slot::Reel.new(config, predefined_strip) 

    end
    let(:window_for_predefined_strip) do

      ["Ten", "Nine", "King"]

    end
    let(:rotated_predefined_strip) do

      ["Queen", "Jack", "Ace", "Nine", "Queen", "King", "Ten", "Ten", "Nine", "King"]

    end
    let(:rotated_window) do

      ["Queen", "Jack", "Ace"] 

    end

    before(:each) do
      allow(Random).to receive(:rand).and_return(3)
    end

    it "creates a reel with attributes" do
      expect(reel_with_predefined_strip.reel_length).to   eq(10)
      expect(reel_with_predefined_strip.screen_height).to eq(3)
      expect(reel_with_predefined_strip.strip.length).to  eq(10)
      expect(reel_with_predefined_strip.strip.length).to  eq(10)
      expect(reel_with_predefined_strip.window).to        eq(window_for_predefined_strip)
    end

    it "spins a reel by N positions" do
      expect(reel_with_predefined_strip.spin).to have_attributes(:strip => rotated_predefined_strip, :window => rotated_window)
    end

  end
end
