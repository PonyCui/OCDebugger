//
//  PPMSyncSocketServiceManager.m
//  PonyMessenger
//
//  Created by 崔 明辉 on 15/4/1.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "OCDSocketServiceManager.h"
#import "OCDConnService.h"
#import "OCDSubService.h"

@implementation OCDSocketServiceManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        _conn = [[OCDConnService alloc] init];
        _sub = [[OCDSubService alloc] init];
    }
    return self;
}

@end
