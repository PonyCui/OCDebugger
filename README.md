# OCDebugger

[Chinese README](https://github.com/PonyCui/OCDebugger/wiki/%E4%B8%AD%E6%96%87%E6%8C%87%E5%BC%95)

OCDebugger is an easy to use debugging toolset. You use OCDebugger debug your application on Web or iPhone. It's a client library and we provide an web application (OCDServer) holding all connection from iOS. Also, we provide a public web application here [Open link](http://ocdebugger.sinaapp.com/dashboard/index.html?access=1,testToken), please feel free to use it, it's really stable.

Unlike **PonyDebugger**, OCDebugger don't requires open Chrome Developer Tools, you may debug your application using Safari, Chrome, Firefox, or even IE10+ .

OCDebugger is licensed under MIT.

## Features

### Remote and Local Dashboard

To read debug data, you can shake your mobile phone any time, or use PC/Mac open web application [Open link](http://ocdebugger.sinaapp.com/dashboard/index.html?access=1,testToken)

![](https://raw.githubusercontent.com/PonyCui/OCDebugger/master/README_Resources/0.png)

### HTTP Watcher (Network Traffic Debugging)
OCDebugger use NSURLProtocol sniff all network connections. All you need to do is, open web application, wait for the connection information comes.

![](https://raw.githubusercontent.com/PonyCui/OCDebugger/master/README_Resources/1.png)

OCDebugger use Foundation Framework sniff network traffic. This means that all http/https is debuggable.
And, all trading network library can be sniffer by OCDebugger including ```AFNetworking```/```SDWebImage``` etc. But, if network library use ```CFNetwork``` C++ function, OCDebugger HTTP Watcher will have no effects.

![](https://raw.githubusercontent.com/PonyCui/OCDebugger/master/README_Resources/2.png)
![](https://raw.githubusercontent.com/PonyCui/OCDebugger/master/README_Resources/3.png)

OCDebugger will handle less 32K response data, and send to server, web application will try to convert JSON into pretty style. The request header and response header are also handled.

You can change the Request Header or Request Body, click Resend button, make a different request again.

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

### Finder
OCDebugger can operate file using shell like interface. The following cmd is supported.

```
cd..    cd directory     cd /

ls      ls directory

rm file     rm directory     rm *

vi file     use :w save changes     use :q quit vi mode

clear
```

![](https://raw.githubusercontent.com/PonyCui/OCDebugger/master/README_Resources/8.png)

### More
We eager to develop more function to every developer. Please star OCDebugger, keep eyes with me. Thanks.

##Installation

###Technical
* Requeires iOS 6.0 or above (but I didn't test under iOS6)
* Xcode 6.3

###Installing
####CocoaPods
[CocoaPods](http://cocoapods.org/) automates 3rd party dependencies in
Objective-C.

Install the ruby gem.

    $ sudo gem install cocoapods
    $ pod setup

> Depending on your Ruby installation, you may not have to run as sudo to
> install the cocoapods gem.

Create a Podfile. You must be running on iOS 6 or above.

    platform :ios, '6.0'
    pod 'OCDebugger'

If you would like to use the latest version of PonyDebugger, point to the Github
repository directly.

    pod 'OCDebugger', :git => 'https://github.com/PonyCui/OCDebugger.git'

Install dependencies.

    $ pod install

When using CocoaPods, you must open the `.xcworkspace` file instead of the
project file when building your project.

####Manual
No recommend use manual installing.

##Usage

Copy ```OCDPrefixHeader.h``` to your project manually, it should not depend of Pods directory.

import ```OCDebugger.h``` and ```OCDPrefixHeader.h``` to your project prefix header file.

Go to web application [Open link](http://ocdebugger.sinaapp.com/dashboard/index.html?access=1,testToken) , request an appid.

Type following code in any where you want.(Recommend applicaton:didFinishLaunchingWithOptions:)
```
[OCDebugger setAppID:@"yourappid" appToken:@"yourapptoken"];
[OCDebugger setEnabled:YES];
```

Enjoy now.

## Caution

Before you release your application, you must remove ```OCDebugger```, and ```pod update```.
OCDebugger is not a production environment library.

## TODO

There are still lots of issue we should resolve, here is a listing.
1. WebSocket can't transfer large size content, and SAE limit it's 16K, so I'm trying to solve this problem.
2. Finder request and response too slow, because PHP limit sleep() 1s per time, so I'm trying to fix it.
