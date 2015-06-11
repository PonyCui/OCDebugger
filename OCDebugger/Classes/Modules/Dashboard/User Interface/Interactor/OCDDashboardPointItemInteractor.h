//
//  OCDDashboardPointItemInteractor.h
//  OCDebugger
//
//  Created by 崔 明辉 on 15/6/11.
//  Copyright (c) 2015年 PonyCui. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OCDPointEntity;

@interface OCDDashboardPointItemInteractor : NSObject

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *subTitle;

@property (nonatomic, assign) BOOL isOn;

- (instancetype)initWithItem:(OCDPointEntity *)item;

@end
