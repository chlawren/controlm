# == Class _controlm::install
#
# This class is called from _controlm for install.
#
class _controlm::install inherits _controlm {

#  file { "$nfs_mnt/$user.tar.Z":        
#  ensure => present,                    
#  notify => Exec['unpack tar_install'], 
#  before => Exec['install tar_install'],
#  }                                     

  exec { 'mount nfs_dir':
  command => "mount.nfs -r bc21:/software/ctm_software $nfs_mnt",
  path    => [ '/usr/bin/', '/usr/sbin/' ],
  unless  => "test -f $agent_test*",
  notify => Exec['unpack tar_install'],
  before => Exec['install tar_install'],
  }

  exec { 'unpack tar_install':
  command => "tar zxf $nfs_mnt/$user.tar.Z -C /",
  path    => [ '/usr/bin/', '/bin/' ],
  unless  => "test -f $agent_test*",
  }

  exec { 'install tar_install':
  command     => "setup.sh -silent ctmagent_$user.xml",
  path        => [ "$home", '/bin/', '/usr/bin/' ],
  cwd         => "$home",
  user        => "$user",
  environment => ["HOME=$home"],
  unless      => "test -f $agent_test*",
  notify      => Exec[ 'umount nfs_dir' ],
  }

  exec { 'umount nfs_dir':
  command => "umount $nfs_mnt",
  path    => [ '/usr/bin/', '/usr/sbin/' ],
  unless  => "test ! -f $nfs_mnt/$user.tar.Z",
  }

}
