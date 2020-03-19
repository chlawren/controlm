# == Class controlm::fixpack
#
# This class is called from controlm for install.
#
class controlm::fixpack inherits controlm {

  exec { 'stop agent':
  command     => "shut-ag -u $user -p all",
  path        => [ "$run_dir", '/bin', '/usr/bin' ],
  cwd         => "$run_dir",
  user        => "$user",
  creates     => "$home/ctm/install/PAKAI.9.0.00.200/trace.log",
  environment => ["HOME=$home", "CONTROLM=$home/ctm"],
  before      => Exec[ 'install fixpack' ],
  }

  file { "$home/PAKAI.9.0.00.200_Linux-x86_64_INSTALL.BIN":
  ensure => present,
  }

  exec { 'install fixpack':
  command     => 'echo "y" |PAKAI.9.0.00.200_Linux-x86_64_INSTALL.BIN',
  path        => [ "$home", '/bin/', '/usr/bin' ],
  cwd         => "$home",
  user        => "$user",
  creates     => "$home/ctm/install/PAKAI.9.0.00.200/trace.log",
  environment => [ "HOME=$home", "CONTROLM=$home/ctm" ],
  notify      => Exec[ 'start agent' ],
  }

  file_line { 'output_mode':
  ensure  => present,
  path    => "$home/ctm/data/CONFIG.dat",
  line    => 'OUTPUT_MODE                         644',
  }

  exec { 'start agent':
  command     => "echo y | start-ag -u $user -p all",
  path        => [ "$home/ctm/scripts", '/bin', '/usr/bin' ],
  cwd         => "$run_dir",
  user        => 'root',
  environment => ["HOME=$home", "CONTROLM=$home/ctm"],
  subscribe   => Exec[ 'install fixpack' ],
  refreshonly => true,
  }

}
