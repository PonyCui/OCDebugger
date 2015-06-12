//
//  OCDHTTPWatcherConnectionEntity.h
//  OCDebugger
//
//  Created by 崔 明辉 on 15/6/8.
//  Copyright (c) 2015年 PonyCui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OCDHTTPWatcherConnectionEntity : NSObject

@property (nonatomic, copy) NSString *orderID;

@property (nonatomic, copy) NSString *requestURLString;

@property (nonatomic, strong) NSDate *requestDate;

@property (nonatomic, copy) NSString *requestMethod;

@property (nonatomic, copy) NSString *requestHeader;

@property (nonatomic, copy) NSString *responseURLString;

@property (nonatomic, copy) NSString *responseStatusCode;

@property (nonatomic, copy) NSString *responseMIMEType;

@property (nonatomic, copy) NSString *responseHeader;

@property (nonatomic, copy) NSString *responseString;

@property (nonatomic, copy) NSString *responseDataSize;

@property (nonatomic, copy) NSString *timeUse;

- (instancetype)initWithReqeust:(NSURLRequest *)request;

- (instancetype)initWithResponse:(NSURLResponse *)response data:(NSData *)data;

- (NSDictionary *)toDictionary;

@end
