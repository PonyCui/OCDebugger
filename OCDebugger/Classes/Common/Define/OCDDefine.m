

//
//  OCDDefine.m
//  OCDebugger
//
//  Created by 崔 明辉 on 15/6/8.
//  Copyright (c) 2015年 PonyCui. All rights reserved.
//

#import "OCDDefine.h"

@implementation OCDDefine

+ (OCDDefine *)sharedDefine {
    static OCDDefine *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[OCDDefine alloc] init];
    });
    return instance;
}

- (OCDHTTPWatcherDefine *)HTTPWatcher {
    if (_HTTPWatcher == nil) {
        _HTTPWatcher = [[OCDHTTPWatcherDefine alloc] init];
    }
    return _HTTPWatcher;
}

- (NSString *)socketAddressRequestURLString {
//    return @"http://localhost/OCDServer/index.php/pubsub/index";
    return @"http://ocdebugger.sinaapp.com/index.php/pubsub/index";
}

@end
