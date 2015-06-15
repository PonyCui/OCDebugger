//
//  OCDDashboardPointTableViewCell.m
//  OCDebugger
//
//  Created by 崔 明辉 on 15/6/11.
//  Copyright (c) 2015年 PonyCui. All rights reserved.
//

#import "OCDDashboardPointTableViewCell.h"
#import "OCDDashboardPointItemInteractor.h"

@interface OCDDashboardPointTableViewCell ()

@property (nonatomic, strong) UISwitch *switcher;

@end

@implementation OCDDashboardPointTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.switcher];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updateWithItemInteractor:(OCDDashboardPointItemInteractor *)itemInteractor {
    self.textLabel.text = itemInteractor.title;
    self.detailTextLabel.text = itemInteractor.subTitle;
    [self.switcher setOn:itemInteractor.isOn];
}

- (void)handleSwitcherValueChanged {
    [self.delegate switchPointValid:self isValid:self.switcher.isOn];
}

#pragma mark - Getter

- (UISwitch *)switcher {
    if (_switcher == nil) {
        _switcher = [[UISwitch alloc] init];
        _switcher.center = CGPointMake(self.frame.size.width - _switcher.frame.size.width / 2.0 - 8.0,
                                       self.frame.size.height / 2.0);
        [_switcher addTarget:self action:@selector(handleSwitcherValueChanged) forControlEvents:UIControlEventValueChanged];
        _switcher.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    }
    return _switcher;
}

@end
