//
//  OCDLogManager.m
//  OCDebugger
//
//  Created by 崔 明辉 on 15/6/11.
//  Copyright (c) 2015年 PonyCui. All rights reserved.
//

#import "OCDLogManager.h"
#import "OCDLogEntity.h"

@interface OCDLogManager ()

@property (nonatomic, copy) NSArray *items;

@end

@implementation OCDLogManager

- (void)saveLogItem:(OCDLogEntity *)item {
    if (item == nil) {
        return;
    }
    NSMutableArray *items = [self.items mutableCopy];
    [items addObject:item];
    self.items = items;
}

- (NSString *)consoleText {
    NSMutableString *text = [NSMutableString string];
    [self.items enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj logBody] != nil) {
            [text appendString:[obj logBody]];
        }
    }];
    return [text copy];
}

#pragma mark - Getter

- (NSArray *)items {
    if (_items == nil) {
        _items = @[];
    }
    return _items;
}

@end
