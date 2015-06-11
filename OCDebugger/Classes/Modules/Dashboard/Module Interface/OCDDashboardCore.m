//
//  OCDDashboardCore.m
//  OCDebugger
//
//  Created by 崔 明辉 on 15/6/11.
//  Copyright (c) 2015年 PonyCui. All rights reserved.
//

#import "OCDDashboardCore.h"

@implementation OCDDashboardCore

- (void)install {
    [self.hookManager registerHooks];
}

- (void)uninstall {
    [self.hookManager unregister];
}

#pragma mark - Getter

- (OCDDashboardHookManager *)hookManager {
    if (_hookManager == nil) {
        _hookManager = [[OCDDashboardHookManager alloc] init];
    }
    return _hookManager;
}

- (OCDDashboardWireframe *)wireframe {
    if (_wireframe == nil) {
        _wireframe = [[OCDDashboardWireframe alloc] init];
    }
    return _wireframe;
}

@end
