class perimeternode {
    notify { "Starting puppet execution for Jamaav perimeter nodes": }

    # install haproxy on the perimeter nodes
    package { 'haproxy':
        ensure => '1.4.18-0ubuntu1.2'
    }
}
