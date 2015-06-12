//
//  OCDHTTPWatcherHostsManager.h
//  OCDebugger
//
//  Created by 崔 明辉 on 15/6/12.
//  Copyright (c) 2015年 PonyCui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OCDHTTPWatcherHostEntity.h"

@class OCDHTTPWatcherHostEntity;

@interface OCDHTTPWatcherHostsManager : NSObject

- (void)addHostItem:(OCDHTTPWatcherHostEntity *)item;

- (NSURLRequest *)hostedRequestWithRequest:(NSURLRequest *)originRequest;

@end
