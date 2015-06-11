//
//  OCDLogService.h
//  OCDebugger
//
//  Created by 崔 明辉 on 15/6/11.
//  Copyright (c) 2015年 PonyCui. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OCDLogEntity;

@interface OCDLogService : NSObject

- (void)sendLogItem:(OCDLogEntity *)item;

@end
