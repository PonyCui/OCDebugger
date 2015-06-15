//
//  OCDDefine.h
//  OCDebugger
//
//  Created by 崔 明辉 on 15/6/8.
//  Copyright (c) 2015年 PonyCui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OCDHTTPWatcherDefine.h"

#define kOCDMessageStorageRequestKey @"OCDMessageStorageRequestKey"

@interface OCDDefine : NSObject

+ (OCDDefine *)sharedDefine;

@property (nonatomic, strong) OCDHTTPWatcherDefine *HTTPWatcher;

@property (nonatomic, readonly) NSString *socketAddressRequestURLString;

@property (nonatomic, copy) NSString *appID;

@property (nonatomic, copy) NSString *appToken;

- (NSString *)uniqueIdentifier;

- (NSString *)storageAddAddressWithIdentifier:(NSString *)identifier;

- (NSString *)storageFetchAddressWithIdentifier:(NSString *)identifier;

@end
