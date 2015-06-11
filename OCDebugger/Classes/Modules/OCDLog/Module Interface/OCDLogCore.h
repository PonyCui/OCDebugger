//
//  OCDLogCore.h
//  OCDebugger
//
//  Created by 崔 明辉 on 15/6/11.
//  Copyright (c) 2015年 PonyCui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OCDLogEntity.h"
#import "OCDLogManager.h"

void OCDLog(const char * file, int lineNumber, const char *functionName, NSString *format, ...);

@interface OCDLogCore : NSObject

@property (nonatomic, assign) BOOL enabled;

@property (nonatomic, strong) OCDLogManager *manager;

+ (void)addLogItem:(OCDLogEntity *)item;

@end
