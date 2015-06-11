//
//  OCDDashboardPointPresenter.h
//  OCDebugger
//
//  Created by 崔 明辉 on 15/6/11.
//  Copyright (c) 2015年 PonyCui. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OCDDashboardPointViewController, OCDDashboardPointInteractor;

@interface OCDDashboardPointPresenter : NSObject

@property (nonatomic, weak) OCDDashboardPointViewController *userInterface;

@property (nonatomic, strong) OCDDashboardPointInteractor *pointInteractor;

- (void)updateView;

@end
