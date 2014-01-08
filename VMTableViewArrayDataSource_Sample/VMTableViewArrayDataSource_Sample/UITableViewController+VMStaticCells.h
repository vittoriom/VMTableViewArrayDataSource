//
//  UITableViewController+VMStaticCells.h
//  VMTableViewArrayDataSource_Sample
//
//  Created by Vittorio Monaco on 07/01/14.
//  Copyright (c) 2014 Vittorio Monaco. All rights reserved.
//

@import UIKit;

@class VMArrayTableAdapter;

@interface UITableView (VMStaticCells) <UITableViewDataSource>

- (VMArrayTableAdapter *) rows;

- (BOOL) cellIsStaticAtIndexPath:(NSIndexPath *)indexPath;

@property (nonatomic, assign) id<UITableViewDataSource> chainedDelegate;

@end
