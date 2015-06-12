//
//  OCDFinderService.m
//  OCDebugger
//
//  Created by 崔 明辉 on 15/6/12.
//  Copyright (c) 2015年 PonyCui. All rights reserved.
//

#import "OCDFinderService.h"
#import "OCDCore.h"
#import "OCDValueFormatter.h"
#import <UIKit/UIKit.h>

@implementation OCDFinderService

- (void)commitShell:(NSDictionary *)params {
    if ([TOString(params[@"deviceIdentifier"]) isEqualToString:[[[UIDevice currentDevice] identifierForVendor] UUIDString]]) {
        NSString *result = [[[[OCDCore sharedCore] finder] manager] executeShell:TOString(params[@"shell"])];
        [[[[OCDCore sharedCore] socketService] pub]
         pubMessageToService:@"finder"
         method:@"updateResult"
         params:@{
                  @"deviceIdentifier": TOString([[[UIDevice currentDevice] identifierForVendor] UUIDString]),
                  @"result": TOString(result)
                  }];
    }
}

@end
