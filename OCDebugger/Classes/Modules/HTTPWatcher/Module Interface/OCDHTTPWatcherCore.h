//
//  OCDHTTPWatcherCore.h
//  OCDebugger
//
//  Created by 崔 明辉 on 15/6/8.
//  Copyright (c) 2015年 PonyCui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OCDHTTPWatcherConnectionManager.h"
#import "OCDHTTPWatcherHostsManager.h"
#import "OCDHTTPWatcherModifierManager.h"

@interface OCDHTTPWatcherCore : NSObject

@property (nonatomic, strong) OCDHTTPWatcherConnectionManager *connectionManager;

@property (nonatomic, strong) OCDHTTPWatcherHostsManager *hostsManager;

@property (nonatomic, strong) OCDHTTPWatcherModifierManager *modifierManager;

- (void)install;

- (void)uninstall;

@end
