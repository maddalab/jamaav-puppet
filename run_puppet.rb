#!/usr/bin/ruby

require "socket"

host_name = Socket::gethostname
match_data = host_name.match('(.*)-\d\.(.*)\.jamaav.net')
if (match_data.nil?)
	raise "Malformed hostname #{host_name}, hostname of the format <nodetype>-<index>.<datacenter>.jamaav.net is expected"
end

nodetype = match_data[1]
if (nodetype.nil?)
	raise "Malformed hostname #{host_name}, cannot determine nodetype, hostname of the format <nodetype>-<index>.<datacenter>.jamaav.net is expected"
end

environment = match_data[2]
if (environment.nil?)
	raise "Malformed hostname #{host_name}, cannot determine nodetype, hostname of the format <nodetype>-<index>.<datacenter>.jamaav.net is expected"
end

puts("Executing puppet for node of type #{nodetype} in environment #{environment}");

system("/usr/bin/puppet", "apply", "/etc/puppet/environments/#{environment}/manifests/site.pp", "--environment=#{environment}")

puts("Exit status is #{$?.exitstatus}")
