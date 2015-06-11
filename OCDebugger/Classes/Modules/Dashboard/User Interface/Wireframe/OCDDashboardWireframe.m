//
//  OCDDashboardWireframe.m
//  OCDebugger
//
//  Created by 崔 明辉 on 15/6/11.
//  Copyright (c) 2015年 PonyCui. All rights reserved.
//

#import "OCDDashboardWireframe.h"
#import <UIKit/UIKit.h>

@interface OCDDashboardWireframe ()

@property (nonatomic, strong) UIAlertView *alertView;

@end

@implementation OCDDashboardWireframe

- (void)showAlertView {
    [self.alertView show];
}

#pragma mark - Getter

- (UIAlertView *)alertView {
    if (_alertView == nil) {
        _alertView = [[UIAlertView alloc] init];
        _alertView.title = @"OCDebugger Dashboard";
        [_alertView addButtonWithTitle:@"Device Information"];
        [_alertView addButtonWithTitle:@"Debug Point"];
        [_alertView addButtonWithTitle:@"Log"];
        [_alertView addButtonWithTitle:@"HTTP Watcher"];
    }
    return _alertView;
}

@end
