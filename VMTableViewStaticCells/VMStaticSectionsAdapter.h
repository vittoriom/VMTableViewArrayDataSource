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

/**
 @return a translated NSIndexPath that takes into account static cells at the (indexPath.section)-th section managed by this object
 
 @discussion The returned NSIndexPath will contain the specified indexPath in the property originalIndexPath.
 
 @see NSIndexPath+StaticCellsTranslationHelper.h
 */
- (NSIndexPath *) translateIndexPath:(NSIndexPath *)indexPath;

/**
 @return the number of static sections managed by this object
 */
- (NSInteger) count;

/**
 @return a VMStaticCellsAdapter object that manages the static rows at the specified index
 
 @discussion This method never returns nil. If the specified index doesn't correspond to a static section, a new section is created immediately
 */
- (VMStaticCellsAdapter *) objectAtIndex:(NSInteger)index;

/**
 This method has multiple usage cases:
 
 1) object is nil. The static cell at the specified index of the first static section will be removed
    It has the same effect of calling [sections[0] setObject:nil atIndex:index]
 
 2) object is a UITableViewCell. This sets the specified UITableViewCell at the specified index of the first section.
    It has the same effect of calling [sections[0] setObject:object atIndex:index]
 
 3) object is an NSArray. This iterates over the array and sets each object of the array at sequential indexes starting from 0.
    If some object is not a UITableViewCell, it skips it.
 
 4) object is a VMStaticCellsAdapter. This sets the specified VMStaticCellsAdapter at the index-th section overwriting what was previously there.
 */
- (void) setObject:(id)object atIndex:(NSInteger)index;

/**
 This method provides a convenient way to call setObject:atIndex:
 
 It has the same effect as the method above
 */
- (void)setObject:(id)obj atIndexedSubscript:(NSUInteger)idx;

/**
 This method provides a convenient way to call objectAtIndex:
 
 It has the same effect as the method above
 */
- (id)objectAtIndexedSubscript:(NSUInteger)idx;

/**
 This method provides a convenient way to call setObject:atIndexPath:
 
 It has the same effect as the method above
 */
- (void)setObject:(id)obj forKeyedSubscript:(id <NSCopying>)key;

/**
 This method provides a convenient way to call objectAtIndexPath:
 
 It has the same effect as the method above
 */
- (id)objectForKeyedSubscript:(id <NSCopying>)key;

/**
 Traverses the data structures to search for the (indexPath.section)-th static section and, given this section,
 the (indexPath.row)-th static row.
 
 @return UITableViewCell the static UITableViewCell corresponding to the specified indexPath, or nil if no static cell exists at that index
 */
- (UITableViewCell *) objectAtIndexPath:(NSIndexPath *)indexPath;

/**
 Traverses the data structures to search for the (indexPath.section)-th static section (it creates one if it doesn't exist yet) and, given this section,
 sets the (indexPath.row)-th static row.
 
 @param cell the static UITableViewCell you want to set at the specified indexPath
 */
- (void) setObject:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

@end
