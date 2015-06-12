//
//  OCDFinderManager.h
//  OCDebugger
//
//  Created by 崔 明辉 on 15/6/12.
//  Copyright (c) 2015年 PonyCui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OCDFinderManager : NSObject

@property (nonatomic, copy) NSString *currentPath;

- (NSString *)executeShell:(NSString *)shell;

@end
