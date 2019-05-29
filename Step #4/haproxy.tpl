global
  maxconn 2048
  log /dev/log    local0
  log /dev/log    local1 notice
  chroot /var/lib/haproxy
  stats socket /run/haproxy/admin.sock mode 660 level admin
  stats timeout 30s
  user haproxy
  group haproxy
  daemon

defaults
    log global
    mode    http
    option  httplog
    option  dontlognull
    option  forwardfor
    option  http-server-close
    stats enable
    stats uri /stats
    stats realm Haproxy\ Statistics
    stats auth hapuser:password!1234
    timeout connect 5000
    timeout client  50000
    timeout server  50000

frontend www-http
  bind :80
  default_backend web-backend


backend web-backend
  server web1 ${web1ip}:80 check
  server web2 ${web2ip}:80 check
  server web3 ${web3ip}:80 check
