# == Class _controlm::params
#
# This class is meant to be called from _controlm.
# It sets variables according to platform.
#
class _controlm::params {

	$settings = {
			   'user' 	=> "$env",
			   'host'	=> $::hostname,
			   }
	
	case $::osfamily {
		'Debian': {
			$package_name		= 'module'
			$service_name		= 'module'
			$config_dir		= '/etc/default'
			$service_dir		= '/etc/init.d'
			$home			= '/usr/local/module'
			$config_file		= 'module.sysconf.init'
			$service_file		= 'module.init'
		}
		'RedHat': {
			$package_name		= "$env"
			$service_name		= "$env"
			$user			= "$env"
			$group			= "$env"
			$user_id		= "$env_id"
			$config_dir		= '/var/log/ctm'
			$home			= "/var/log/ctm/$env"
			$run_dir		= "/var/log/ctm/$env/ctm/scripts"
			$nfs_mnt		= '/mnt/software'
			$agent_test		= "$home/BMCINSTALL/log/BMC_Control-M_AGENT_Install"
			$sysman_dir		= '/sysman/operators'
			$sysman_stop		= "stop_ctm_agent_$env"
			$sysman_start		= "start_ctm_agent_$env"

			if $::operatingsystemmajrelease >= '7' {
				$service_dir  	= '/etc/systemd/system'
				$config_file  	= "$env.systemd"
				$service_file 	= "$env.service"
				$service_mode	= "0644"
			}else{
				$service_dir	= '/etc/init.d'
				$config_file	= "$env-init"
				$service_file	= "$env"
				$service_mode   = "0755"
			}
		}
		default: {
			fail("${::operatingsystem} not supported")
		}
	}
}
