//
//  OCDHTTPWatcherConnectionProtocol.m
//  OCDebugger
//
//  Created by 崔 明辉 on 15/6/8.
//  Copyright (c) 2015年 PonyCui. All rights reserved.
//

#import "OCDHTTPWatcherURLProtocol.h"
#import "OCDHTTPWatcherConnectionEntity.h"
#import "OCDCore.h"

@implementation OCDHTTPWatcherURLProtocol

+ (BOOL)canInitWithRequest:(NSURLRequest *)request {
    if ([NSURLProtocol propertyForKey:@"hello" inRequest:request] != nil) {
        return NO;
    }
    OCDHTTPWatcherConnectionEntity *connectionItem = [[OCDHTTPWatcherConnectionEntity alloc]
                                                      initWithReqeust:request];
    [[[[OCDCore sharedCore] HTTPWatcher] connectionManager] deliverItem:connectionItem];
    return YES;
}

+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request {
    NSMutableURLRequest *mutableReqeust = [request mutableCopy];
    [NSURLProtocol setProperty:@"1" forKey:@"hello" inRequest:mutableReqeust];
    return [mutableReqeust copy];
}

- (void)startLoading {
    [NSURLConnection sendAsynchronousRequest:self.request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError) {
            [self.client URLProtocol:self didFailWithError:connectionError];
        }
        else {
            [self.client URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageAllowed];
            [self.client URLProtocol:self didLoadData:data];
            [self.client URLProtocolDidFinishLoading:self];
        }
    }];
}

@end
