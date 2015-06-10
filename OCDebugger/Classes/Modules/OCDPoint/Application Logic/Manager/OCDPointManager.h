//
//  OCDPointManager.h
//  OCDebugger
//
//  Created by 崔 明辉 on 15/6/10.
//  Copyright (c) 2015年 PonyCui. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OCDPointEntity;

@interface OCDPointManager : NSObject

- (void)addPointItem:(OCDPointEntity *)item;

- (OCDPointEntity *)pointWithIdentifier:(NSString *)pointIdentifier;

- (BOOL)isPointValidWithPointIdentifier:(NSString *)pointIdentifier;

@end
