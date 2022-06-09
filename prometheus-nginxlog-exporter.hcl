listen {
  port = 4040
}

namespace "prom" {
  format = "$remote_addr - $remote_user [$time_local] \"$request\" $status $body_bytes_sent \"$http_referer\" \"$http_user_agent\"rt=$request_time uct=\"$upstream_connect_time\" uht=\"$upstream_header_time\" urt=\"$upstream_response_time\""
  source {
    files = [
      "/var/log/nginx/prom.access.log"
    ]
  }

  metrics_override = { prefix = "" }
  namespace_label = "vhost"

  labels {
    app = "prometheus"
  }

  # histogram_buckets = [.005, .01, .025, .05, .1, .25, .5, 1, 2.5, 5, 10]
}

namespace "nginx" {
  source = {
    files = [
      "/var/log/nginx/default.access.log"
    ]
  }

  format = "$remote_addr - $remote_user [$time_local] \"$request\" $status $body_bytes_sent \"$http_referer\" \"$http_user_agent\"rt=$request_time uct=\"$upstream_connect_time\" uht=\"$upstream_header_time\" urt=\"$upstream_response_time\"" 

  metrics_override = { prefix = "" }
  namespace_label = "vhost"
  labels {
    app = "default"
  }
}
