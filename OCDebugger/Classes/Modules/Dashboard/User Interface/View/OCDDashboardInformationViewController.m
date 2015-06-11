//
//  OCDDashboardInformationViewController.m
//  OCDebugger
//
//  Created by 崔 明辉 on 15/6/11.
//  Copyright (c) 2015年 PonyCui. All rights reserved.
//

#import "OCDDashboardInformationViewController.h"

@interface OCDDashboardInformationViewController ()

@property (nonatomic, strong) UIBarButtonItem *closeButtonItem;

@end

@implementation OCDDashboardInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Information";
    self.navigationItem.rightBarButtonItem = self.closeButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                      reuseIdentifier:reuseIdentifier];
    }
    [self configureCell:cell atIndex:indexPath.row];
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell atIndex:(NSInteger)index {
    if (index == 0) {
        cell.textLabel.text = @"IDFV";
        NSString *UUIDString = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        cell.detailTextLabel.text = [UUIDString substringFromIndex:[UUIDString length] - 6];
    }
    else if (index == 1) {
        cell.textLabel.text = @"Device Name";
        cell.detailTextLabel.text = [[UIDevice currentDevice] name];
    }
    else if (index == 2) {
        cell.textLabel.text = @"Device System Version";
        cell.detailTextLabel.text = [[UIDevice currentDevice] systemVersion];
    }
    else if (index == 3) {
        cell.textLabel.text = @"Device Model";
        cell.detailTextLabel.text = [[UIDevice currentDevice] model];
    }
}

#pragma mark - Events

- (void)handleCloseButtonTapped {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Getter

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
