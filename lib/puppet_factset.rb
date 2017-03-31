require "puppet_factset/version"
require "json"

module PuppetFactset
  # Return the name of the directory holding the factsets
  def self.factset_dir
    File.expand_path(File.join(File.dirname(__FILE__), '..', 'res', 'factset'))
  end

  # Load factset json file and return a hash
  def self.factset_hash(factset_name)
    data = JSON.parse(File.read(File.join(factset_dir(), "#{factset_name}.json")))

    # The facts are tucked away inside the 'values' element so just return that
    data["values"]
  end
end
