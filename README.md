## OCDebugger Introduce

[Chinese edition](https://github.com/PonyCui/OCDebugger/wiki/%E6%9C%80%E9%80%82%E5%90%88iOS%E5%BC%80%E5%8F%91%E8%80%85%E4%BD%BF%E7%94%A8%E7%9A%84%E8%B0%83%E8%AF%95%E5%B7%A5%E5%85%B7-OCDebugger)

In the iOS development process, an easy to use, efficient debugging tools for developers, can play a multiplier effect. I've used a lot of network packet capture tools including Fiddler, Paros, Charles, PonyDebugger, these tools have their own advantages, but there are some drawbacks.

Fiddler is developed using C #, does not work on mac installation of iOS developers, tasteless chant;

Paros is developed using Java, I always do not like Paros interface, and install configuration Paros is not easy；

Charles is friendly for developer, but still needs proxy setting.

Personally, I just hope I develop applications that run in the proxy server, when you quit the application, I hope to return to the real environment. Said capture tools have a common drawback is the need to install a fake cert to capture HTTPS connections, along with the increasing number https server arrangement, configure it will be quite troublesome.

For this reason, I also began to refer PonyDebugger developed new debugging tools OCDebugger, why should develop this tool? I think PonyDebugger been too long not updated, the functionality and experience have been behind the claim, and PonyDebugger also requires developers to install their own server application and use Chrome developer tools, is cumbersome.

## OCDebugger functionalities
### Network tools
1. Supports SSL (non-proxy mode), without generating a fake certificate you can capture all http / https requests.
2. Restful interface debug support (future might support Protobuf, WUP debugging), can be directly formatted JSON.
3. Support retransmission network requests and network requests are executed in real machine again.
4. Support modifying the network request parameters (Header, URL, Body, Method), modified retransmittable network requests.
5. Support the modification (Mapping) network requests, while supporting network returns the results to modify (Rewrite).
6. Hosts binding（/etc/hosts.

### Debug tool
1. NSLog() remotely and locally.
2. Debug Point
3. Finder view delete and fix sandbox files.

## OCDebugger Installing
### Use CocoaPods
add ```pod 'OCDebugger'``` to Podfile ,and pod install
### Request appid and apptoken
Use any kinds of web browser [Dashboard](http://ocdebugger.sinaapp.com/dashboard/) at the top-right side of Dashboard click "Request AppID", just wait a moment, you will gain your appid and apptoken, copy it.
### Configure
after Pod install ，at AppDelegate ```applicaton:didFinishLaunchingWithOptions:``` block,paste below code
```
[OCDebugger setAppID:@"yourappid" appToken:@"yourapptoken"];
[OCDebugger setEnabled:YES];
```
### View data
at Dashboard, click top-right side Change AppID，input your appid and apptoken, and then run your app。

## Use OCDebugeer helps iOS developer
### Sniff iPhone network connections
#### Sniffer
OCDebugger default will be all you http / https requests data to the server, you do not need other proxy settings. In the Dashboard, you can see something like the following information.

![](https://raw.githubusercontent.com/PonyCui/OCDebugger/master/README_Resources/1.png)

1. Device ID is your device ID, each device has a six-digit ID;
2. The table at the top of the input box to filter out results you want.
3. Tap Clear to empty all results

#### View Results
To see the specific results of the request, click on the corresponding Host or Path, pop-up layer has the Request, Response corresponding to the requested content, in response to the content, which respond to the contents if they meet the JSON format will be automatically converted into JSONEditor easy reading.

#### Modification request content and the retransmission request
Sometimes in order to debug the server's interface, we need to repeatedly request different network parameters. OCDebugger can be easily implemented modifications and retransmission function network requests.

1. To re-send the request to enter the corresponding request detailed results page, then click the Resend button.
2. To modify the corresponding request parameters, modify the corresponding parameter directly in the Request tab, and then click Resend can.
3. resend request will be successful red in the results list, enabling developers to easily distinguished.

#### Mapping Function
Mapping functions OCDebugger with Charles's Map feature to keep a hold, Mapping feature allows you to specify a network request is redirected to another URL.
HTTP Connections heading in the right side, there is a Modifier entry, click on it.

Then click "Create Mapping Rule", you can see the following dialog

![](https://raw.githubusercontent.com/PonyCui/OCDebugger/master/README_Resources/9.png)

We need to fill in each source and destination addresses of network redirection that do not need or do not need to modify the conditions of restrictions, empty it. The figure is an example, to redirect all requests to www.google.com www.github.com

#### Rewrite function
Rewrite functions are suitable to meet the requirements of network requests to be replaced (currently only supports simple search and replace, which only supports alternate return results).
You need to open the Modifier window, then click Rewrite tab, click on the "Create Rewrite Rule", you can see the following dialog

![](https://raw.githubusercontent.com/PonyCui/OCDebugger/master/README_Resources/10.png)

The figure is an example, we have the word of all requests result www.github.com under the domain name of GitHub replaced Hacked.

#### Attention

Note that, Mapping and Rewrite function after need to get data from the server to take effect, therefore, the application is started, there will be a brief unusable state (later versions will join the caching mechanism).

#### Hosts

To iOS real machine Specify the IP address for a domain name is not easy, even if the machine is jailbreak, use OCDebugger, just a word to complete the hosts bind.
```
[OCDebugger setHost:@"www.github.com" IPAddress:@"127.0.0.1"];
```

### Debug tools
#### remote and local NSLog()

Pony had used NSLog, DDLog, both of which are less than satisfactory, really does not use the USB connection to xcode, you want to look at the log is not easy. To this end, OCDebugger integrated log save, send to the server functionality, this feature is enabled by default.

To view the Log, only need to open the Dashboard, click the Online Deivces you want to view the Log of the machine you can be seen.

You can also see Log on real machine, at any interface, shake your iPhone, it will pop up actionSheet, select the Log button.

#### Point

Pony will often use this feature to achieve one thing, and that is the real machine interface, fast switching "formal environment" and "test environment", as the following code is a simple practice

```
- (BOOL)isTestEnvironment {
    OCDValuePoint(@"测试环境", YES);
    return NO;
}
```

When the need to switch the environment, shake iPhone, select Debug Point, you can turn on or off the test environment. Of course, Point of use is not limited thereto.

#### Finder

When developers want to view the application sandbox files, the most primitive way is to connect your phone to the Mac, using tools such ifunbox view.

We have no more simple way? OCDebugger default to support this feature, use the Dashboard, select the device to be operated in Online devices, select Finder tab, enter the command you want to execute the shell can be. ** Sandbox root directory is the home directory **

1. use ls list files
2. use rm delete files
3. use vi edit a file
4. use cd change path

OCDebugger only a small part of the package of useful commands, hope you like.

## Ending

Pony OCDebugger just outside working hours a little work, which, of course, there are many defects, welcomed the various proposed issue corrected, although considerable effort, but none of strict write a lot of code, it is inevitable dyslexia.

Before you apply on-line, be sure to OCDebugger removed from Podfile file and execute pod update.

Pony will continue to develop OCDebugger, added more features.

## Reference

1. 《iOS开发进阶》第3章 唐巧 著。
