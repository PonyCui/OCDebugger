//
//  OCDHTTPWatcherModifierManager.m
//  OCDebugger
//
//  Created by 崔 明辉 on 15/6/16.
//  Copyright (c) 2015年 PonyCui. All rights reserved.
//

#import "OCDHTTPWatcherModifierManager.h"
#import "OCDHTTPWatcherMappingEntity.h"
#import "OCDDefine.h"
#import "OCDValueFormatter.h"

@interface OCDHTTPWatcherModifierManager ()

@property (nonatomic, copy) NSArray *mappingItems;

@end

@implementation OCDHTTPWatcherModifierManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self fetchModifiers];
    }
    return self;
}

- (void)fetchModifiers {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[[[OCDDefine sharedDefine] HTTPWatcher] modifierRequestURLString]]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError == nil) {
            
            NSMutableArray *mappingItems = [NSMutableArray array];
            
            NSArray *modifiers = TOArray([NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:NULL]);
            [modifiers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                NSDictionary *itemDictionary = TODictionary(obj);
                if (itemDictionary[@"modifier_params"] != nil) {
                    NSData *paramsData = [TOString(itemDictionary[@"modifier_params"]) dataUsingEncoding:NSUTF8StringEncoding];
                    NSDictionary *paramsDictionary = TODictionary([NSJSONSerialization JSONObjectWithData:paramsData options:kNilOptions error:NULL]);
                    if ([TOString(paramsDictionary[@"type"]) isEqualToString:@"mapping"]) {
                        [mappingItems addObject:[[OCDHTTPWatcherMappingEntity alloc] initWithDictionary:paramsDictionary]];
                    }
                }
            }];
            self.mappingItems = mappingItems;
        }
    }];
}

- (NSURLRequest *)modifiedRequest:(NSURLRequest *)request {
    __block NSURLRequest *modifiedRequest = request;
    [self.mappingItems enumerateObjectsUsingBlock:^(OCDHTTPWatcherMappingEntity *obj, NSUInteger idx, BOOL *stop) {
        if ([obj isValidRequest:request]) {
            modifiedRequest = [obj modifiedRequest:request];
        }
    }];
    return modifiedRequest;
}

@end
