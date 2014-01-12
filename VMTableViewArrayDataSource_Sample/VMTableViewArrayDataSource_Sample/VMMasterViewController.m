//
//  VMMasterViewController.m
//  VMTableViewArrayDataSource_Sample
//
//  Created by Vittorio Monaco on 07/01/14.
//  Copyright (c) 2014 Vittorio Monaco. All rights reserved.
//

#import "VMMasterViewController.h"
#import "UITableView+VMStaticCells.h"

@interface VMMasterViewController () {
    NSArray *_firstSectionObjects;
    NSArray *_secondSectionObjects;
    NSArray *_fourthSectionObjects;
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
    
    self.tableView.items[2][0] = [UITableViewCell loadFromNib:@"StaticCells"];
    
    UITableViewCell *staticCell2 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"No"];
    staticCell2.textLabel.text = @"Second row";
    staticCell2.detailTextLabel.text = @"In third section";
    self.tableView.items[2][1] = staticCell2;
    
    _fourthSectionObjects = @[@"Test5",@"Test6",@"Test7"];
    
    self.tableView.dataSource = self.tableView;
    self.tableView.chainedDelegate = self;
    
    [self.tableView reloadData];
    
    double delayInSeconds = 3.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        self.tableView.items[1][3] = nil;
        [self.tableView reloadData];
    });
}

#pragma mark - Table View

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60.0f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
        return _firstSectionObjects.count;
    else if(section == 1)
        return _secondSectionObjects.count;
    else if(section == 3)
        return _fourthSectionObjects.count;
    else
        return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];

    NSObject *object = nil;
    switch (indexPath.section) {
        case 0:
            object = _firstSectionObjects[indexPath.row];
            break;
        case 1:
            object = _secondSectionObjects[indexPath.row];
            break;
        case 3:
            object = _fourthSectionObjects[indexPath.row];
            break;
        default:
            break;
    }
    
    cell.textLabel.text = [object description];
    return cell;
}

@end
