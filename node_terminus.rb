require "socket"
require "yaml"

host_name = Socket::gethostname
match_data = host_name.match('(.*)-\d\.(.*)\.jamaav.net')
if (match_data.nil?)
	raise "Malformed hostname, hostname of the format <nodetype>-<index>.<datacenter>.jamaav.net is expected"
nodetype = match_data[1]
if (nodetype.nil?)
	raise "Malformed hostname, cannot determine nodetype, hostname of the format <nodetype>-<index>.<datacenter>.jamaav.net is expected"
environment = match_data[2]
if (environment.nil?)
	raise "Malformed hostname, cannot determine nodetype, hostname of the format <nodetype>-<index>.<datacenter>.jamaav.net is expected"

# load custom parameters
if !File.exists?("/var/db/config.yml")
	raise "Configuration file does not exists. It must include the basic information about the node, ex:name and can provide additional information for package version"

config_data = YAML.load_file("/var/db/config.yml")

# write out the yaml for node terminus
print "---"
print "environment:"
print "  %s:" % environment
print "classes:"
print "  %snode:" % nodetype
print "parameters:"
config_data.each do |key, value|
	print "  %s: \"%s\"" % (key, value)
end

