//
//  OCDHTTPWatcherRewriteEntity.h
//  OCDebugger
//
//  Created by 崔 明辉 on 15/6/18.
//  Copyright (c) 2015年 PonyCui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OCDHTTPWatcherRewriteEntity : NSObject

@property (nonatomic, copy) NSString *fromURLStringPattern;

@property (nonatomic, copy) NSString *originWord;

@property (nonatomic, copy) NSString *actionWord;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

- (BOOL)isValidResponse:(NSURLResponse *)response;

- (NSData *)modifiedData:(NSData *)data;

@end
