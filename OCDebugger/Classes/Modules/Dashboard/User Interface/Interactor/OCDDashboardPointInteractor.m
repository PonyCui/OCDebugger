//
//  OCDDashboardPointInteractor.m
//  OCDebugger
//
//  Created by 崔 明辉 on 15/6/11.
//  Copyright (c) 2015年 PonyCui. All rights reserved.
//

#import "OCDDashboardPointInteractor.h"
#import "OCDCore.h"

@implementation OCDDashboardPointInteractor

- (void)findItems {
    NSArray *items = [[[[OCDCore sharedCore] point] manager] allItems];
    NSMutableArray *itemInteractors = [NSMutableArray array];
    [items enumerateObjectsUsingBlock:^(OCDPointEntity *obj, NSUInteger idx, BOOL *stop) {
        OCDDashboardPointItemInteractor *itemInteractor = [[OCDDashboardPointItemInteractor alloc]
                                                           initWithItem:obj];
        [itemInteractors addObject:itemInteractor];
    }];
    self.items = itemInteractors;
    [self.delegate foundItems];
}

@end
