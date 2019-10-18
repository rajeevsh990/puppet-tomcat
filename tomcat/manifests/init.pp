# == Class: tomcat
#
# Copyright 2015 rajeev.sharma9@cognizant.com, unless otherwise noted.
#
class tomcat {
  package { 'java-1.7.0-openjdk':
    ensure => present
  }

  package { 'net-tools':
    ensure => present
  }

  package { 'tar':
    ensure => present
  }

  package { 'wget':
    ensure => present
  }

  exec { 'tar -xvf /tmp/apache-tomcat-7.0.64.tar.gz; mv apache-tomcat-7.0.64 tomcat':
    cwd => '/opt',
    path => '/usr/bin/',
    unless => 'test -d /opt/tomcat'
  }
  
  file { '/etc/profile.d/tomcat.sh':
    ensure => present,
    source => 'puppet:///modules/tomcat/tomcat_variable.sh',
    mode => '0755'
  }

  file { '/opt/tomcat/conf/tomcat-users.xml':
    ensure => present,
    source => 'puppet:///modules/tomcat/tomcat-users.xml',
    mode => '0644'
  }

  file {'/etc/init.d/tomcat':
    ensure => present,
    source => 'puppet:///modules/tomcat/tomcat.init',
    mode => '0755'
  }

  #exec { 'start tomcat':
  # command => '/etc/profile.d/tomcat.sh && /etc/init.d/tomcat start',
  # unless => "/usr/bin/ps -f | grep -v grep | grep tomcat"
  #}
}
