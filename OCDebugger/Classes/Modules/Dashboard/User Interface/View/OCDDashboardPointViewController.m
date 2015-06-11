//
//  OCDDashboardPointViewController.m
//  OCDebugger
//
//  Created by 崔 明辉 on 15/6/11.
//  Copyright (c) 2015年 PonyCui. All rights reserved.
//

#import "OCDDashboardPointViewController.h"
#import "OCDDashboardPointPresenter.h"
#import "OCDDashboardPointInteractor.h"
#import "OCDDashboardPointTableViewCell.h"

@interface OCDDashboardPointViewController ()<OCDDashboardPointTableViewCellDelegate>

@property (nonatomic, strong) OCDDashboardPointPresenter *eventHandler;

@property (nonatomic, strong) UIBarButtonItem *closeButtonItem;

@end

@implementation OCDDashboardPointViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"Debug Point";
        self.eventHandler = [[OCDDashboardPointPresenter alloc] init];
        self.eventHandler.userInterface = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = self.closeButtonItem;
    
    [self.eventHandler updateView];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Events

- (void)handleCloseButtonTapped {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)reloadData {
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.eventHandler.pointInteractor.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseIdentifier = @"Cell";
    
    OCDDashboardPointTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    if (cell == nil) {
        cell = [[OCDDashboardPointTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
        cell.delegate = self;
    }
    
    if (indexPath.row < [self.eventHandler.pointInteractor.items count]) {
        cell.tag = indexPath.row;
        OCDDashboardPointItemInteractor *itemInteractor = self.eventHandler.pointInteractor.items[indexPath.row];
        [cell updateWithItemInteractor:itemInteractor];
    }

    return cell;
}

#pragma mark - OCDDashboardPointTableViewCellDelegate

- (void)switchPointValid:(UITableViewCell *)cell isValid:(BOOL)isValid {
    if (cell.tag < [self.eventHandler.pointInteractor.items count]) {
        OCDDashboardPointItemInteractor *itemInteractor = self.eventHandler.pointInteractor.items[cell.tag];
        [itemInteractor setIsOn:isValid];
    }
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
