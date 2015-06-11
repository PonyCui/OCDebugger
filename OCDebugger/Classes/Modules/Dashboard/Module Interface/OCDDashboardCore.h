//
//  OCDDashboardCore.h
//  OCDebugger
//
//  Created by 崔 明辉 on 15/6/11.
//  Copyright (c) 2015年 PonyCui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OCDDashboardHookManager.h"
#import "OCDDashboardWireframe.h"

@interface OCDDashboardCore : NSObject

@property (nonatomic, strong) OCDDashboardHookManager *hookManager;

@property (nonatomic, strong) OCDDashboardWireframe *wireframe;

- (void)install;

- (void)uninstall;

@end
