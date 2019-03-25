require 'spec_helper'

describe SlotEvolution::Slot::ReelSet do

  let(:path) { 'spec/fixtures' }
  let(:file) { 'test_config_1' }

  let(:config) { SlotEvolution::Helpers::Config.new(path, file) }

  context "When no reels passed to initializer" do

    let(:reels)  { [] }
    let(:strip) do

      ["Ace", "King", "Queen", "Jack", "Ten", "Nine", "Jack", "Queen", "King", "King"]

    end
    let(:rotated_strip) do

      ["Jack", "Queen", "King", "King", "Ace", "King", "Queen", "Jack", "Ten", "Nine"]

    end
    let(:window) do

      ["Ace", "King", "Queen"]

    end
    let(:rotated_window) do

      ["Jack", "Queen", "King"]

    end

    let(:reel_set) { SlotEvolution::Slot::ReelSet.new(config, reels)}

    before(:each) do
      allow_any_instance_of(SlotEvolution::Slot::Reel).to receive(:create_reel_strip).and_return(strip)
      allow(Random).to receive(:rand).and_return(6)
    end

    it "creates a reel set with 4 reels" do
      expect(reel_set.reels.count).to   eq(4)
    end

    it "creates a reel set with specific attributes" do
      expect(reel_set.reels.first).to have_attributes(:strip => strip)
      expect(reel_set.windows).to eq([ window, window, window, window])
    end

    it "spins reels" do
      expect(reel_set.spin.reels.last).to have_attributes(:strip => rotated_strip, :window => rotated_window)
    end

  end

  context "When a reel set passed to initializer" do

    let(:strip_1) do

      ["Ace", "Nine", "Ace", "Jack", "Ten", "Nine", "Jack", "Queen", "King", "King"]

    end
    let(:strip_2) do

      ["Nine", "Jack", "King", "Jack", "Ten", "Ace", "Jack", "Queen", "Nine", "King"]

    end
    let(:strip_3) do

      ["Jack", "King", "Queen", "Queen", "Ten", "Nine", "Jack", "Queen", "Ten", "King"]

    end
    let(:strip_4) do

      ["Queen", "King", "Queen", "Jack", "Queen", "Nine", "Ten", "Queen", "Nine", "King"]

    end

    let(:reels)  { [ strip_1, strip_2, strip_3, strip_4 ] }

    let(:windows) do
      [
        ["Ace", "Nine", "Ace"],
        ["Nine", "Jack", "King"],
        ["Jack", "King", "Queen"],
        ["Queen", "King", "Queen"]
      ]
    end

    let(:rotated_strip_1) do

      ["Queen", "King", "King", "Ace", "Nine", "Ace", "Jack", "Ten", "Nine", "Jack"]

    end
    let(:rotated_strip_2) do

      ["Queen", "Nine", "King", "Nine", "Jack", "King", "Jack", "Ten", "Ace", "Jack"]

    end
    let(:rotated_strip_3) do

      ["Queen", "Ten", "King", "Jack", "King", "Queen", "Queen", "Ten", "Nine", "Jack"]

    end
    let(:rotated_strip_4) do

      ["Queen", "Nine", "King", "Queen", "King", "Queen", "Jack", "Queen", "Nine", "Ten"]

    end

    let(:rotated_windows) do
      [
        ["Queen", "King", "King"],
        ["Queen", "Nine", "King"],
        ["Queen", "Ten", "King"],
        ["Queen", "Nine", "King"]
      ]
    end

    let(:reel_set) { SlotEvolution::Slot::ReelSet.new(config, reels)}

    before(:each) do
      allow(Random).to receive(:rand).and_return(7)
    end

    it "creates a reel set with 4 reels" do
      expect(reel_set.reels.count).to   eq(4)
    end

    it "creates a reel set with specific attributes" do
      expect(reel_set.reels.first).to have_attributes(:strip => strip_1)
      expect(reel_set.windows).to eq(windows)
    end

    it "spins all reels" do
      spinned_reels = reel_set.spin
      expect(spinned_reels.reels.map(&:strip)).to eq(
        [
          rotated_strip_1,
          rotated_strip_2,
          rotated_strip_3,
          rotated_strip_4
        ])

      expect(spinned_reels.windows).to eq(rotated_windows)
    end

  end

end