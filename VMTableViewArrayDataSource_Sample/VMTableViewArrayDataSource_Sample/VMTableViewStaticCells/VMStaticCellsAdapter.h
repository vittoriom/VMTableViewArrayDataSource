//
//  VMStaticCellsAdapter.h
//  VMTableViewArrayDataSource_Sample
//
//  Created by Vittorio Monaco on 07/01/14.
//  Copyright (c) 2014 Vittorio Monaco. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VMStaticCellsAdapter : NSObject

/**
 @return the number of static rows managed by this section
 */
- (NSInteger) count;

/**
 @return the static UITableViewCell at the specified index, or nil if no static cell exists at that index
 */
- (UITableViewCell *) objectAtIndex:(NSInteger)index;

/**
 Sets a UITableViewCell object at the specified index (indexes can also be non sequential).
 If the object is not a UITableViewCell, the method has no effect
 If the object is nil, the static cell is removed and not managed by this section anymore
 */
- (void) setObject:(UITableViewCell *)object atIndex:(NSInteger)index;

/**
 Provides a convenient way to set a UITableViewCell without calling
 - (void) setObject:atIndex:
 
 This method has the same effect as the method above
 */
- (void)setObject:(id)obj atIndexedSubscript:(NSUInteger)idx;

/**
 Provides a convenient way to get a UITableViewCell without calling
 - (UITableViewCell *) objectAtIndex:
 
 This method has the same effect as the method above
 */
- (id)objectAtIndexedSubscript:(NSUInteger)idx;

@end
