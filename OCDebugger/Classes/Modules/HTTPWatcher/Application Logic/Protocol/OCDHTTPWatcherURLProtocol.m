//
//  OCDHTTPWatcherConnectionProtocol.m
//  OCDebugger
//
//  Created by 崔 明辉 on 15/6/8.
//  Copyright (c) 2015年 PonyCui. All rights reserved.
//

#import "OCDHTTPWatcherURLProtocol.h"
#import "OCDHTTPWatcherConnectionEntity.h"
#import "OCDCore.h"

@implementation OCDHTTPWatcherURLProtocol

+ (BOOL)canInitWithRequest:(NSURLRequest *)request {
    OCDHTTPWatcherConnectionEntity *connectionItem = [[OCDHTTPWatcherConnectionEntity alloc]
                                                      initWithReqeust:request];
    [[[[OCDCore sharedCore] HTTPWatcher] connectionManager] deliverItem:connectionItem];
    return NO;
}

@end
