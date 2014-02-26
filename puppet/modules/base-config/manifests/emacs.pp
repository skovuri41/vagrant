class base-config::emacs () {
  package { "emacs":
     ensure => "installed",
     require => Exec['apt-get -yq install emacs24 emacs24-el emacs24-common-non-dfsg'],
  }

  exec { 'apt-get -yq install emacs24 emacs24-el emacs24-common-non-dfsg':
    command => 'apt-get -yq install emacs24 emacs24-el emacs24-common-non-dfsg',
  }
}