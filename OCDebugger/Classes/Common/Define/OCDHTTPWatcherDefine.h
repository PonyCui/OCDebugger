//
//  OCDHTTPWatcherDefine.h
//  OCDebugger
//
//  Created by 崔 明辉 on 15/6/8.
//  Copyright (c) 2015年 PonyCui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OCDHTTPWatcherDefine : NSObject

@property (nonatomic, assign) BOOL enabled;

@property (nonatomic, readonly) NSString *modifierRequestURLString;

@end
