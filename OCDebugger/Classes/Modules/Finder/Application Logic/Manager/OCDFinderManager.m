//
//  OCDFinderManager.m
//  OCDebugger
//
//  Created by 崔 明辉 on 15/6/12.
//  Copyright (c) 2015年 PonyCui. All rights reserved.
//

#import "OCDFinderManager.h"
#import "OCDCore.h"
#import "OCDValueFormatter.h"
#import <UIKit/UIKit.h>

@implementation OCDFinderManager

- (NSArray *)currentSubPaths {
    NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[self absolutelyPathWithPath:self.currentPath] error:NULL];
    return files;
}

- (NSString *)executeShell:(NSString *)shell {
    NSMutableString *baseString = [NSMutableString stringWithFormat:@"app:%@ developer$ %@\n",
                                   self.currentPath, shell];
    if ([shell hasPrefix:@"ls"]) {
        [baseString appendString:[self ls:shell]];
    }
    else if ([shell hasPrefix:@"cd"]) {
        [baseString appendString:[self cd:shell]];
    }
    else if ([shell hasPrefix:@"rm"]) {
        [baseString appendString:[self rm:shell]];
    }
    else if ([shell hasPrefix:@"vi"]) {
        [baseString appendString:[self vi:shell]];
    }
    else {
        [baseString appendString:@"command not found."];
    }
    [baseString appendString:@"\n\n"];
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
        NSString *filePath = [[self absolutelyPathWithPath:self.currentPath] stringByAppendingFormat:@"/%@", obj];
        NSDictionary *fileAttrs = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:NULL];
        [resultString appendFormat:@"%04ld      %@       %@      %@\n",
         (long)[fileAttrs[NSFileSize] integerValue], [fileAttrs[NSFileModificationDate] description], fileAttrs[NSFileType], obj];
    }];
    return [resultString copy];
}

- (NSString *)lsDirectory:(NSString *)directory {
    NSMutableString *resultString = [NSMutableString string];
    NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[self absolutelyPathWithPath:directory] error:NULL];
    [files enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *filePath = [[self absolutelyPathWithPath:self.currentPath] stringByAppendingFormat:@"/%@", obj];
        NSDictionary *fileAttrs = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:NULL];
        [resultString appendFormat:@"%04ld      %@       %@      %@\n",
         (long)[fileAttrs[NSFileSize] integerValue], [fileAttrs[NSFileModificationDate] description], fileAttrs[NSFileType], obj];
    }];
    return [resultString copy];
}

#pragma mark - cd

- (NSString *)cd:(NSString *)shell {
    if ([shell isEqualToString:@"cd.."] || [shell isEqualToString:@"cd .."]) {
        NSMutableArray *components = [[self.currentPath componentsSeparatedByString:@"/"] mutableCopy];
        if ([components count] > 0) {
            [components removeLastObject];
        }
        self.currentPath = [components componentsJoinedByString:@"/"];
        if (self.currentPath.length == 0) {
            self.currentPath = @"/";
        }
    }
    else if ([shell hasPrefix:@"cd "]) {
        if ([[NSFileManager defaultManager] fileExistsAtPath:[self absolutelyPathWithPath:[shell substringFromIndex:3]]]) {
            if ([[shell substringFromIndex:3] hasPrefix:@"/"]) {
                self.currentPath = [shell substringFromIndex:3];
            }
            else if ([self.currentPath hasSuffix:@"/"]) {
                self.currentPath = [self.currentPath stringByAppendingString:[shell substringFromIndex:3]];
            }
            else {
                self.currentPath = [self.currentPath stringByAppendingFormat:@"/%@", [shell substringFromIndex:3]];
            }
        }
    }
    return [NSString stringWithFormat:@"Current Path = %@", self.currentPath];
}

#pragma mark - rm

- (NSString *)rm:(NSString *)shell {
    if ([shell isEqualToString:@"rm *"]) {
        NSMutableString *result = [NSMutableString string];
        NSArray *subPaths = [self currentSubPaths];
        [subPaths enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSError *rmError;
            [[NSFileManager defaultManager] removeItemAtPath:[self absolutelyPathWithPath:obj]
                                                       error:&rmError];
            if (rmError == nil) {
                [result appendFormat:@"%@ Deleted\n", obj];
            }
            else {
                [result appendFormat:@"%@ Delete failed, reason:%@\n", obj, rmError.localizedDescription];
            }
        }];
        return [result copy];
    }
    else if ([shell hasPrefix:@"rm "]) {
        if ([[NSFileManager defaultManager] fileExistsAtPath:[self absolutelyPathWithPath:[shell substringFromIndex:3]]]) {
            NSError *rmError;
            [[NSFileManager defaultManager] removeItemAtPath:[self absolutelyPathWithPath:[shell substringFromIndex:3]] error:&rmError];
            if (rmError == nil) {
                return @"Deleted";
            }
            else {
                return rmError.localizedDescription;
            }
        }
    }
    return @"Nothing changed.";
}

#pragma mark - vi

- (NSString *)vi:(NSString *)shell {
    if ([shell hasPrefix:@"vi "]) {
        if ([[NSFileManager defaultManager] fileExistsAtPath:[self absolutelyPathWithPath:[shell substringFromIndex:3]]]) {
            NSString *fileContent = [NSString stringWithContentsOfFile:[self absolutelyPathWithPath:[shell substringFromIndex:3]] encoding:NSUTF8StringEncoding error:NULL];
            if (fileContent == nil || [fileContent length] > 1024 * 16 || ![fileContent isKindOfClass:[NSString class]]) {
                return @"Not a text file or file size large than 16KB.";
            }
            [[[[OCDCore sharedCore] socketService] pub]
             pubMessageToService:@"finder"
             method:@"viMode"
             params:@{
                      @"deviceIdentifier": TOString([[[UIDevice currentDevice] identifierForVendor] UUIDString]),
                      @"filePath": TOString([self absolutelyPathWithPath:[shell substringFromIndex:3]]),
                      @"fileContent": TOString(fileContent)
                      }];
            return @"";
        }
    }
    return @"File not exist.";
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
