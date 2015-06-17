//
//  OCDHTTPWatcherMappingEntity.m
//  OCDebugger
//
//  Created by 崔 明辉 on 15/6/16.
//  Copyright (c) 2015年 PonyCui. All rights reserved.
//

#import "OCDHTTPWatcherMappingEntity.h"
#import "OCDValueFormatter.h"

@implementation OCDHTTPWatcherMappingEntity

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self && [dictionary isKindOfClass:[NSDictionary class]]) {
        self.fromURLStringPattern = TOString(dictionary[@"fromPattern"]);
        self.toURLStringPattern = TOString(dictionary[@"toPattern"]);
    }
    return self;
}

- (BOOL)isValidRequest:(NSURLRequest *)request {
    if ([request.URL.absoluteString rangeOfString:self.fromURLStringPattern options:NSCaseInsensitiveSearch | NSRegularExpressionSearch].location != NSNotFound) {
        return YES;
    }
    else {
        return NO;
    }
}

- (NSURLRequest *)modifiedRequest:(NSURLRequest *)reqeust {
    NSString *URLString = reqeust.URL.absoluteString;
    URLString = [URLString stringByReplacingOccurrencesOfString:self.fromURLStringPattern withString:self.toURLStringPattern options:NSCaseInsensitiveSearch | NSRegularExpressionSearch range:NSMakeRange(0, [URLString length])];
    NSMutableURLRequest *modifiedRequest = [reqeust mutableCopy];
    [modifiedRequest setURL:[NSURL URLWithString:URLString]];
    return [modifiedRequest copy];
}

@end
