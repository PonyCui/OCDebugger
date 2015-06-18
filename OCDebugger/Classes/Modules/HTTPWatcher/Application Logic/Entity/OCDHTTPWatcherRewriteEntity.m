//
//  OCDHTTPWatcherRewriteEntity.m
//  OCDebugger
//
//  Created by 崔 明辉 on 15/6/18.
//  Copyright (c) 2015年 PonyCui. All rights reserved.
//

#import "OCDHTTPWatcherRewriteEntity.h"
#import "OCDValueFormatter.h"

@implementation OCDHTTPWatcherRewriteEntity

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self && [dictionary isKindOfClass:[NSDictionary class]]) {
        self.fromURLStringPattern = TOString(dictionary[@"fromPattern"]);
        self.originWord = TOString(dictionary[@"originWord"]);
        self.actionWord = TOString(dictionary[@"actionWord"]);
    }
    return self;
}

- (BOOL)isValidResponse:(NSURLResponse *)response {
    if ([response.URL.absoluteString rangeOfString:self.fromURLStringPattern options:NSCaseInsensitiveSearch | NSRegularExpressionSearch].location != NSNotFound) {
        return YES;
    }
    else {
        return NO;
    }
}

- (NSData *)modifiedData:(NSData *)data {
    NSString *text = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    if (text != nil) {
        text = [text stringByReplacingOccurrencesOfString:self.originWord withString:self.actionWord];
        return [text dataUsingEncoding:NSUTF8StringEncoding];
    }
    else {
        return data;
    }
}

@end
