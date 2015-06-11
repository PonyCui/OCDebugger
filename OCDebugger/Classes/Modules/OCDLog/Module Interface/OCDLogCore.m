//
//  OCDLogCore.m
//  OCDebugger
//
//  Created by 崔 明辉 on 15/6/11.
//  Copyright (c) 2015年 PonyCui. All rights reserved.
//

#import "OCDLogCore.h"
#import "OCDCore.h"

void OCDLog(const char * file, int lineNumber, const char *functionName, NSString *format, ...) {
    va_list ap;
    va_start(ap, format);
    if (![format hasSuffix: @"\n"])
    {
        format = [format stringByAppendingString: @"\n"];
    }
    NSString *body = [[NSString alloc] initWithFormat:format arguments:ap];
    va_end (ap);
    NSString *dateString = [[NSDate date] description];
    fprintf(stderr, "[OCDLog] %s %s", [dateString UTF8String], [body UTF8String]);
    OCDLogEntity *item = [[OCDLogEntity alloc] init];
    item.logFileName = [[NSString stringWithUTF8String:file] lastPathComponent];
    item.logFunctionName = [NSString stringWithUTF8String:functionName];
    item.logLineNumber = [NSString stringWithFormat:@"%d", lineNumber];
    item.logBody = [NSString stringWithFormat:@"%@ %@", dateString, body];
    [OCDLogCore addLogItem:item];
}

@implementation OCDLogCore

+ (void)addLogItem:(OCDLogEntity *)item {
    [[[[OCDCore sharedCore] log] manager] saveLogItem:item];
}

#pragma mark - Getter

- (OCDLogManager *)manager {
    if (_manager == nil) {
        _manager = [[OCDLogManager alloc] init];
    }
    return _manager;
}

@end
