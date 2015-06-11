//
//  OCDDashboardPointInteractor.h
//  OCDebugger
//
//  Created by 崔 明辉 on 15/6/11.
//  Copyright (c) 2015年 PonyCui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OCDDashboardPointItemInteractor.h"

@protocol OCDDashboardPointInteractorDelegate <NSObject>

- (void)foundItems;

@end

@interface OCDDashboardPointInteractor : NSObject

@property (nonatomic, weak) id<OCDDashboardPointInteractorDelegate> delegate;

@property (nonatomic, copy) NSArray *items;

- (void)findItems;

@end
