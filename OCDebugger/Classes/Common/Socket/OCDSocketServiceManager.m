//
//  PPMSyncSocketServiceManager.m
//  PonyMessenger
//
//  Created by 崔 明辉 on 15/4/1.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "OCDSocketServiceManager.h"
#import "OCDConnService.h"
#import "PPMSyncSubService.h"
#import "PPMSyncTestService.h"
#import "PPMSyncUserService.h"
#import "PPMSyncChatService.h"

@implementation OCDSocketServiceManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        _conn = [[OCDConnService alloc] init];
        _sub = [[PPMSyncSubService alloc] init];
        _test = [[PPMSyncTestService alloc] init];
        _user = [[PPMSyncUserService alloc] init];
        _chat = [[PPMSyncChatService alloc] init];
    }
    return self;
}

@end
