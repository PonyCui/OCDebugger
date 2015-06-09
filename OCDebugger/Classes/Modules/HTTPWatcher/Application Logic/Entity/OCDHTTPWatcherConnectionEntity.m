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

- (instancetype)initWithResponse:(NSURLResponse *)response data:(NSData *)data {
    self = [super init];
    if (self) {
        self.responseURLString = response.URL.absoluteString;
        self.responseMIMEType = response.MIMEType;
        if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
            NSHTTPURLResponse *theResponse = (id)response;
            self.responseStatusCode = [NSString stringWithFormat:@"%ld", (long)theResponse.statusCode];
            self.responseHeader = [[theResponse allHeaderFields] description];
            if ([data length] > 1024 * 64) {
                //Bigger than 64K, will discard transfer to server.
                self.responseString = @"Bigger than 64K, will discard transfer to server.";
            }
            else {
                NSString *dataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                if (dataString != nil && [dataString isKindOfClass:[NSString class]]) {
                    self.responseString = dataString;
                }
            }
        }
    }
    return self;
}

- (NSDictionary *)toDictionary {
    return @{
             @"orderID": TOString(self.orderID),
             @"requestURLString": TOString(self.requestURLString),
             @"requestDate": [NSString stringWithFormat:@"%ld",
                              (long)[self.requestDate timeIntervalSince1970]],
             @"requestMethod": TOString(self.requestMethod),
             @"responseURLString": TOString(self.responseURLString),
             @"responseMIMEType": TOString(self.responseMIMEType),
             @"responseStatusCode": TOString(self.responseStatusCode),
             @"responseHeader": TOString(self.responseHeader),
             @"responseString": TOString(self.responseString)
             };
}

@end
