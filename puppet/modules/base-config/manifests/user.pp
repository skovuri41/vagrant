class base-config::user($username, $groupname) {
    group { $groupname:
        ensure => present,
    }
    user { $username:
        ensure => present,
        groups => [
            "sudo",
            $groupname
        ],
        shell      => '/bin/bash',
        home       => "/home/${username}",
        managehome => yes,
        require    => Group[$groupname],
        password => '$6$lY2Gp3Cr$zNrUB7T3yibUF/gWn5cTQ0fNv7MUmx/DZuw3E7I..Vh9tITG28BtgvXJPU4Gm4Z/9oNvlbX24KzQ9Ib1QH1B9.',
        #test is password
    }
    file { "/home/${username}":
        ensure => directory,
        owner  => $username,
        group  => $groupname,
        mode   => 644,
        require => User[$username] 
    }
    user { "www-user":
        ensure => present,
        groups => [ "sudo" ],
        shell  => '/bin/bash'
    }
    
    file { "/home/${username}/.bashrc":
        ensure => present,
        owner  => $username,
        group  => $groupname,
        mode   => 644,
        source => '/vagrant/dot-files/.bashrc',       
        require => User[$username]
    }
    file { "/home/${username}/.inputrc":
        ensure => present,
        owner  => $username,
        group  => $groupname,
        mode   => 644,
        source => '/vagrant/dot-files/.inputrc',        
        require => User[$username]
    }
    file { "/home/${username}/.tmux.conf":
        ensure => present,
        owner  => $username,
        group  => $groupname,
        mode   => 644,
        source => '/vagrant/dot-files/.tmux.conf',        
        require => User[$username]
    }
    file { "/home/${username}/.Xresources":
        ensure => present,
        owner  => $username,
        group  => $groupname,
        mode   => 644,
        source => '/vagrant/dot-files/.Xresources',
        require => User[$username]
    }
    file { "/home/${username}/.bash_aliases":
        ensure => present,
        owner  => $username,
        group  => $groupname,
        mode   => 644,
        source => '/vagrant/dot-files/.bash_alias',
        require => User[$username]
    }
    file { "/home/${username}/.emacs.d":
        ensure => directory,
        owner  => $username,
        group  => $groupname,
        mode   => 644,
        require => User[$username]
    }
    file { "/home/${username}/.emacs.d/init.el":
        ensure => present,
        owner  => $username,
        group  => $groupname,
        mode   => 644,
        source => '/vagrant/dot-files/init.el',
        require => User[$username]
    }
}