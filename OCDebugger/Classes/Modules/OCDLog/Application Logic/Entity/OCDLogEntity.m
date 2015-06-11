//
//  OCDLogEntity.m
//  OCDebugger
//
//  Created by 崔 明辉 on 15/6/11.
//  Copyright (c) 2015年 PonyCui. All rights reserved.
//

#import "OCDLogEntity.h"
#import "OCDValueFormatter.h"
#import <UIKit/UIKit.h>

@implementation OCDLogEntity

- (NSDictionary *)toDictionary {
    return @{
             @"deviceIdentifier": TOString([[[UIDevice currentDevice] identifierForVendor] UUIDString]),
             @"logFileName": TOString(self.logFileName),
             @"logFunctionName": TOString(self.logFunctionName),
             @"logLineNumber": TOString(self.logLineNumber),
             @"logBody": TOString(self.logBody)
             };
}

@end
