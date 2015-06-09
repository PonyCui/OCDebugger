//
//  OCDDeviceService.m
//  OCDebugger
//
//  Created by 崔 明辉 on 15/6/9.
//  Copyright (c) 2015年 PonyCui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OCDDeviceService.h"
#import "OCDValueFormatter.h"
#import "OCDCore.h"

@interface OCDDeviceService ()

@property (nonatomic, strong) NSTimer *updateTimer;

@end

@implementation OCDDeviceService

- (instancetype)init
{
    self = [super init];
    if (self) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.updateTimer = [NSTimer scheduledTimerWithTimeInterval:15.0 target:self selector:@selector(handleUpdateTimerTrigger) userInfo:nil repeats:YES];
        });
    }
    return self;
}

- (void)handleUpdateTimerTrigger {
    [[[[OCDCore sharedCore] socketService] pub]
     pubMessageToService:@"device"
     method:@"updateDevice"
     params:@{
              @"deviceIdentifier": TOString([[[UIDevice currentDevice] identifierForVendor] UUIDString]),
              @"deviceName": TOString([[UIDevice currentDevice] name]),
              @"deviceSystemVersion": TOString([[UIDevice currentDevice] systemVersion]),
              @"deviceModel": TOString([[UIDevice currentDevice] model])
              }];
}

@end
