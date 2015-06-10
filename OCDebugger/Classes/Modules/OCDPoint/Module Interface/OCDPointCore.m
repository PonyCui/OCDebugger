//
//  OCDPointCore.m
//  OCDebugger
//
//  Created by 崔 明辉 on 15/6/10.
//  Copyright (c) 2015年 PonyCui. All rights reserved.
//

#import "OCDPointCore.h"

@implementation OCDPointCore

#pragma mark - Getter

- (OCDPointManager *)manager {
    if (_manager == nil) {
        _manager = [[OCDPointManager alloc] init];
    }
    return _manager;
}

@end
