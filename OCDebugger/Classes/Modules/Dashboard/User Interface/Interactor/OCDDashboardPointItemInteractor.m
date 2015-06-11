//
//  OCDDashboardPointItemInteractor.m
//  OCDebugger
//
//  Created by 崔 明辉 on 15/6/11.
//  Copyright (c) 2015年 PonyCui. All rights reserved.
//

#import "OCDDashboardPointItemInteractor.h"
#import "OCDPointEntity.h"

@implementation OCDDashboardPointItemInteractor

- (instancetype)initWithItem:(OCDPointEntity *)item
{
    self = [super init];
    if (self) {
        self.title = item.pointIdentifier;
        if (item.pointObject != nil) {
            self.subTitle = [NSString stringWithFormat:@"Object:%@", [item.pointObject description]];
        }
        else {
            self.subTitle = [NSString stringWithFormat:@"Value:%ld", (long)item.pointValue];
        }
        self.isOn = item.isValid;
    }
    return self;
}

@end
