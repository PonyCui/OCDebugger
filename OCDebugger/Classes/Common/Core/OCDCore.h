//
//  OCDCore.h
//  OCDebugger
//
//  Created by 崔 明辉 on 15/6/8.
//  Copyright (c) 2015年 PonyCui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OCDHTTPWatcherCore.h"
#import "OCDSocketServiceManager.h"
#import "OCDPointCore.h"
#import "OCDDashboardCore.h"

@interface OCDCore : NSObject

+ (OCDCore *)sharedCore;

@property (nonatomic, strong) OCDHTTPWatcherCore *HTTPWatcher;

@property (nonatomic, strong) OCDPointCore *point;

@property (nonatomic, strong) OCDDashboardCore *dashboard;

@property (nonatomic, strong) OCDSocketServiceManager *socketService;

@end
