//
//  OCDLogEntity.h
//  OCDebugger
//
//  Created by 崔 明辉 on 15/6/11.
//  Copyright (c) 2015年 PonyCui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OCDLogEntity : NSObject

@property (nonatomic, copy) NSString *logFileName;

@property (nonatomic, copy) NSString *logFunctionName;

@property (nonatomic, copy) NSString *logLineNumber;

@property (nonatomic, copy) NSString *logBody;

@end
