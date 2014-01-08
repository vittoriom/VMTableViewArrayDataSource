//
//  VMMasterViewController.m
//  VMTableViewArrayDataSource_Sample
//
//  Created by Vittorio Monaco on 07/01/14.
//  Copyright (c) 2014 Vittorio Monaco. All rights reserved.
//

#import "VMMasterViewController.h"
#import "UITableViewController+VMStaticCells.h"
#import "VMArrayTableAdapter.h"

@interface VMMasterViewController () {
    NSArray *_firstSectionObjects;
    NSArray *_secondSectionObjects;
}
@end

@implementation VMMasterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.preferredContentSize = CGSizeMake(320.0, 600.0);
    }
    
    _firstSectionObjects = @[@"Test",@"Test2"];
    
    UITableViewCell *staticCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"No"];
    staticCell.textLabel.text = @"Third row";
    staticCell.detailTextLabel.text = @"In first section";
    
    UITableViewCell *staticCell2 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"No2"];
    staticCell2.textLabel.text = @"Third row";
    staticCell2.detailTextLabel.text = @"In second section";
    
    UITableViewCell *staticCell3 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"No3"];
    staticCell3.textLabel.text = @"Fourth row";
    staticCell3.detailTextLabel.text = @"In second section";
    
    _secondSectionObjects = @[@"Test3", @"Test4"];
    
    self.tableView.rows[@"0,2"] = staticCell;
    self.tableView.rows[@"1,2"] = staticCell2;
    self.tableView.rows[@"1,3"] = staticCell3;
    self.tableView.chainedDelegate = self;
    self.tableView.dataSource = self.tableView;
    
    [self.tableView reloadData];
}

#pragma mark - Table View

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60.0f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
        return _firstSectionObjects.count + 1;
    else
        return _secondSectionObjects.count + 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];

    NSDate *object = indexPath.section == 0 ? _firstSectionObjects[indexPath.row] : _secondSectionObjects[indexPath.row];
    cell.textLabel.text = [object description];
    return cell;
}

@end
