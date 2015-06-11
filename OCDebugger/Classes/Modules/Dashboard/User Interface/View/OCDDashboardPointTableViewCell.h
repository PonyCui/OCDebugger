//
//  OCDDashboardPointTableViewCell.h
//  OCDebugger
//
//  Created by 崔 明辉 on 15/6/11.
//  Copyright (c) 2015年 PonyCui. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OCDDashboardPointItemInteractor;

@protocol OCDDashboardPointTableViewCellDelegate <NSObject>

- (void)switchPointValid:(UITableViewCell *)cell isValid:(BOOL)isValid;

@end

@interface OCDDashboardPointTableViewCell : UITableViewCell

@property (nonatomic, weak) id<OCDDashboardPointTableViewCellDelegate> delegate;

- (void)updateWithItemInteractor:(OCDDashboardPointItemInteractor *)itemInteractor;

@end
