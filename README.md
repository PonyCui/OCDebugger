# OCDebugger
OCDebugger is an easy to use debugging toolset. You use OCDebugger debug your application on Web or iPhone. It's a client library and we provide an web application (OCDServer) holding all connection from iOS. Also, we provide a public web application here xxx, please feel free to use it, it's really stable.

Unlink **PonyDebugger**, OCDebugger don't requires open Chrome Developer Tools, you may debug your application using Safari, Chrome, Firefox, or even IE10+ .

OCDebugger is licensed under MIT.

## Features

### HTTP Watcher (Network Traffic Debugging)
OCDebugger use NSURLProtocol sniff all network connections. All you need to do is, open web application, wait for the connection information comes.

xxx

OCDebugger use Foundation Framework sniff network traffic. This means that all http/https is debuggable.
And, all trading network library can be sniffer by OCDebugger including ```AFNetworking```/```SDWebImage``` etc. But, if network library use ```CFNetwork``` C++ function, OCDebugger HTTP Watcher will have no effects.

OCDebugger will handle less 32K response data, and send to server, web application will try to convert JSON into pretty style. The request header and response header are also handled.
