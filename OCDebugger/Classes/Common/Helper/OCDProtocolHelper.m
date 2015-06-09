//
//  PPMProtocolHelper.m
//  PonyMessenger
//
//  Created by 崔 明辉 on 15-3-29.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "OCDProtocolHelper.h"
#import "OCDValueFormatter.h"

@interface OCDProtocolHelper ()

@end

@implementation OCDProtocolHelper

- (instancetype)initWithMessageString:(NSString *)messageString
{
    self = [super init];
    if (self && [messageString isKindOfClass:[NSString class]]) {
        NSData *messageData = [messageString dataUsingEncoding:NSUTF8StringEncoding];
        if (messageData != nil) {
            NSError *error;
            NSDictionary *messageObject = [NSJSONSerialization JSONObjectWithData:messageData options:kNilOptions error:&error];
            if (error != nil) {
                self.error = error;
            }
            else {
                self.service = TOString(TODictionary(messageObject)[@"s"]);
                self.method = TOString(TODictionary(messageObject)[@"m"]);
                self.params = TODictionary(messageObject)[@"p"];
            }
        }
    }
    else if (self) {
        self.error = [NSError errorWithDomain:@"PPM.ProtocolHelper" code:-1 userInfo:@{NSLocalizedDescriptionKey: @"invalid message."}];
    }
    return self;
}

+ (NSString *)messageWithService:(NSString *)service method:(NSString *)method params:(id)params {
    NSDictionary *messageDictionary;
    if (params == nil) {
        messageDictionary = @{@"s": TOString(service), @"m": TOString(method)};
    }
    else {
        messageDictionary = @{@"s": TOString(service), @"m": TOString(method), @"p": params};
    }
    NSError *error;
    NSString *messageString = [[NSString alloc]
                               initWithData:[NSJSONSerialization dataWithJSONObject:messageDictionary
                                                                            options:kNilOptions error:&error]
                               encoding:NSUTF8StringEncoding];
    if (error == nil) {
        return messageString;
    }
    else {
        return @"";
    }
}

@end
