//
//  OCDHTTPWatcherConnectionManager.m
//  OCDebugger
//
//  Created by 崔 明辉 on 15/6/8.
//  Copyright (c) 2015年 PonyCui. All rights reserved.
//

#import "OCDHTTPWatcherConnectionManager.h"
#import "OCDHTTPWatcherURLProtocol.h"
#import "OCDHTTPWatcherResponseHooker.h"
#import "OCDHTTPWatcherConnectionEntity.h"
#import "OCDCore.h"
#import <Aspects/Aspects.h>

@interface OCDHTTPWatcherConnectionManager ()

@property (nonatomic, strong) OCDHTTPWatcherResponseHooker *responseHooker;

@end

@implementation OCDHTTPWatcherConnectionManager

- (void)registerHookers {
    [NSURLProtocol registerClass:[OCDHTTPWatcherURLProtocol class]];
    [self.responseHooker install];
}

- (void)unregisterHookers {
    [NSURLProtocol unregisterClass:[OCDHTTPWatcherURLProtocol class]];
    [self.responseHooker uninstall];
}

- (void)deliverItem:(OCDHTTPWatcherConnectionEntity *)item {
    [[[[OCDCore sharedCore] socketService] pub] pubMessageToService:@"HTTPWatcher"
                                                             method:@"connection"
                                                             params:[item toDictionary]];
}

#pragma mark - Getter

- (OCDHTTPWatcherResponseHooker *)responseHooker {
    if (_responseHooker == nil) {
        _responseHooker = [[OCDHTTPWatcherResponseHooker alloc] init];
    }
    return _responseHooker;
}

@end
