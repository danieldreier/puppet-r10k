# == Class: r10k::config
#
# Set up the root r10k config file (/etc/r10k.yaml).
#
# === Parameters
#
# * [*cachedir*]
#   Path to a directory to be used by r10k for caching data.
#   Default: /var/cache/r10k
# * [*sources*]
#   Hash containing data sources to be used by r10k to create dynamic Puppet
#   environments. Default: {}
# * [*purgedirs*]
#   An Array of directory paths to purge of any subdirectories that do not
#   correspond to a dynamic environment managed by r10k. Default: []
# * [*path*]
#   The path at which the r10k config is written. Default: /etc/r10k.yaml
# * [*owner*]
#   The owner for the r10k config file. Default: root
# * [*group*]
#   The group owner of the r10k config file. Default: root
# * [*mode*]
#   The the mode of the r10k config file. Default: 0644
#
# === Examples
#
#  class { 'r10k::config':
#    sources => {
#      'somename' => {
#        'remote'  => 'ssh://git@github.com/someuser/somerepo.git',
#        'basedir' => "${::settings::confdir}/environments"
#      },
#      'someothername' => {
#        'remote'  => 'ssh://git@github.com/someuser/someotherrepo.git',
#        'basedir' => '/some/other/basedir'
#      },
#    },
#    purgedirs => [
#      "${::settings::confdir}/environments",
#      '/some/other/basedir',
#    ],
#  }
#
# == Documentation
#
# * https://github.com/adrienthebo/r10k#dynamic-environment-configuration
#
# === Authors
#
# Charlie Sharpsteen <source@sharpsteen.net>
#
class r10k::config (
  $cachedir  = '/var/cache/r10k',
  $sources   = {},
  $purgedirs = [],
  $path = '/etc/r10k.yaml',
  $owner = 'root',
  $group = 'root',
  $mode  = '0644',
){

  file { "${path}":
    ensure  => 'file',
    owner   => $owner,
    group   => $group,
    mode    => $mode,
    content => template('r10k/r10k.yaml.erb'),
  }

}
