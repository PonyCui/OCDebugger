//
//  OCDHTTPWatcherConnectionManager.m
//  OCDebugger
//
//  Created by 崔 明辉 on 15/6/8.
//  Copyright (c) 2015年 PonyCui. All rights reserved.
//

#import "OCDHTTPWatcherConnectionManager.h"
#import "OCDHTTPWatcherURLProtocol.h"
#import "OCDHTTPWatcherConnectionEntity.h"
#import "OCDCore.h"
#import <Aspects/Aspects.h>

@interface OCDHTTPWatcherConnectionManager ()

@end

@implementation OCDHTTPWatcherConnectionManager

- (void)registerHookers {
    [NSURLProtocol registerClass:[OCDHTTPWatcherURLProtocol class]];
}

- (void)unregisterHookers {
    [NSURLProtocol unregisterClass:[OCDHTTPWatcherURLProtocol class]];
}

- (void)deliverItem:(OCDHTTPWatcherConnectionEntity *)item {
    [[[[OCDCore sharedCore] socketService] pub] pubMessageToService:@"HTTPWatcher"
                                                             method:@"connection"
                                                             params:[item toDictionary]];
}

@end
