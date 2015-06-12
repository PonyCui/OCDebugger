//
//  OCDHTTPWatcherHostsManager.m
//  OCDebugger
//
//  Created by 崔 明辉 on 15/6/12.
//  Copyright (c) 2015年 PonyCui. All rights reserved.
//

#import "OCDHTTPWatcherHostsManager.h"
#import "OCDHTTPWatcherHostEntity.h"
#import "OCDValueFormatter.h"

@interface OCDHTTPWatcherHostsManager ()

@property (nonatomic, copy) NSDictionary *items;

@end

@implementation OCDHTTPWatcherHostsManager

- (void)addHostItem:(OCDHTTPWatcherHostEntity *)item {
    NSMutableDictionary *items = [self.items mutableCopy];
    [items setObject:item forKey:item.domain];
    self.items = items;
}

- (NSURLRequest *)hostedRequestWithRequest:(NSURLRequest *)originRequest {
    if (self.items[[TOString(originRequest.URL.host) lowercaseString]] != nil) {
        NSMutableURLRequest *mutableRequest = [originRequest mutableCopy];
        NSRange hostRange = [originRequest.URL.absoluteString
                             rangeOfString:[TOString(originRequest.URL.host) lowercaseString]];
        NSString *replacedURLString = [originRequest.URL.absoluteString stringByReplacingCharactersInRange:hostRange withString:[self.items[[TOString(originRequest.URL.host) lowercaseString]] hostIP]];
        [mutableRequest setURL:[NSURL URLWithString:replacedURLString]];
        [mutableRequest setValue:originRequest.URL.host forHTTPHeaderField:@"Host"];
        return [mutableRequest copy];
    }
    return originRequest;
}

- (NSDictionary *)items {
    if (_items == nil) {
        _items = @{};
    }
    return _items;
}

@end
