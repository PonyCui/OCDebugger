//
//  OCDebugger.m
//  OCDebugger
//
//  Created by 崔 明辉 on 15/6/8.
//  Copyright (c) 2015年 PonyCui. All rights reserved.
//

#import "OCDebugger.h"
#import "OCDCore.h"
#import "OCDDefine.h"
#import "OCDHTTPWatcherMappingEntity.h"

static BOOL isEnabled;

@implementation OCDebugger

+ (void)setAppID:(NSString *)appID appToken:(NSString *)appToken {
    [[OCDDefine sharedDefine] setAppID:appID];
    [[OCDDefine sharedDefine] setAppToken:appToken];
}

+ (void)setEnabled:(BOOL)enabled {
    isEnabled = enabled;
    if (enabled) {
        [[[OCDDefine sharedDefine] HTTPWatcher] setEnabled:YES];
        [[[[OCDCore sharedCore] socketService] conn] connect];
        [[[OCDCore sharedCore] dashboard] install];
        [[[OCDCore sharedCore] log] setEnabled:YES];
        [[[[OCDCore sharedCore] HTTPWatcher] modifierManager] fetchModifiers];
    }
    else {
        [[[OCDDefine sharedDefine] HTTPWatcher] setEnabled:NO];
        [[[[OCDCore sharedCore] socketService] conn] disconnect];
        [[[OCDCore sharedCore] dashboard] uninstall];
        [[[OCDCore sharedCore] log] setEnabled:NO];
    }
}

+ (void)setHost:(NSString *)theHost IPAddress:(NSString *)theIPAddress {
    OCDHTTPWatcherHostEntity *item = [[OCDHTTPWatcherHostEntity alloc] init];
    item.domain = theHost;
    item.hostIP = theIPAddress;
    [[[[OCDCore sharedCore] HTTPWatcher] hostsManager] addHostItem:item];
}

+ (void)addPointWithIdentifier:(NSString *)identifier pointValue:(NSInteger)pointValue pointObject:(id)pointObject {
    OCDPointEntity *pointItem = [[OCDPointEntity alloc] init];
    pointItem.pointIdentifier = identifier;
    pointItem.pointValue = pointValue;
    pointItem.pointObject = pointObject;
    [[[[OCDCore sharedCore] point] manager] addPointItem:pointItem];
}

+ (BOOL)isPointValid:(NSString *)identifier {
    if (!isEnabled) {
        return NO;
    }
    return [[[[OCDCore sharedCore] point] manager] isPointValidWithPointIdentifier:identifier];
}

+ (BOOL)pointValue:(NSString *)identifier {
    return [[[[[OCDCore sharedCore] point] manager] pointWithIdentifier:identifier] pointValue];
}

+ (id)pointObject:(NSString *)identifier {
    return [[[[[OCDCore sharedCore] point] manager] pointWithIdentifier:identifier] pointObject];
}

@end
