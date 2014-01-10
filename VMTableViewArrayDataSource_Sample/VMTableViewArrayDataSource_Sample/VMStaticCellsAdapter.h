//
//  VMStaticCellsAdapter.h
//  VMTableViewArrayDataSource_Sample
//
//  Created by Vittorio Monaco on 07/01/14.
//  Copyright (c) 2014 Vittorio Monaco. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VMStaticCellsAdapter : NSObject

- (NSInteger) count;

- (UITableViewCell *) objectAtIndex:(NSInteger)index;
- (void) setObject:(UITableViewCell *)object atIndex:(NSInteger)index;

- (void)setObject:(id)obj atIndexedSubscript:(NSUInteger)idx;
- (id)objectAtIndexedSubscript:(NSUInteger)idx;

@end
