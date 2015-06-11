//
//  OCDebugger.h
//  OCDebugger
//
//  Created by 崔 明辉 on 15/6/8.
//  Copyright (c) 2015年 PonyCui. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef DEBUG
#define NSLog(args...) OCDLog(__FILE__,__LINE__,__PRETTY_FUNCTION__,args);
#else
#define NSLog(...) {}
#endif

@interface OCDebugger : NSObject

+ (void)setEnabled:(BOOL)enabled;

+ (void)addPointWithIdentifier:(NSString *)identifier pointValue:(NSInteger)pointValue pointObject:(id)pointObject;

+ (BOOL)isPointValid:(NSString *)identifier;

+ (BOOL)pointValue:(NSString *)identifier;

+ (id)pointObject:(NSString *)identifier;

@end
