# site.pp is Puppet's entrypoint. Keep it clean. Typically type-level
# defaults and global variable settings are declared here and otherwise
# everything is delegated to nodes.pp and modules.
tag "environment:$environment"
$proxy_environment = "production"

# common node classes that define server roles
import '/etc/puppet/manifests/nodeclasses/*'

