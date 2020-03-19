# Class: _controlm
# ===========================
#
# Full description of class _controlm here.
#
# Parameters
# ----------
#
# * `sample parameter`
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#

class _controlm (

  ## Packages
  $package_name		= $_controlm::params::package_name,

  ## Services
  $service_name		= $_controlm::params::service_name,

  ## Dirs
  $config_dir		= $_controlm::params::config_dir,
  $service_dir		= $_controlm::params::service_dir,
  $home			= $_controlm::params::home,

  ## Conf Files
  $config_file		= $_controlm::params::config_file,
  $service_file		= $_controlm::params::service_file,

  ## settings
  $_controlm_settings	= $_controlm::params::settings,
  $group			= $_controlm::params::group,
  $user				= $_controlm::params::user,
  $user_id			= $_controlm::params::user_id,
  $run_dir			= $_controlm::params::run_dir,
  $sysman_dir			= $_controlm::params::sysman_dir,
  $sysman_stop			= $_controlm::params::sysman_stop,
  $sysman_start			= $_controlm::params::sysman_start,
  $nfs_mnt			= $_controlm::params::nfs_mnt,
  $agent_test			= $_controlm::params::agent_test,

) inherits _controlm::params {

  # validate parameters here

  class { '::_controlm::config': } ->
  class { '::_controlm::install': } ->
  class { '::_controlm::fixpack': } ~>
  class { '::_controlm::service': } ->
  Class['::_controlm']
}
