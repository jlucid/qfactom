\d .factomd


qRequest:{[serviceName;body]
  hostName:.factomd.hostLookup[serviceName];
  credentials:.factomd.util[`base64Encode] .factomd.passLookup[serviceName];
  header:"Authorization: Basic ",credentials," ",";Content-Type: text/plain";

  out:@[.Q.hpfact[hostName;header;];.j.j body;{[err] -2 "Error: qRequest: ",err;:.j.j (enlist `error)!(enlist err)}];
  @[.j.k;;{[out;err] -2 "Error: ",err," .Q.hpfact returned: ",out;:(enlist `error)!(enlist out)}[out;]] out 
 }

curlRequest:{[serviceName;body]
   hostName:.factomd.hostLookup[serviceName];
   credentials:`$.factomd.passLookup[serviceName];
   header:`$"Content-Type: text/plain";

   body:`$.j.j body;
   tlsCert:`$.factomd.tlsLookup[serviceName];
   host:$[`~tlsCert;`$1 _string[hostName];`$1 _ssr[string[hostName];"http";"https"]];

   out:@[.factomd.curl[host;body;header;tlsCert;];credentials;{[err] -2 "Error: curlRequest: ",err;:.j.j (enlist `error)!(enlist err)}];
   @[.j.k;;{[out;err] -2 "Error: ",err," curl returned: ",out;:(enlist `error)!(enlist out)}[out;]] out
 }

request:qRequest
\d .
