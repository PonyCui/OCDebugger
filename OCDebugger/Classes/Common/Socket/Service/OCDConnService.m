//
//  PPMSyncConnService.m
//  PonyMessenger
//
//  Created by 崔 明辉 on 15/4/1.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "OCDConnService.h"
#import "OCDProtocolHelper.h"
#import "OCDSubService.h"
#import "OCDCore.h"
#import <SocketRocket/SRWebSocket.h>

@interface OCDConnService ()<SRWebSocketDelegate>

@property (nonatomic, strong) SRWebSocket *webSocketConnection;

@property (nonatomic, copy) NSString *webSocketURLString;

@property (nonatomic, assign) NSUInteger retryCount;

@end

@implementation OCDConnService

- (void)dealloc
{
    self.webSocketConnection.delegate = nil;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)requestWebSocketURLStringWithCompletionBlock:(void (^)())completionBlock {
    NSString *URLString = @"";//[[[PPMDefine sharedDefine] sync] requestSocketAddressURLString];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URLString]];
    [NSURLConnection
     sendAsynchronousRequest:request
     queue:[NSOperationQueue mainQueue]
     completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
         if (connectionError == nil && [data isKindOfClass:[NSData class]]) {
             NSString *responseString = [[NSString alloc] initWithData:data
                                                              encoding:NSUTF8StringEncoding];
             if (responseString.length) {
                 self.webSocketURLString = responseString;
                 if (completionBlock) {
                     completionBlock();
                 }
             }
         }
         else {
             dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                 [self requestWebSocketURLStringWithCompletionBlock:completionBlock];
             });
         }
    }];
}

- (void)connect {
    if (self.webSocketURLString == nil || ![self.webSocketURLString hasPrefix:@"ws://"]) {
        [self requestWebSocketURLStringWithCompletionBlock:^{
            [self connect];
        }];
        return;
    }
    else {
        self.webSocketConnection = [[SRWebSocket alloc] initWithURL:[NSURL URLWithString:self.webSocketURLString]];
        self.webSocketConnection.delegate = self;
        [self.webSocketConnection open];
    }
}

- (void)sendMessage:(id)message {
    [self.webSocketConnection send:message];
}

- (void)disconnect {
    [self.webSocketConnection close];
}

#pragma mark - SRWebSocketDelegate

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error {
    if (self.retryCount < 10) {
        NSLog(@"Will reconnect after 5s.");
        self.retryCount++;
        [self performSelector:@selector(connect) withObject:nil afterDelay:5.0];
    }
}

- (void)webSocketDidOpen:(SRWebSocket *)webSocket {
    self.retryCount = 0;
    [[[[OCDCore sharedCore] socketService] sub] addObserver];
}

#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Warc-performSelector-leaks"
- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message {
    OCDProtocolHelper *protoHelper = [[OCDProtocolHelper alloc] initWithMessageString:message];
    if (protoHelper.error == nil) {
        if ([[[OCDCore sharedCore] socketService] respondsToSelector:NSSelectorFromString(protoHelper.service)]) {
            NSObject *serviceObject = [[[OCDCore sharedCore] socketService] performSelector:NSSelectorFromString(protoHelper.service)
                                                                            withObject:nil];
            if ([serviceObject respondsToSelector:NSSelectorFromString(protoHelper.method)]) {
                [serviceObject performSelector:NSSelectorFromString(protoHelper.method) withObject:nil];
            }
            else if ([serviceObject respondsToSelector:NSSelectorFromString([protoHelper.method stringByAppendingString:@":"])]) {
                [serviceObject performSelector:NSSelectorFromString([protoHelper.method stringByAppendingString:@":"])
                                    withObject:protoHelper.params];
            }
        }
    }
}
#pragma GCC diagnostic pop

- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean {
    [self requestWebSocketURLStringWithCompletionBlock:^{
        [self connect];
    }];
}

@end
