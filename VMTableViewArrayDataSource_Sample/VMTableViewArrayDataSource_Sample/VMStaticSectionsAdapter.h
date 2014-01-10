//
//  VMStaticSectionsAdapter.h
//  VMTableViewArrayDataSource_Sample
//
//  Created by Vittorio Monaco on 10/01/14.
//  Copyright (c) 2014 Vittorio Monaco. All rights reserved.
//

#import <Foundation/Foundation.h>

@class VMStaticCellsAdapter;

@interface VMStaticSectionsAdapter : NSObject

- (NSInteger) count;

- (VMStaticCellsAdapter *) objectAtIndex:(NSInteger)index;
- (void) setObject:(id)object atIndex:(NSInteger)index;

- (void)setObject:(id)obj atIndexedSubscript:(NSUInteger)idx;
- (id)objectAtIndexedSubscript:(NSUInteger)idx;

- (void)setObject:(id)obj forKeyedSubscript:(id <NSCopying>)key;
- (id)objectForKeyedSubscript:(id <NSCopying>)key;

- (UITableViewCell *) objectAtIndexPath:(NSIndexPath *)indexPath;
- (void) setObject:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

@end
