//
//  OCDHTTPWatcherModifierManager.h
//  OCDebugger
//
//  Created by 崔 明辉 on 15/6/16.
//  Copyright (c) 2015年 PonyCui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OCDHTTPWatcherModifierManager : NSObject

- (void)fetchModifiers;

- (NSURLRequest *)modifiedRequest:(NSURLRequest *)request;

- (NSData *)modifiedDataForResponse:(NSURLResponse *)response withData:(NSData *)data;

@end
