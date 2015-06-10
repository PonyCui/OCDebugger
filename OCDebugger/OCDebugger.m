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

@implementation OCDebugger

+ (void)setEnabled:(BOOL)enabled {
    [[[OCDDefine sharedDefine] HTTPWatcher] setEnabled:YES];
    [[[[OCDCore sharedCore] socketService] conn] connect];
}

+ (void)addPointWithIdentifier:(NSString *)identifier pointValue:(BOOL)pointValue {
    OCDPointEntity *pointItem = [[OCDPointEntity alloc] init];
    pointItem.pointIdentifier = identifier;
    pointItem.pointValue = pointValue;
    [[[[OCDCore sharedCore] point] manager] addPointItem:pointItem];
}

+ (BOOL)isPointValid:(NSString *)identifier {
    return [[[[OCDCore sharedCore] point] manager] isPointValidWithPointIdentifier:identifier];
}

+ (BOOL)pointValue:(NSString *)identifier {
    return [[[[[OCDCore sharedCore] point] manager] pointWithIdentifier:identifier] pointValue];
}

@end
