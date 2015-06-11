//
//  OCDPointEntity.m
//  OCDebugger
//
//  Created by 崔 明辉 on 15/6/10.
//  Copyright (c) 2015年 PonyCui. All rights reserved.
//

#import "OCDPointEntity.h"
#import "OCDValueFormatter.h"
#import "OCDCore.h"

@implementation OCDPointEntity

- (NSDictionary *)toDictionary {
    return @{
             @"pointIdentifier": TOString(self.pointIdentifier),
             @"pointValue": @(self.pointValue),
             @"pointObject": TOString([self.pointObject description]),
             @"isValid": @(self.isValid)
             };
}

- (NSString *)cacheKey {
    return [NSString stringWithFormat:@"OCDebugger.Point.Identifier.%@", self.pointIdentifier];
}

#pragma mark - Setter

- (void)setIsValid:(BOOL)isValid {
    _isValid = isValid;
    [[NSUserDefaults standardUserDefaults] setObject:@(_isValid) forKey:[self cacheKey]];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[[[OCDCore sharedCore] socketService] point] requestPoints];
}

- (void)setPointIdentifier:(NSString *)pointIdentifier {
    _pointIdentifier = pointIdentifier;
    _isValid = [[[NSUserDefaults standardUserDefaults] objectForKey:[self cacheKey]] boolValue];
}

@end
