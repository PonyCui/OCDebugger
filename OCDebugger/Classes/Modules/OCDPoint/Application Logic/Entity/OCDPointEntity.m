//
//  OCDPointEntity.m
//  OCDebugger
//
//  Created by 崔 明辉 on 15/6/10.
//  Copyright (c) 2015年 PonyCui. All rights reserved.
//

#import "OCDPointEntity.h"
#import "OCDValueFormatter.h"

@implementation OCDPointEntity

- (NSDictionary *)toDictionary {
    return @{
             @"pointIdentifier": TOString(self.pointIdentifier),
             @"pointValue": @(self.pointValue),
             @"pointObject": TOString([self.pointObject description]),
             @"isValid": @(self.isValid)
             };
}

@end
