
/**
 This file should be copy to your project independ of Pods directory.
 It helps you to prevent any build error while OCDebugger removed.
 Caution: I don't recommend you put OCDebugger into production, before you release application, OCDebugger should be remove from CocoaPods and execute 'pod update'.
 **/

#ifndef OCDValuePoint
#define OCDValuePoint(...) {}
#endif

#ifndef OCDObjectPoint
#define OCDObjectPoint(...) {}
#endif