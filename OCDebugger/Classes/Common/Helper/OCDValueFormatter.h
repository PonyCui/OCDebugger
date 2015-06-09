//
//  AFUObjectFormater.h
//  AFUtils
//
//  Created by 崔 明辉 on 14/12/22.
//  Copyright (c) 2014年 多玩事业部 iOS开发组 YY Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef OCDObjectFormatterMacros

    #define OCDObjectFormatterMacros

    #define TOString(object) (NSString *)[OCDValueFormatter objectAsClass:[NSString class] withObject:object]
    #define TONumber(object) (NSNumber *)[OCDValueFormatter objectAsClass:[NSNumber class] withObject:object]
    #define TOInteger(object) [[OCDValueFormatter objectAsClass:[NSNumber class] withObject:object] integerValue]
    #define TOFloat(object) [[OCDValueFormatter objectAsClass:[NSNumber class] withObject:object] floatValue]
    #define TODictionary(object) (NSDictionary *)[OCDValueFormatter objectAsClass:[NSDictionary class] withObject:object]
    #define TOArray(object) (NSArray *)[OCDValueFormatter objectAsClass:[NSArray class] withObject:object]
    #define ISValidArray(theObject, theIndex) (BOOL)[OCDValueFormatter isValidArray:theObject atIndex:theIndex]

#endif

@interface OCDValueFormatter : NSObject

+ (id)objectAsClass:(Class)argClass withObject:(id)argObject;

+ (BOOL)isValidArray:(id)argObject atIndex:(NSUInteger)argIndex;

@end
