//
//  VMMasterViewController.m
//  VMTableViewArrayDataSource_Sample
//
//  Created by Vittorio Monaco on 07/01/14.
//  Copyright (c) 2014 Vittorio Monaco. All rights reserved.
//

#import "VMMasterViewController.h"
#import "UITableView+VMStaticCells.h"
#import "VMStaticCellsAdapter.h"
#import "VMStaticSectionsAdapter.h"
#import "UITableViewCell+loadNib.h"

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
    
    _secondSectionObjects = @[@"Test3", @"Test4"];
    
    self.tableView.items[0][2] = staticCell;
    self.tableView.items[1][1] = [UITableViewCell loadFromNib:@"StaticCells" cellWithIdentifier:@"buttonCell"];
    self.tableView.items[1][3] = [UITableViewCell loadFromNib:@"StaticCells" cellWithTag:10];
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
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
        return _firstSectionObjects.count;
    else
        return _secondSectionObjects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];

    NSDate *object = indexPath.section == 0 ? _firstSectionObjects[indexPath.row] : _secondSectionObjects[indexPath.row];
    cell.textLabel.text = [object description];
    return cell;
}

@end
