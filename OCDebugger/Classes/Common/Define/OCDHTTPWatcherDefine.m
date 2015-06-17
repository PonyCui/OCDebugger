//
//  OCDHTTPWatcherDefine.m
//  OCDebugger
//
//  Created by 崔 明辉 on 15/6/8.
//  Copyright (c) 2015年 PonyCui. All rights reserved.
//

#import "OCDHTTPWatcherDefine.h"
#import "OCDCore.h"
#import "OCDDefine.h"

@implementation OCDHTTPWatcherDefine

- (void)setEnabled:(BOOL)enabled {
    _enabled = enabled;
    _enabled ? [[[OCDCore sharedCore] HTTPWatcher] install] : [[[OCDCore sharedCore] HTTPWatcher] uninstall];
}

- (NSString *)modifierRequestURLString {
    return [NSString stringWithFormat:@"http://localhost/OCDServer/index.php/modifier/fetch?appid=%@&apptoken=%@",
            [[OCDDefine sharedDefine] appID],
            [[OCDDefine sharedDefine] appToken]];
}

@end
