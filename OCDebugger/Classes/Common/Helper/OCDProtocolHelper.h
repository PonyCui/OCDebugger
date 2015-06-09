//
//  PPMProtocolHelper.h
//  PonyMessenger
//
//  Created by 崔 明辉 on 15-3-29.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OCDProtocolHelper : NSObject

@property (nonatomic, strong) NSError *error;

@property (nonatomic, copy) NSString *service;

@property (nonatomic, copy) NSString *method;

@property (nonatomic, strong) id params;

- (instancetype)initWithMessageString:(NSString *)messageString;

+ (NSString *)messageWithService:(NSString *)service method:(NSString *)method params:(id)params;

@end
