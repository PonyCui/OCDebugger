//
//  OCDFinderManager.m
//  OCDebugger
//
//  Created by 崔 明辉 on 15/6/12.
//  Copyright (c) 2015年 PonyCui. All rights reserved.
//

#import "OCDFinderManager.h"

@implementation OCDFinderManager

- (NSString *)executeShell:(NSString *)shell {
    NSMutableString *baseString = [NSMutableString stringWithFormat:@"app:%@ developer$ %@",
                                   self.currentPath, shell];
    if ([shell hasPrefix:@"ls"]) {
        [baseString appendString:[self ls:shell]];
    }
    else {
        [baseString appendString:@"command not found."];
    }
    [baseString appendString:@"\n"];
    return [baseString copy];
}

#pragma mark - ls

- (NSString *)ls:(NSString *)shell {
    if ([shell isEqualToString:@"ls"]) {
        return [self ls];
    }
    else {
        return [self lsDirectory:[shell substringFromIndex:3]];
    }
    return nil;
}

- (NSString *)ls {
    NSMutableString *resultString = [NSMutableString string];
    NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[self absolutelyPathWithPath:self.currentPath] error:NULL];
    [files enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [resultString appendFormat:@"\n%@", obj];
    }];
    return [resultString copy];
}

- (NSString *)lsDirectory:(NSString *)directory {
    NSMutableString *resultString = [NSMutableString string];
    NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[self absolutelyPathWithPath:directory] error:NULL];
    [files enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [resultString appendFormat:@"\n%@", obj];
    }];
    return [resultString copy];
}

#pragma mark - Path Helper

- (NSString *)absolutelyPathWithPath:(NSString *)path {
    if ([path hasPrefix:@"/"]) {
        return [NSHomeDirectory() stringByAppendingFormat:@"%@", path];
    }
    else {
        if ([path hasPrefix:@"./"]) {
            path = [path substringFromIndex:2];
        }
        if ([self.currentPath hasSuffix:@"/"]) {
            return [NSHomeDirectory() stringByAppendingFormat:@"%@%@", self.currentPath, path];
        }
        else {
            return [NSHomeDirectory() stringByAppendingFormat:@"%@/%@", self.currentPath, path];
        }
    }
}


#pragma mark - Getter

- (NSString *)currentPath {
    if (_currentPath == nil) {
        _currentPath = @"/";
    }
    return _currentPath;
}

@end
