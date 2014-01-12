//
//  UITableViewController+VMStaticCells.h
//  VMTableViewArrayDataSource_Sample
//
//  Created by Vittorio Monaco on 07/01/14.
//  Copyright (c) 2014 Vittorio Monaco. All rights reserved.
//

@import UIKit;

#import "VMStaticCellsAdapter.h"
#import "VMStaticSectionsAdapter.h"
#import "NSIndexPath+StaticCellsTranslationHelper.h"
#import "UITableViewCell+loadNib.h"

@interface UITableView (VMStaticCells) <UITableViewDataSource>

/**
 Access the static sections of the UITableView.
 This is retained through an associated object.
 
 @return VMStaticSectionsAdapter the object containing all the static sections of the UITableView.
 */
- (VMStaticSectionsAdapter *) items;


/**
 Check if a specified indexPath corresponds to a static cell or not.
 Primarily used internally, can be called anyway from outside
 
 @param indexPath the indexPath you are interested in
 @return BOOL YES if the specified indexPath corresponds to a static cell managed by VMStaticSectionsAdapter, NO otherwise
 */
- (BOOL) cellIsStaticAtIndexPath:(NSIndexPath *)indexPath;

/**
 This is the UITableViewDataSource delegate that the category uses to forward the messages.
 The UITableView dataSource should be set to the UITableView itself, and the chainedDelegate should be 
 the UITableViewDataSource of your choice in your application.
 
 You can also skip this step, but then you have to manually manage static cells in your dataSource methods,
 and you have to manually translate indexPaths.
 */
@property (nonatomic, assign) id<UITableViewDataSource> chainedDelegate;

@end
