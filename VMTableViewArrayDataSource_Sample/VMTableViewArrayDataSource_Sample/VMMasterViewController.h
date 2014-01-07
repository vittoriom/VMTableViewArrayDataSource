//
//  VMMasterViewController.h
//  VMTableViewArrayDataSource_Sample
//
//  Created by Vittorio Monaco on 07/01/14.
//  Copyright (c) 2014 Vittorio Monaco. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VMDetailViewController;

@interface VMMasterViewController : UITableViewController

@property (strong, nonatomic) VMDetailViewController *detailViewController;

@end
