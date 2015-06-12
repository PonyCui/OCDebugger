//
//  OCDHTTPWatcherConnectionEntity.m
//  OCDebugger
//
//  Created by 崔 明辉 on 15/6/8.
//  Copyright (c) 2015年 PonyCui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OCDHTTPWatcherConnectionEntity.h"
#import "OCDValueFormatter.h"

@implementation OCDHTTPWatcherConnectionEntity

- (instancetype)initWithReqeust:(NSURLRequest *)request
{
    self = [super init];
    if (self) {
        self.requestURLString = request.URL.absoluteString;
        self.requestDate = [NSDate date];
        self.requestMethod = [request HTTPMethod];
        self.requestHeader = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:TODictionary([request allHTTPHeaderFields]) options:kNilOptions error:NULL] encoding:NSUTF8StringEncoding];
        if ([request.HTTPBody length] > 1024 * 32) {
            self.requestBody = @"Bigger than 32K, will discard transfer to server.";
        }
        else {
            self.requestBody = [[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding];
        }
    }
    return self;
}

- (instancetype)initWithResponse:(NSURLResponse *)response data:(NSData *)data {
    self = [super init];
    if (self) {
        self.responseURLString = response.URL.absoluteString;
        self.responseMIMEType = response.MIMEType;
        if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
            NSHTTPURLResponse *theResponse = (id)response;
            self.responseStatusCode = [NSString stringWithFormat:@"%ld", (long)theResponse.statusCode];
            self.responseHeader = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:TODictionary([theResponse allHeaderFields]) options:kNilOptions error:NULL] encoding:NSUTF8StringEncoding];
            if ([data length] > 1024 * 32) {
                //Bigger than 32K, will discard transfer to server.
                self.responseString = @"Bigger than 32K, will discard transfer to server.";
            }
            else {
                NSString *dataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                if (dataString != nil && [dataString isKindOfClass:[NSString class]]) {
                    self.responseString = dataString;
                }
            }
            self.responseDataSize = [NSString stringWithFormat:@"%.2fKB", [data length] / 1024.0];
        }
        
    }
    return self;
}

- (NSDictionary *)toDictionary {
    return @{
             @"deviceIdentifier": TOString([[[UIDevice currentDevice] identifierForVendor] UUIDString]),
             @"orderID": TOString(self.orderID),
             @"requestURLString": TOString(self.requestURLString),
             @"requestDate": [NSString stringWithFormat:@"%ld",
                              (long)[self.requestDate timeIntervalSince1970]],
             @"requestMethod": TOString(self.requestMethod),
             @"requestHeader": TOString(self.requestHeader),
             @"responseURLString": TOString(self.responseURLString),
             @"responseMIMEType": TOString(self.responseMIMEType),
             @"responseStatusCode": TOString(self.responseStatusCode),
             @"responseHeader": TOString(self.responseHeader),
             @"responseString": TOString(self.responseString),
             @"responseDataSize": TOString(self.responseDataSize),
             @"timeUse": TOString(self.timeUse),
             @"requestBody": TOString(self.requestBody)
             };
}

@end
