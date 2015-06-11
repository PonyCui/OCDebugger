//
//  OCDDashboardPointItemInteractor.m
//  OCDebugger
//
//  Created by 崔 明辉 on 15/6/11.
//  Copyright (c) 2015年 PonyCui. All rights reserved.
//

#import "OCDDashboardPointItemInteractor.h"
#import "OCDPointEntity.h"
#import "OCDCore.h"

@interface OCDDashboardPointItemInteractor ()

@property (nonatomic, strong) OCDPointEntity *item;

@end

@implementation OCDDashboardPointItemInteractor

- (instancetype)initWithItem:(OCDPointEntity *)item
{
    self = [super init];
    if (self) {
        _item = item;
        _title = item.pointIdentifier;
        if (item.pointObject != nil) {
            _subTitle = [NSString stringWithFormat:@"Object:%@", [item.pointObject description]];
        }
        else {
            _subTitle = [NSString stringWithFormat:@"Value:%ld", (long)item.pointValue];
        }
        _isOn = item.isValid;
    }
    return self;
}

- (void)setIsOn:(BOOL)isOn {
    _isOn = isOn;
    [[[[[OCDCore sharedCore] point] manager] pointWithIdentifier:self.item.pointIdentifier] setIsValid:_isOn];
}

@end
