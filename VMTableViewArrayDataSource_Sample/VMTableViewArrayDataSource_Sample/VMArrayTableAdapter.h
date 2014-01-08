//
//  VMArrayTableAdapter.h
//  VMTableViewArrayDataSource_Sample
//
//  Created by Vittorio Monaco on 07/01/14.
//  Copyright (c) 2014 Vittorio Monaco. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VMArrayTableAdapter : NSObject

- (id) objectAtIndexPath:(NSIndexPath *)indexPath;
- (void) setObject:(id)object atIndexPath:(NSIndexPath *)indexPath;

- (id) objectAtIndex:(NSInteger)index;
- (void) setObject:(id)object atIndex:(NSInteger)index;

- (void)setObject:(id)obj atIndexedSubscript:(NSUInteger)idx;
- (id)objectAtIndexedSubscript:(NSUInteger)idx;
- (void)setObject:(id)obj forKeyedSubscript:(id <NSCopying>)key;
- (id)objectForKeyedSubscript:(id <NSCopying>)key;

@end
