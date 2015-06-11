//
//  OCDPointService.m
//  OCDebugger
//
//  Created by 崔 明辉 on 15/6/10.
//  Copyright (c) 2015年 PonyCui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OCDPointService.h"
#import "OCDCore.h"
#import "OCDValueFormatter.h"

@implementation OCDPointService

- (void)requestPoints {
    NSMutableArray *dataItems = [NSMutableArray array];
    NSArray *items = [[[[OCDCore sharedCore] point] manager] allItems];
    [items enumerateObjectsUsingBlock:^(OCDPointEntity *obj, NSUInteger idx, BOOL *stop) {
        [dataItems addObject:TODictionary([obj toDictionary])];
    }];
    [[[[OCDCore sharedCore] socketService] pub]
     pubMessageToService:@"point"
     method:@"updatePoints"
     params:@{
              @"deviceIdentifier": TOString([[[UIDevice currentDevice] identifierForVendor] UUIDString]),
              @"points": dataItems
              }];
}

- (void)validPoint:(NSDictionary *)params {
    NSString *pointIdentifier = TOString(params[@"id"]);
    [[[[[OCDCore sharedCore] point] manager] pointWithIdentifier:pointIdentifier] setIsValid:YES];
}

- (void)invalidPoint:(NSDictionary *)params {
    NSString *pointIdentifier = TOString(params[@"id"]);
    [[[[[OCDCore sharedCore] point] manager] pointWithIdentifier:pointIdentifier] setIsValid:NO];
}

@end
