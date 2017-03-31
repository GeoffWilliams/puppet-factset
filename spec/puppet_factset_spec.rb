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
    expect{PuppetFactset::factset_hash('nothere')}.to raise_error
  end

end
