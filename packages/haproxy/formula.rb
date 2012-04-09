class Haproxy < DebianFormula
  homepage 'http://haproxy.1wt.eu/'
  url 'http://haproxy.1wt.eu/download/1.4/src/haproxy-1.4.20.tar.gz'
  md5 '0cd3b91812ff31ae09ec4ace6355e29e'

  name 'haproxy'
  version '1.4.20+github6'
  section 'net'
  description 'The Reliable, High Performance TCP/HTTP Load Balancer'

  build_depends 'libpcre3-dev'
  config_files '/etc/haproxy/haproxy.cfg'
  requires_user 'haproxy', :remove => false

  def patches
    'patches/send-proxy.patch'
  end

  def build
    make 'TARGET' => 'linux26', 'CPU' => 'native', 'USE_PCRE' => '1', 'PREFIX' => '/usr'
  end

  def install
    make :install, 'DESTDIR' => destdir, 'PREFIX' => '/usr', 'DOCDIR' => '/usr/share/doc/haproxy'

    (etc/'haproxy').install_p 'examples/haproxy.cfg'
    (etc/'haproxy').install_p 'examples/errorfiles/', 'errors'
    (etc/'default').install_p workdir/'default-haproxy', 'haproxy'
    (etc/'init.d').install_p  workdir/'init.d-haproxy',  'haproxy'
  end
end
