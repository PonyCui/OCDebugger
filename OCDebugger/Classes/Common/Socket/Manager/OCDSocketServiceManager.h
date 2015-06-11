//
//  PPMSyncSocketServiceManager.h
//  PonyMessenger
//
//  Created by 崔 明辉 on 15/4/1.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OCDConnService.h"
#import "OCDPubService.h"
#import "OCDSubService.h"
#import "OCDDeviceService.h"
#import "OCDPointService.h"
#import "OCDLogService.h"

@class OCDConnService, OCDSubService, OCDPubService;

@interface OCDSocketServiceManager : NSObject

@property (nonatomic, readonly) OCDConnService *conn;

@property (nonatomic, readonly) OCDSubService *sub;

@property (nonatomic, readonly) OCDPubService *pub;

@property (nonatomic, readonly) OCDDeviceService *device;

@property (nonatomic, readonly) OCDPointService *point;

@property (nonatomic, readonly) OCDLogService *log;

@end
