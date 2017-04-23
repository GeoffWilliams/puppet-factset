require "puppet_factset/version"
require "json"

module PuppetFactset

  MERGE_FACTS_DIR = File.join("spec", "merge_facts")

  # Return the name of the directory holding the factsets
  def self.factset_dir
    File.expand_path(File.join(File.dirname(__FILE__), '..', 'res', 'factset'))
  end

  # Load factset json file and return a hash
  def self.factset_hash(factset_name)
    data = JSON.parse(File.read(File.join(factset_dir(), "#{factset_name}.json")))

    merge_facts(data["values"])

    # The facts are tucked away inside the 'values' element so just return that
    data["values"]
  end

  # List the available factsets, sorted A-Z
  def self.factsets()
    Dir.glob(File.join(factset_dir, '*.json')).map { |f|
      File.basename(f).gsub('.json','')
    }.sort
  end

  # If a directory exists at `merge_facts` relative to the current directory then
  # all JSON files present in this directory will be loaded and merged into passed
  # in factset
  #
  # @param factset Hash of facts (will be modified in-place)
  def self.merge_facts(factset)
    Dir["#{MERGE_FACTS_DIR}/*.json"].each { |json_file|
      facts = JSON.parse(File.read(json_file))
      factset.merge!(facts)
    }
  end
end
