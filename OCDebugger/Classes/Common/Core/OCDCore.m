//
//  OCDCore.m
//  OCDebugger
//
//  Created by 崔 明辉 on 15/6/8.
//  Copyright (c) 2015年 PonyCui. All rights reserved.
//

#import "OCDCore.h"

@implementation OCDCore

+ (OCDCore *)sharedCore {
    static OCDCore *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[OCDCore alloc] init];
    });
    return instance;
}

- (OCDHTTPWatcherCore *)HTTPWatcher {
    if (_HTTPWatcher == nil) {
        _HTTPWatcher = [[OCDHTTPWatcherCore alloc] init];
    }
    return _HTTPWatcher;
}

- (OCDPointCore *)point {
    if (_point == nil) {
        _point = [[OCDPointCore alloc] init];
    }
    return _point;
}

- (OCDDashboardCore *)dashboard {
    if (_dashboard == nil) {
        _dashboard = [[OCDDashboardCore alloc] init];
    }
    return _dashboard;
}

- (OCDSocketServiceManager *)socketService {
    if (_socketService == nil) {
        _socketService = [[OCDSocketServiceManager alloc] init];
    }
    return _socketService;
}

@end
