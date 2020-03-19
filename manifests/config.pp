# == Class _controlm::config
#
# This class is called from _controlm for service config.
#
class _controlm::config inherits _controlm {

  group { "$group":
    ensure => present,
    gid    => "$env_id",
  }

  user { "$user":
    ensure  => present,
    comment => "ControlM $user User",
    gid     => "$user_id",
    groups  => "$group",
    home    => "$home",
    shell   => '/bin/bash',
    uid     => "$user_id",
  }

  file { "$config_dir":
    ensure => directory,
    owner  => "root",
    group  => "root",
    mode   => '0775',
  }

  file { "$nfs_mnt":
    ensure => directory,
#    before => Mount["$nfs_mnt"],
  }

# mount { "$nfs_mnt":
#    device  => "bc21:/software/ctm_software",
#    fstype  => "nfs",
#    ensure  => "$nfs_state",
#    options => "defaults",
#    }


  file {"$sysman_dir/$sysman_start":
    ensure => present,
    mode   => '0755',
    source => "puppet:///modules/_controlm/$sysman_start",
  }

  file { "$sysman_dir/$sysman_stop":
    ensure => present,
    mode   => "$service_mode",
    source => "puppet:///modules/_controlm/$sysman_stop",
  }

  file { "$service_dir/$service_file":
    ensure => present,
    mode   => "$service_mode",
    source => "puppet:///modules/_controlm/$config_file",
  }
}
