//
//  OCDPubService.m
//  OCDebugger
//
//  Created by 崔 明辉 on 15/6/9.
//  Copyright (c) 2015年 PonyCui. All rights reserved.
//

#import "OCDPubService.h"
#import "OCDProtocolHelper.h"
#import "OCDValueFormatter.h"
#import "OCDCore.h"

@interface OCDPubService ()

@property (nonatomic, copy) NSArray *disconnectStoreObjects;

@property (nonatomic, strong) NSTimer *retryTimer;

@end

@implementation OCDPubService

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.retryTimer = [NSTimer scheduledTimerWithTimeInterval:2.0
                                                           target:self
                                                         selector:@selector(handleRetryTimerTrigger)
                                                         userInfo:nil
                                                          repeats:YES];
    }
    return self;
}

- (void)pubMessageToService:(NSString *)service method:(NSString *)method params:(NSDictionary *)params {
    NSString *message = [OCDProtocolHelper messageWithService:@"pub"
                                                       method:@"submit"
                                                       params:@{
                                                                @"service": TOString(service),
                                                                @"method": TOString(method),
                                                                @"params": TODictionary(params)
                                                                }];
    if ([[[[OCDCore sharedCore] socketService] sub] isObserverAdded]) {
        [self pubStoreMessages];
        [[[[OCDCore sharedCore] socketService] conn] sendMessage:message];
    }
    else {
        [self addMessageToStore:message];
    }
}

- (void)handleRetryTimerTrigger {
    if ([[[[OCDCore sharedCore] socketService] sub] isObserverAdded] &&
        [self.disconnectStoreObjects count] > 0) {
        [self pubStoreMessages];
    }
}

- (void)pubStoreMessages {
    [self.disconnectStoreObjects enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [[[[OCDCore sharedCore] socketService] conn] sendMessage:obj];
    }];
    self.disconnectStoreObjects = @[];
}

- (void)addMessageToStore:(NSString *)message {
    if (message != nil) {
        NSMutableArray *stores = [[self disconnectStoreObjects] mutableCopy];
        [stores addObject:message];
        self.disconnectStoreObjects = stores;
    }
}

#pragma mark - Getter

- (NSArray *)disconnectStoreObjects {
    if (_disconnectStoreObjects == nil) {
        _disconnectStoreObjects = @[];
    }
    return _disconnectStoreObjects;
}

@end
