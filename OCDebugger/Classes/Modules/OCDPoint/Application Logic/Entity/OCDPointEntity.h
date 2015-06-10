//
//  OCDPointEntity.h
//  OCDebugger
//
//  Created by 崔 明辉 on 15/6/10.
//  Copyright (c) 2015年 PonyCui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OCDPointEntity : NSObject

@property (nonatomic, copy) NSString *pointIdentifier;

@property (nonatomic, assign) NSInteger pointValue;

@property (nonatomic, strong) id pointObject;

@property (nonatomic, assign) BOOL isValid;

- (NSDictionary *)toDictionary;

@end
