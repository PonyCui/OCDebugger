//
//  AFUObjectFormater.m
//  AFUtils
//
//  Created by 崔 明辉 on 14/12/22.
//  Copyright (c) 2014年 多玩事业部 iOS开发组 YY Inc. All rights reserved.
//

#import "OCDValueFormatter.h"

@implementation OCDValueFormatter

+ (id)objectAsClass:(Class)argClass withObject:(id)argObject {
    if ([argObject isKindOfClass:argClass]) {
        return argObject;
    }
    else {
        return [self formatAsClass:argClass withObject:argObject];
    }
}

+ (id)formatAsClass:(Class)argClass withObject:(id)argObject {
    if ([argObject isKindOfClass:[NSString class]] && argClass == [NSNumber class]) {
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        NSNumber *numberObject = [numberFormatter numberFromString:argObject];
        return numberObject == NULL ? @0 : [numberFormatter numberFromString:argObject];
    }
    else if ([argObject isKindOfClass:[NSNumber class]] && argClass == [NSString class]) {
        return [NSString stringWithFormat:@"%@", argObject];
    }
    else if (argClass == [NSNumber class]) {
        return @0;
    }
    else if ([[argClass alloc] respondsToSelector:@selector(init)]) {
        return [[argClass alloc] init];
    }
    else {
        return [NSNull null];
    }
}

+ (BOOL)isValidArray:(id)argObject atIndex:(NSUInteger)argIndex {
    if ([argObject isKindOfClass:[NSArray class]]) {
        if (argIndex < [argObject count]) {
            return YES;
        }
        else {
            return NO;
        }
    }
    else {
        return NO;
    }
}

@end
