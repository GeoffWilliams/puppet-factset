require "spec_helper"

RSpec.describe PuppetFactset do
  it "has a version number" do
    expect(PuppetFactset::VERSION).not_to be nil
  end

  it "returns correct directory name" do
    factset_dir = PuppetFactset::factset_dir
    expect(Dir.exists?(factset_dir)).to be true

    # pick a random factset to prove we have the correct dir
    facts_file = File.join(factset_dir, 'AIX-6.1-powerpc.json')
    expect(File.exists?(facts_file)).to be true
  end

  it "returns hash of fact data for given factset" do
    factset_hash = PuppetFactset::factset_hash('AIX-6.1-powerpc')
    expect(factset_hash.class).to eq Hash
    expect(factset_hash["os"]["family"]).to eq 'AIX'
  end

  it "raises when factset missing" do
    expect{PuppetFactset::factset_hash('nothere')}.to raise_error Errno::ENOENT
  end

  it "factsets returns the correct list of avaiable factset names" do
    factsets = PuppetFactset::factsets
    expect(factsets.class).to eq Array
    expect(factsets.size).to eq `ls res/factset/*.json |wc -l`.strip.to_i
    factsets.each do |f|
      # test filename removed
      expect(f).not_to match /\.json/

      # test path removed
      expect(f).not_to match /\//
    end
  end

end
