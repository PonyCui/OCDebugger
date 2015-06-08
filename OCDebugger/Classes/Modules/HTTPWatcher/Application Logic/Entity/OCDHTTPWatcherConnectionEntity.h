//
//  OCDHTTPWatcherConnectionEntity.h
//  OCDebugger
//
//  Created by 崔 明辉 on 15/6/8.
//  Copyright (c) 2015年 PonyCui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OCDHTTPWatcherConnectionEntity : NSObject

@property (nonatomic, copy) NSString *requestURLString;

@property (nonatomic, strong) NSDate *requestDate;

@property (nonatomic, copy) NSString *requestMethod;

@end
