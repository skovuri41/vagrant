class base-config( 
     $sys_packages    = [ 'build-essential', 'curl', 'vim', 'maven', 'tree', 'unzip', 'ncurses-dev','ngrep','zip',
         'automake' , 'checkinstall', 'auto-apt', 'libevent-dev','libtool', 'pkg-config' ]
     ){
     Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/","/usr/local/bin/" ] }
     exec { 'apt-get update':
        command => 'apt-get update',
     }
     class { 'apt':
        always_apt_update => true,
     }
     class { 'git': }
     package { ['python-software-properties']:
        ensure  => 'installed',
        require => Exec['apt-get update'],
     }
     package { $sys_packages:
        ensure => "installed",
        require => Exec['apt-get update'],
     }
     apt::ppa { 'ppa:cassou/emacs':
        before  => Class['base-config::emacs'],
     }
     class { 'base-config::emacs': }
     apt::ppa { 'ppa:webupd8team/java':
        before  => Package['oracle-java7-installer'],
     }
     exec {
       'set-licence-selected':
        command => '/bin/echo debconf shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections';
 
       'set-licence-seen':
        command => '/bin/echo debconf shared/accepted-oracle-license-v1-1 seen true | /usr/bin/debconf-set-selections';
     }
     package { 'oracle-java7-installer':
        ensure  => "installed",
        require => [Exec['apt-get update'], Exec['set-licence-selected'], Exec['set-licence-seen']]
     }
     exec {
      'download lein':
      command => '/usr/bin/wget https://raw.github.com/technomancy/leiningen/stable/bin/lein',
      cwd     => '/usr/local/bin',
      creates => '/usr/local/bin/lein',
      ;

      'make lein executable':
      command => '/bin/chmod +x /usr/local/bin/lein',
      require => [Package['oracle-java7-installer'],Exec['download lein'],]
      ;
     }
     exec { "git clone tmux-code":
      cwd     => '/vagrant',
      creates => "/vagrant/tmux-code",
      command => "git clone http://git.code.sf.net/p/tmux/tmux-code tmux-code",
      require => Package[ 'git' ],
      onlyif   => "test ! -d /vagrant/tmux-code",
    }
    exec { "build tmux":
       cwd      => "/vagrant/tmux-code",
       command  =>  'sh autogen.sh;./configure && make; ln -s /vagrant/tmux-code/tmux /usr/local/bin/tmux',
       onlyif   => ["test -d /vagrant/tmux-code","test ! -L /usr/local/bin/tmux"],
       require => [Exec['git clone tmux-code'], Package[ 'git' ]]
     }
}