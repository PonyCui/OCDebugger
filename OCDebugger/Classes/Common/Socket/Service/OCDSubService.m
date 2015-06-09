//
//  PPMSyncSubService.m
//  PonyMessenger
//
//  Created by 崔 明辉 on 15/4/1.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "OCDSubService.h"
#import "OCDConnService.h"
#import "OCDProtocolHelper.h"
#import "OCDValueFormatter.h"
#import "OCDCore.h"

@interface OCDSubService ()

@property (nonatomic, strong) NSTimer *heartBeatTimer;

@property (nonatomic, strong) NSTimer *heartBeatTimeoutTimer;

@end

@implementation OCDSubService

- (void)addObserver {
    NSString *userID = @"1";
    NSString *sessionToken = @"testToken";
    NSString *message = [OCDProtocolHelper messageWithService:@"sub"
                                                       method:@"addObserver"
                                                       params:@{@"user_id":userID,
                                                                @"session_token":sessionToken}];
    [[[[OCDCore sharedCore] socketService] conn] sendMessage:message];
}

- (void)heartBeat {
    NSString *message = [OCDProtocolHelper messageWithService:@"sub" method:@"heartBeat" params:nil];
    [[[[OCDCore sharedCore] socketService] conn] sendMessage:message];
    self.heartBeatTimeoutTimer = [NSTimer scheduledTimerWithTimeInterval:5.0
                                                                  target:self
                                                                selector:@selector(heartBeatTimeoutTimer)
                                                                userInfo:nil
                                                                 repeats:NO];
}

- (void)heartBeatTimeout {
    NSLog(@"[Error] fail to receive heart beat.");
    [[[[OCDCore sharedCore] socketService] conn] disconnect];
}

- (void)didAddObserver {
    NSLog(@"didAddObserver");
    [self.heartBeatTimer invalidate];
    self.heartBeatTimer = [NSTimer scheduledTimerWithTimeInterval:60.0
                                                           target:self
                                                         selector:@selector(heartBeat)
                                                         userInfo:nil
                                                          repeats:YES];
}

- (void)didReceivedError:(NSDictionary *)params {
    NSLog(@"[Error] code:%@, desc:%@", TODictionary(params)[@"error_code"], TODictionary(params)[@"error_description"]);
}

- (void)didReceivedHeartBeat {
    NSLog(@"didReceivedHeartBeat");
    [self.heartBeatTimeoutTimer invalidate];
}

@end
