# Default backend definition.  Set this to point to your content
# server.
#
backend default {
    .host = "127.0.0.1";
    .port = "81";
    .connect_timeout = 5s;
    .first_byte_timeout = 30s;
    .between_bytes_timeout = 60s;
    .max_connections = 800;
}
sub vcl_recv {
  if (req.restarts == 0) {
      if (req.http.x-forwarded-for) {
          set req.http.X-Forwarded-For =
              req.http.X-Forwarded-For + ", " + client.ip;
      } else {
          set req.http.X-Forwarded-For = client.ip;
      }
   }
   if (req.request != "GET" &&
     req.request != "HEAD" &&
     req.request != "PUT" &&
     req.request != "POST" &&
     req.request != "TRACE" &&
     req.request != "OPTIONS" &&
     req.request != "DELETE") {
       /* Non-RFC2616 or CONNECT which is weird. */
       return (pipe);
   }
   if (req.request != "GET" && req.request != "HEAD") {
       /* We only deal with GET and HEAD by default */
       return (pass);
   }
   # force lookup for static assets
   if (req.url ~ "\.(png|gif|jpg|swf|css|js|html|ico)$") {
       return(lookup);
   }
   if (req.http.Authorization || req.http.Cookie) {
       /* Not cacheable by default */
       return (pass);
   }
   return (lookup);
}

sub vcl_fetch {
   # strip the cookie before static asset is inserted into cache.
   if (req.url ~ "\.(png|gif|jpg|swf|css|js|html|ico)$") {
       unset beresp.http.set-cookie;
   }

  remove beresp.http.Cache-Control;
  set beresp.http.Cache-Control = "public";

   return (deliver);
}