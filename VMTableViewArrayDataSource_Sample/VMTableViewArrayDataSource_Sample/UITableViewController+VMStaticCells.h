//
//  UITableViewController+VMStaticCells.h
//  VMTableViewArrayDataSource_Sample
//
//  Created by Vittorio Monaco on 07/01/14.
//  Copyright (c) 2014 Vittorio Monaco. All rights reserved.
//

@import UIKit;

@class VMStaticSectionsAdapter;

@interface UITableView (VMStaticCells) <UITableViewDataSource>

- (VMStaticSectionsAdapter *) items;

- (BOOL) cellIsStaticAtIndexPath:(NSIndexPath *)indexPath;

@property (nonatomic, assign) id<UITableViewDataSource> chainedDelegate;

@end
