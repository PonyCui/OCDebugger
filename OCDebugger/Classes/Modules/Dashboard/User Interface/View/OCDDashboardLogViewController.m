//
//  OCDDashboardLogViewController.m
//  OCDebugger
//
//  Created by 崔 明辉 on 15/6/11.
//  Copyright (c) 2015年 PonyCui. All rights reserved.
//

#import "OCDDashboardLogViewController.h"
#import "OCDCore.h"

@interface OCDDashboardLogViewController ()

@property (nonatomic, strong) UIBarButtonItem *closeButtonItem;
@property (nonatomic, strong) UITextView *textView;

@property (nonatomic, strong) NSTimer *refreshTimer;

@end

@implementation OCDDashboardLogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Log";
    self.navigationItem.rightBarButtonItem = self.closeButtonItem;
    [self.view addSubview:self.textView];
    self.textView.text = [[[[OCDCore sharedCore] log] manager] consoleText];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.refreshTimer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(handleRefreshTimerTrigger) userInfo:nil repeats:YES];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.refreshTimer invalidate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillLayoutSubviews {
    self.textView.frame = self.view.bounds;
}

#pragma mark - Events

- (void)handleCloseButtonTapped {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)handleRefreshTimerTrigger {
    self.textView.text = [[[[OCDCore sharedCore] log] manager] consoleText];
}

#pragma mark - Getter

- (UITextView *)textView {
    if (_textView == nil) {
        _textView = [[UITextView alloc] initWithFrame:self.view.bounds];
        _textView.editable = NO;
    }
    return _textView;
}

- (UIBarButtonItem *)closeButtonItem {
    if (_closeButtonItem == nil) {
        _closeButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Close"
                                                            style:UIBarButtonItemStyleDone
                                                           target:self
                                                           action:@selector(handleCloseButtonTapped)];
    }
    return _closeButtonItem;
}

@end
