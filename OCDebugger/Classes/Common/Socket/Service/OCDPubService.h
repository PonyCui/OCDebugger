//
//  OCDPubService.h
//  OCDebugger
//
//  Created by 崔 明辉 on 15/6/9.
//  Copyright (c) 2015年 PonyCui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OCDPubService : NSObject

- (void)pubMessageToService:(NSString *)service method:(NSString *)method params:(NSDictionary *)params;

@end
