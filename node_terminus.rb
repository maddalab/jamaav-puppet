require "socket"
require "yaml"

host_name = Socket::gethostname
match_data = host_name.match('(.*)-\d\.(.*)\.jamaav.net')
config_data = {}
if (match_data.nil?)
	raise "Malformed hostname #{host_name}, hostname of the format <nodetype>-<index>.<datacenter>.jamaav.net is expected"
end

nodetype = match_data[1]
if (nodetype.nil?)
	raise "Malformed hostname #{host_name}, cannot determine nodetype, hostname of the format <nodetype>-<index>.<datacenter>.jamaav.net is expected"
end
config_data["nodeclass"] = nodetype

environment = match_data[2]
if (environment.nil?)
	raise "Malformed hostname #{host_name}, cannot determine nodetype, hostname of the format <nodetype>-<index>.<datacenter>.jamaav.net is expected"
end
config_data["environment"] = environment

# load custom parameters
if !File.exists?("/var/db/config.yml")
	raise "Configuration file /var/db/config.yml does not exists.
       	It must include the basic information about the node, ex:name and can provide additional information for package version"
end

config_data.merge(YAML.load_file("/var/db/config.yml").to_hash)

# write out the yaml for node terminus
puts "---"
puts "environment:"
puts "  #{config_data["environment"]}"
puts "classes:"
puts "  #{config_data["nodeclass"]}node:"
puts "parameters:"
config_data.each do |key, value|
	puts "  #{key}: #{value}"
end

