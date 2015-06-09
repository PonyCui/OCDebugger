//
//  OCDHTTPWatcherConnectionEntity.m
//  OCDebugger
//
//  Created by 崔 明辉 on 15/6/8.
//  Copyright (c) 2015年 PonyCui. All rights reserved.
//

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
    }
    return self;
}

- (instancetype)initWithResponse:(NSURLResponse *)response {
    self = [super init];
    if (self) {
        self.responseURLString = response.URL.absoluteString;
        self.responseMIMEType = response.MIMEType;
        if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
            NSHTTPURLResponse *theResponse = (id)response;
            self.responseStatusCode = [NSString stringWithFormat:@"%ld", (long)theResponse.statusCode];
            self.responseHeader = [[theResponse allHeaderFields] description];
            
        }
    }
    return self;
}

- (NSDictionary *)toDictionary {
    return @{
             @"requestURLString": TOString(self.requestURLString),
             @"requestDate": [NSString stringWithFormat:@"%ld", (long)[self.requestDate timeIntervalSince1970]],
             @"requestMethod": TOString(self.requestMethod)
             };
}

@end
