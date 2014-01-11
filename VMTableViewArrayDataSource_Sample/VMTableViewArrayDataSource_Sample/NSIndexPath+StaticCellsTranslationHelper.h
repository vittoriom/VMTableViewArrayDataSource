//
//  NSIndexPath+StaticCellsTranslationHelper.h
//  VMTableViewArrayDataSource_Sample
//
//  Created by Vittorio Monaco on 11/01/14.
//  Copyright (c) 2014 Vittorio Monaco. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSIndexPath (StaticCellsTranslationHelper)

/**
 This property is used internally from the UITableView+VMStaticCells category
 Your chainedDelegate (UITableViewDataSource) will be able to access the originalIndexPath in
 - (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath method
 where the indexPath parameter will be the translated indexPath
 
 If the indexPath was not translated, originalIndexPath will contain the same value as indexPath
 */
@property (nonatomic, copy) NSIndexPath *originalIndexPath;

@end
