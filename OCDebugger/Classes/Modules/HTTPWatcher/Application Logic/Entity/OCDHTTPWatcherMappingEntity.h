//
//  OCDHTTPWatcherMappingEntity.h
//  OCDebugger
//
//  Created by 崔 明辉 on 15/6/16.
//  Copyright (c) 2015年 PonyCui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OCDHTTPWatcherMappingEntity : NSObject

@property (nonatomic, copy) NSString *fromURLStringPattern;

@property (nonatomic, copy) NSString *toURLStringPattern;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

- (BOOL)isValidRequest:(NSURLRequest *)request;

- (NSURLRequest *)modifiedRequest:(NSURLRequest *)reqeust;

@end
