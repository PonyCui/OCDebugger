//
//  PPMOutputHelper.h
//  PonyMessenger
//
//  Created by 崔 明辉 on 15-3-29.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^PPMOutputHelperRequestDataObjectCompletionBlock)(id dataObject);

@interface OCDOutputHelper : NSObject

@property (nonatomic, strong) NSError *error;

- (instancetype)initWithJSONObject:(id)JSONObject;

- (instancetype)initWithJSONObject:(id)JSONObject eagerTypes:(NSDictionary *)eagerTypes;

- (void)requestDataObjectWithCompletionBlock:(PPMOutputHelperRequestDataObjectCompletionBlock)completionBlock;

@end
