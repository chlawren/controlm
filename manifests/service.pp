# == Class _controlm::service
#
# This class is meant to be called from _controlm.
# It ensure the service is running.
#
class controlm::service inherits controlm {

  service { "$user":
    ensure => 'running',
    enable => false,
  }
}
