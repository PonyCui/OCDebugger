//
//  OCDLogService.m
//  OCDebugger
//
//  Created by 崔 明辉 on 15/6/11.
//  Copyright (c) 2015年 PonyCui. All rights reserved.
//

#import "OCDLogService.h"
#import "OCDCore.h"

@implementation OCDLogService

- (void)sendLogItem:(OCDLogEntity *)item {
    [[[[OCDCore sharedCore] socketService] pub] pubMessageToService:@"log"
                                                             method:@"updateLog"
                                                             params:[item toDictionary]];
}

@end
