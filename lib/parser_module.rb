require 'json'

module Parser
  def parse_json_file(json_file)
    file = File.read json_file 
    JSON.parse file
  end
end
