//
//  OCDPointManager.m
//  OCDebugger
//
//  Created by 崔 明辉 on 15/6/10.
//  Copyright (c) 2015年 PonyCui. All rights reserved.
//

#import "OCDPointManager.h"
#import "OCDPointEntity.h"

@interface OCDPointManager ()

@property (nonatomic, copy) NSDictionary *items;

@end

@implementation OCDPointManager

- (NSArray *)allItems {
    return [self.items allValues];
}

- (void)addPointItem:(OCDPointEntity *)item {
    if (self.items[item.pointIdentifier] != nil) {
        return;
    }
    NSMutableDictionary *items = [self.items mutableCopy];
    [items setObject:item forKey:item.pointIdentifier];
    self.items = items;
}

- (OCDPointEntity *)pointWithIdentifier:(NSString *)pointIdentifier {
    return self.items[pointIdentifier];
}

- (BOOL)isPointValidWithPointIdentifier:(NSString *)pointIdentifier {
    return [self.items[pointIdentifier] isValid];
}

#pragma mark - Getter

- (NSDictionary *)items {
    if (_items == nil) {
        _items = @{};
    }
    return _items;
}

@end
