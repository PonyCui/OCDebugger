//
//  OCDFinderCore.m
//  OCDebugger
//
//  Created by 崔 明辉 on 15/6/12.
//  Copyright (c) 2015年 PonyCui. All rights reserved.
//

#import "OCDFinderCore.h"

@implementation OCDFinderCore

- (OCDFinderManager *)manager {
    if (_manager == nil) {
        _manager = [[OCDFinderManager alloc] init];
    }
    return _manager;
}

@end
