//
//  PPMSyncSubService.m
//  PonyMessenger
//
//  Created by 崔 明辉 on 15/4/1.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "OCDSubService.h"
#import "PPMApplication.h"
#import "OCDConnService.h"
#import "PPMProtocolHelper.h"
#import "PPMValueFormatter.h"
#import "PPMAccountItem.h"

@interface OCDSubService ()

@property (nonatomic, strong) NSTimer *heartBeatTimer;

@property (nonatomic, strong) NSTimer *heartBeatTimeoutTimer;

@end

@implementation OCDSubService

- (void)addObserver {
    NSString *userID = TOString([[[AccountCore accountManager] activeAccount] userID]);
    NSString *sessionToken = TOString([[[AccountCore accountManager] activeAccount] sessionToken]);
    NSString *message = [PPMProtocolHelper messageWithService:@"sub"
                                                       method:@"addObserver"
                                                       params:@{@"user_id":userID,
                                                                @"session_token":sessionToken}];
    [[[SyncCore socketServiceManager] conn] sendMessage:message];
}

- (void)heartBeat {
    NSString *message = [PPMProtocolHelper messageWithService:@"sub" method:@"heartBeat" params:nil];
    [[[SyncCore socketServiceManager] conn] sendMessage:message];
    self.heartBeatTimeoutTimer = [NSTimer scheduledTimerWithTimeInterval:5.0
                                                                  target:self
                                                                selector:@selector(heartBeatTimeoutTimer)
                                                                userInfo:nil
                                                                 repeats:NO];
}

- (void)heartBeatTimeout {
    NSLog(@"[Error] fail to receive heart beat.");
    [[[SyncCore socketServiceManager] conn] disconnect];
}

- (void)didAddObserver {
    NSLog(@"didAddObserver");
    [[SyncCore syncManager] performSyncActions];
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
