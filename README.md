# OCDebugger
OCDebugger is an easy to use debugging toolset. You use OCDebugger debug your application on Web or iPhone. It's a client library and we provide an web application (OCDServer) holding all connection from iOS. Also, we provide a public web application here xxx, please feel free to use it, it's really stable.

Unlink **PonyDebugger**, OCDebugger don't requires open Chrome Developer Tools, you may debug your application using Safari, Chrome, Firefox, or even IE10+ .

OCDebugger is licensed under MIT.

## Features

### Remote and Local Dashboard

To read debug data, you can shake your mobile phone any time, or use PC/Mac open web application (http://xxxx.com)

![](https://raw.githubusercontent.com/PonyCui/OCDebugger/master/README_Resources/0.png)

### HTTP Watcher (Network Traffic Debugging)
OCDebugger use NSURLProtocol sniff all network connections. All you need to do is, open web application, wait for the connection information comes.

![](https://raw.githubusercontent.com/PonyCui/OCDebugger/master/README_Resources/1.png)

OCDebugger use Foundation Framework sniff network traffic. This means that all http/https is debuggable.
And, all trading network library can be sniffer by OCDebugger including ```AFNetworking```/```SDWebImage``` etc. But, if network library use ```CFNetwork``` C++ function, OCDebugger HTTP Watcher will have no effects.

![](https://raw.githubusercontent.com/PonyCui/OCDebugger/master/README_Resources/2.png)
![](https://raw.githubusercontent.com/PonyCui/OCDebugger/master/README_Resources/3.png)

OCDebugger will handle less 32K response data, and send to server, web application will try to convert JSON into pretty style. The request header and response header are also handled.

### Remote and Local Logging
OCDebugger makes logging much easier than you thing. You ```#import "OCDebugger.h"``` into prefix header file. That's enough. All NSLog() message will send to server and save in local.
And we eager to do more, we want to debug like ```lldb```, and we will finish it next version.

_**All logging is realtime transferring.**_

![](https://raw.githubusercontent.com/PonyCui/OCDebugger/master/README_Resources/4.png)
![](https://raw.githubusercontent.com/PonyCui/OCDebugger/master/README_Resources/5.png)

### Debug Point
OCDebugger invent a way to debug faster, the Debug Point! We call it Point.
If you want to replace a variable while running an app, how can you do with that? Maybe you will setup an remote server, set a JSON mapping file? Maybe you will use local code to perform it?
Here is an example.
```
- (BOOL)testPoint {
    OCDValuePoint(@"test", YES);
    return NO;
}

- (NSString *)testText {
    OCDObjectPoint(@"How", @"How?");
    return @"What?";
}
```
We add point into ```testPoint``` and ```testText``` method, and then, if we make Point valid, it will return the assigning value or object.
The difference of ```OCDValuePoint``` and ```OCDObjectPoint``` is, ```OCDValuePoint``` returns bool/int value, ```OCDObjectPoint``` returns NSObject.

We use local or remote control make Point valid or invalid.
![](https://raw.githubusercontent.com/PonyCui/OCDebugger/master/README_Resources/6.png)
![](https://raw.githubusercontent.com/PonyCui/OCDebugger/master/README_Resources/7.png)
