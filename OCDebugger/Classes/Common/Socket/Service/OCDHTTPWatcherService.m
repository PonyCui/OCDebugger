//
//  OCDHTTPWatcherService.m
//  OCDebugger
//
//  Created by 崔 明辉 on 15/6/12.
//  Copyright (c) 2015年 PonyCui. All rights reserved.
//

#import "OCDHTTPWatcherService.h"
#import "OCDValueFormatter.h"
#import <UIKit/UIKit.h>

@implementation OCDHTTPWatcherService

- (void)resendConnection:(NSDictionary *)params {
    if ([TOString(params[@"deviceIdentifier"]) isEqualToString:[[[UIDevice currentDevice] identifierForVendor] UUIDString]]) {
        NSMutableURLRequest *resendRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:TOString(params[@"requestURLString"])]];
        [resendRequest setHTTPMethod:TOString(params[@"requestMethod"])];
        [resendRequest setHTTPBody:[TOString(params[@"requestBody"]) dataUsingEncoding:NSUTF8StringEncoding]];
        NSDictionary *headerParams = TODictionary([NSJSONSerialization JSONObjectWithData:[TOString(params[@"requestHeader"]) dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:NULL]);
        [resendRequest setAllHTTPHeaderFields:headerParams];
        [resendRequest setValue:@"1" forHTTPHeaderField:@"_OCD.ResendConnection"];
        [NSURLConnection sendAsynchronousRequest:resendRequest queue:[NSOperationQueue mainQueue] completionHandler:nil];
    }
}

@end
