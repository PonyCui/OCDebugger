//
//  OCDHTTPWatcherDefine.m
//  OCDebugger
//
//  Created by 崔 明辉 on 15/6/8.
//  Copyright (c) 2015年 PonyCui. All rights reserved.
//

#import "OCDHTTPWatcherDefine.h"
#import "OCDCore.h"

@implementation OCDHTTPWatcherDefine

- (void)setEnabled:(BOOL)enabled {
    _enabled = enabled;
    _enabled ? [[[OCDCore sharedCore] HTTPWatcher] install] : [[[OCDCore sharedCore] HTTPWatcher] uninstall];
}

@end
