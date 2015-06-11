//
//  OCDDashboardPointPresenter.m
//  OCDebugger
//
//  Created by 崔 明辉 on 15/6/11.
//  Copyright (c) 2015年 PonyCui. All rights reserved.
//

#import "OCDDashboardPointPresenter.h"
#import "OCDDashboardPointViewController.h"
#import "OCDDashboardPointInteractor.h"

@interface OCDDashboardPointPresenter ()<OCDDashboardPointInteractorDelegate>

@end

@implementation OCDDashboardPointPresenter

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.pointInteractor = [[OCDDashboardPointInteractor alloc] init];
        self.pointInteractor.delegate = self;
    }
    return self;
}

- (void)updateView {
    [self.pointInteractor findItems];
}

#pragma mark - OCDDashboardPointInteractorDelegate

- (void)foundItems {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.userInterface reloadData];
    });
}

@end
