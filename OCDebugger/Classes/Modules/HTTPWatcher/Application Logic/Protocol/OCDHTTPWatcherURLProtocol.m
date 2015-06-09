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

static int watchOrderID = 0;

@implementation OCDHTTPWatcherURLProtocol

+ (BOOL)canInitWithRequest:(NSURLRequest *)request {
    if ([NSURLProtocol propertyForKey:@"OCDHTTPWatcher" inRequest:request] != nil) {
        return NO;
    }
    return YES;
}

+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request {
    NSMutableURLRequest *mutableReqeust = [request mutableCopy];
    [NSURLProtocol setProperty:[NSString stringWithFormat:@"%ld", (long)watchOrderID]
                        forKey:@"OCDHTTPWatcher"
                     inRequest:mutableReqeust];
    watchOrderID++;
    return [mutableReqeust copy];
}

- (void)startLoading {
    OCDHTTPWatcherConnectionEntity *connectionItem = [[OCDHTTPWatcherConnectionEntity alloc]
                                                      initWithReqeust:self.request];
    connectionItem.orderID = [NSURLProtocol propertyForKey:@"OCDHTTPWatcher" inRequest:self.request];
    [[[[OCDCore sharedCore] HTTPWatcher] connectionManager] deliverItem:connectionItem];
    [NSURLConnection sendAsynchronousRequest:self.request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError) {
            [self.client URLProtocol:self didFailWithError:connectionError];
        }
        else {
            [self.client URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageAllowed];
            [self.client URLProtocol:self didLoadData:data];
            [self.client URLProtocolDidFinishLoading:self];
        }
        OCDHTTPWatcherConnectionEntity *connectionItem = [[OCDHTTPWatcherConnectionEntity alloc]
                                                          initWithResponse:response
                                                          data:data];
        connectionItem.orderID = [NSURLProtocol propertyForKey:@"OCDHTTPWatcher" inRequest:self.request];
        [[[[OCDCore sharedCore] HTTPWatcher] connectionManager] deliverItem:connectionItem];
    }];
}

@end
