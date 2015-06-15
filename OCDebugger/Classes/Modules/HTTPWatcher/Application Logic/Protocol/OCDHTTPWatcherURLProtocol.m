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
#import "OCDDefine.h"

static int watchOrderID = 0;

@interface OCDHTTPWatcherURLProtocol ()<NSURLConnectionDelegate, NSURLConnectionDataDelegate>

@property (nonatomic, strong) NSURLConnection *connection;

@property (nonatomic, strong) NSURLResponse *response;

@property (nonatomic, strong) NSMutableData *data;

@property (nonatomic, strong) NSDate *startDate;

@end

@implementation OCDHTTPWatcherURLProtocol

+ (void)load {
    watchOrderID = arc4random() % 1000000;
}

+ (BOOL)canInitWithRequest:(NSURLRequest *)request {
    if (![request.URL.scheme isEqualToString:@"http"] &&
        ![request.URL.scheme isEqualToString:@"https"]) {
        return NO;
    }
    if ([NSURLProtocol propertyForKey:@"OCDHTTPWatcher" inRequest:request] != nil) {
        return NO;
    }
    if ([NSURLProtocol propertyForKey:kOCDMessageStorageRequestKey inRequest:request] != nil) {
        return NO;
    }
    return YES;
}

+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request {
    request = [[[[OCDCore sharedCore] HTTPWatcher] hostsManager] hostedRequestWithRequest:request];
    NSMutableURLRequest *mutableReqeust = [request mutableCopy];
    [NSURLProtocol setProperty:[NSString stringWithFormat:@"%ld", (long)watchOrderID]
                        forKey:@"OCDHTTPWatcher"
                     inRequest:mutableReqeust];
    watchOrderID++;
    return [mutableReqeust copy];
}

- (void)startLoading {
    self.startDate = [NSDate date];
    OCDHTTPWatcherConnectionEntity *connectionItem = [[OCDHTTPWatcherConnectionEntity alloc]
                                                      initWithReqeust:self.request];
    connectionItem.orderID = [NSURLProtocol propertyForKey:@"OCDHTTPWatcher" inRequest:self.request];
    [[[[OCDCore sharedCore] HTTPWatcher] connectionManager] deliverItem:connectionItem];
    self.data = [NSMutableData data];
    self.connection = [[NSURLConnection alloc] initWithRequest:[[self class] canonicalRequestForRequest:self.request] delegate:self startImmediately:YES];
}

- (void)stopLoading {
    [self.connection cancel];
}

#pragma mark - NSURLConnectionDelegate

- (void)connection:(NSURLConnection *)connection
  didFailWithError:(NSError *)error
{
    [[self client] URLProtocol:self didFailWithError:error];
}

- (BOOL)connectionShouldUseCredentialStorage:(NSURLConnection *)connection {
    return YES;
}

- (void)connection:(NSURLConnection *)connection
didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    [[self client] URLProtocol:self didReceiveAuthenticationChallenge:challenge];
}

- (void)connection:(NSURLConnection *)connection
didCancelAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    [[self client] URLProtocol:self didCancelAuthenticationChallenge:challenge];
}

#pragma mark - NSURLConnectionDataDelegate

- (void)connection:(NSURLConnection *)connection
didReceiveResponse:(NSURLResponse *)response
{
    [[self client] URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageAllowed];
    self.response = response;
}

- (void)connection:(NSURLConnection *)connection
    didReceiveData:(NSData *)data
{
    [[self client] URLProtocol:self didLoadData:data];
    [self.data appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse *)cachedResponse
{
    return cachedResponse;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [[self client] URLProtocolDidFinishLoading:self];
    OCDHTTPWatcherConnectionEntity *connectionItem = [[OCDHTTPWatcherConnectionEntity alloc]
                                                      initWithResponse:self.response
                                                      data:[self.data copy]];
    connectionItem.orderID = [NSURLProtocol propertyForKey:@"OCDHTTPWatcher" inRequest:self.request];
    connectionItem.timeUse = [NSString stringWithFormat:@"%.2fs", fabs([self.startDate timeIntervalSinceNow])];
    [[[[OCDCore sharedCore] HTTPWatcher] connectionManager] deliverItem:connectionItem];
}

@end
