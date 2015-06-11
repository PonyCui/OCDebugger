//
//  OCDDashboardHookManager.m
//  OCDebugger
//
//  Created by 崔 明辉 on 15/6/11.
//  Copyright (c) 2015年 PonyCui. All rights reserved.
//

#import "OCDDashboardHookManager.h"
#import "OCDDashboardShakeHooker.h"

@interface OCDDashboardHookManager ()

@property (nonatomic, strong) OCDDashboardShakeHooker *shakeHooker;

@end

@implementation OCDDashboardHookManager

- (void)registerHooks {
    [self.shakeHooker install];
}

- (void)unregister {
    [self.shakeHooker uninstall];
}

#pragma mark - Getter

- (OCDDashboardShakeHooker *)shakeHooker {
    if (_shakeHooker == nil) {
        _shakeHooker = [[OCDDashboardShakeHooker alloc] init];
    }
    return _shakeHooker;
}

@end
