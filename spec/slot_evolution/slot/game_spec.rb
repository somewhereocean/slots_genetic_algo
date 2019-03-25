require 'spec_helper'
require 'pry'

describe SlotEvolution::Slot::Game do

  let(:bet)      { 10.0 }
  let(:path)     { 'spec/fixtures' }
  let(:file)     { 'test_config_1' }
  let(:config)   { SlotEvolution::Helpers::Config.new(path, file) }
  let(:payouts)  { 
                   { 
                     3 => {"Ace"=>50, "Jack"=>5, "King"=>25, "Nine"=>1, "Queen"=>15, "Ten"=>2},
                     4 => {"Ace"=>100, "Jack"=>10, "King"=>50, "Nine"=>2, "Queen"=>25, "Ten"=>5}
                   } 
                 }

  let(:strip_1) do
    ["Ace", "Nine", "Ace", "Jack", "Ten", "Nine", "Jack", "Queen", "King", "King"]
  end
  let(:strip_2) do
    ["Nine", "Jack", "King", "Jack", "Ten", "Ace", "Jack", "Queen", "Nine", "King"]
  end
  let(:strip_3) do
    ["Jack", "King", "Queen", "Queen", "Ten", "Jack", "Jack", "Queen", "Ten", "King"]
  end
  let(:strip_4) do
    ["Queen", "King", "Queen", "Jack", "Queen", "Jack", "Ten", "Queen", "Nine", "King"]
  end

  let(:reels)    { [ strip_1, strip_2, strip_3, strip_4 ] }
  let(:reel_set) { SlotEvolution::Slot::ReelSet.new(config, reels) }
  let(:params)   { { bet: bet, config: config, reel_set: reel_set } }

  let(:game)   { SlotEvolution::Slot::Game.new(params) }

  before(:each) do
    allow(Random).to receive(:rand).and_return(4)
  end

  it "creates a game with attributes" do
    expect(game).to have_attributes(bet: 10.0, win: 0.0, payouts: payouts)
    expect(game.reel_set).not_to eq(nil)
  end

  it "spins reels once and calculates a win" do
    played_game = game.play
    expect(played_game.reel_set.windows).to eq([
      ["Ten", "Nine", "Jack"],
      ["Ten", "Ace", "Jack"],
      ["Ten", "Jack", "Jack"],
      ["Queen", "Jack", "Ten"]
    ])
    expect(played_game.win).to eq(25)
  end

  it "spins reels twice and calculates a win for the last round" do
    played_game = game.play.play
    expect(played_game.reel_set.windows).to eq([
      ["King", "King", "Ace"],
      ["Nine", "King", "Nine"],
      ["Ten", "King", "Jack"],
      ["Nine", "King", "Queen"]
    ])
    expect(played_game.win).to eq(100)
  end

  it "spins reels three times and calculates a win for the last round" do
    played_game = game.play.play.play
    expect(played_game.reel_set.windows).to eq([
      ["Ace", "Jack", "Ten"],
      ["King", "Jack", "Ten"],
      ["Queen", "Queen", "Ten"],
      ["Queen", "Jack", "Queen"]
    ])
    expect(played_game.win).to eq(2)
  end

  it "spins reels once and calculates a win equal 0 if no wins found" do
    game.reel_set.reels.first.strip[4] = "Queen"
    game.reel_set.reels.first.strip[5] = "Queen"
    game.reel_set.reels.first.strip[6] = "Queen"

    played_game = game.play
    expect(played_game.reel_set.windows).to eq([
      ["Queen", "Queen", "Queen"],
      ["Ten", "Ace", "Jack"],
      ["Ten", "Jack", "Jack"],
      ["Queen", "Jack", "Ten"]
    ])
    expect(played_game.win).to eq(0)
  end

  it "spins reels once and calculates a 81 win for Queen" do
    (0..3).each do |i|
      (4..6).each do |j|
        game.reel_set.reels[i].strip[j] = "Queen"
      end
    end

    played_game = game.play
    expect(played_game.reel_set.windows).to eq([
      ["Queen", "Queen", "Queen"],
      ["Queen", "Queen", "Queen"],
      ["Queen", "Queen", "Queen"],
      ["Queen", "Queen", "Queen"]
    ])
    expect(played_game.win).to eq(2025)
  end

end
