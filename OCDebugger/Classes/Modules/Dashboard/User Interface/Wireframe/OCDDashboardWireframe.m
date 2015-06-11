//
//  OCDDashboardWireframe.m
//  OCDebugger
//
//  Created by 崔 明辉 on 15/6/11.
//  Copyright (c) 2015年 PonyCui. All rights reserved.
//

#import "OCDDashboardWireframe.h"
#import "OCDDashboardInformationViewController.h"
#import "OCDDashboardPointViewController.h"
#import "OCDDashboardLogViewController.h"
#import <UIKit/UIKit.h>

@interface OCDDashboardWireframe ()<UIAlertViewDelegate>

@property (nonatomic, strong) UIAlertView *alertView;

@end

@implementation OCDDashboardWireframe

- (void)dealloc
{
    self.alertView.delegate = nil;
}

- (void)showAlertView {
    [self.alertView show];
}

- (void)presentInformationViewController {
    OCDDashboardInformationViewController *viewController = [[OCDDashboardInformationViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    [[[[[UIApplication sharedApplication] delegate] window] rootViewController]
     presentViewController:navigationController animated:YES completion:nil];
}

- (void)presentPointViewController {
    OCDDashboardPointViewController *viewController = [[OCDDashboardPointViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    [[[[[UIApplication sharedApplication] delegate] window] rootViewController]
     presentViewController:navigationController animated:YES completion:nil];
}

- (void)presentLogViewController {
    OCDDashboardLogViewController *viewController = [[OCDDashboardLogViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    [[[[[UIApplication sharedApplication] delegate] window] rootViewController]
     presentViewController:navigationController animated:YES completion:nil];
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    NSString *buttonTitle = [alertView buttonTitleAtIndex:buttonIndex];
    if ([buttonTitle isEqualToString:@"Device Information"]) {
        [self presentInformationViewController];
    }
    else if ([buttonTitle isEqualToString:@"Debug Point"]) {
        [self presentPointViewController];
    }
    else if ([buttonTitle isEqualToString:@"Log"]) {
        [self presentLogViewController];
    }
}

#pragma mark - Getter

- (UIAlertView *)alertView {
    if (_alertView == nil) {
        _alertView = [[UIAlertView alloc] init];
        _alertView.delegate = self;
        _alertView.title = @"OCDebugger Dashboard";
        [_alertView addButtonWithTitle:@"Device Information"];
        [_alertView addButtonWithTitle:@"Debug Point"];
        [_alertView addButtonWithTitle:@"Log"];
        [_alertView addButtonWithTitle:@"HTTP Watcher"];
        [_alertView addButtonWithTitle:@"Cancel"];
        [_alertView setCancelButtonIndex:[_alertView numberOfButtons]-1];
    }
    return _alertView;
}

@end
