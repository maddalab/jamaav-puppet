class site {
	# write a configuration file that captures the entire deployment
	file { '/opt/db/site.yml'
		source => "puppet:///modules/site/$environment/site.yml"
	}
}