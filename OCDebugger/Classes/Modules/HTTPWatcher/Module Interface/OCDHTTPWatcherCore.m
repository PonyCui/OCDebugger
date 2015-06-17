//
//  OCDHTTPWatcherCore.m
//  OCDebugger
//
//  Created by 崔 明辉 on 15/6/8.
//  Copyright (c) 2015年 PonyCui. All rights reserved.
//

#import "OCDHTTPWatcherCore.h"

@implementation OCDHTTPWatcherCore

- (void)install {
    [self.connectionManager registerHookers];
}

- (void)uninstall {
    [self.connectionManager unregisterHookers];
}

#pragma mark - Getter

- (OCDHTTPWatcherConnectionManager *)connectionManager {
    if (_connectionManager == nil) {
        _connectionManager = [[OCDHTTPWatcherConnectionManager alloc] init];
    }
    return _connectionManager;
}

- (OCDHTTPWatcherHostsManager *)hostsManager {
    if (_hostsManager == nil) {
        _hostsManager = [[OCDHTTPWatcherHostsManager alloc] init];
    }
    return _hostsManager;
}

- (OCDHTTPWatcherModifierManager *)modifierManager {
    if (_modifierManager == nil) {
        _modifierManager = [[OCDHTTPWatcherModifierManager alloc] init];
    }
    return _modifierManager;
}

@end
