//
//  VMStaticCellsAdapter
//  VMTableViewArrayDataSource_Sample
//
//  Created by Vittorio Monaco on 07/01/14.
//  Copyright (c) 2014 Vittorio Monaco. All rights reserved.
//

#import "VMStaticCellsAdapter.h"

@interface VMStaticCellsAdapter ()

@property (nonatomic, strong) NSMutableDictionary *privateDataStructure;

@end

@implementation VMStaticCellsAdapter

#pragma mark - Helpers

- (NSMutableDictionary *) privateDataStructure
{
    if(! _privateDataStructure)
        _privateDataStructure = [NSMutableDictionary new];
    
    return _privateDataStructure;
}

- (id) keyFromIndex:(NSInteger)index
{
    return [NSString stringWithFormat:@"%d",index];
}

#pragma mark - Object subscripting

- (UITableViewCell *)objectAtIndexedSubscript:(NSUInteger)idx
{
    return [self objectAtIndex:idx];
}

- (void)setObject:(UITableViewCell *)obj atIndexedSubscript:(NSUInteger)idx
{
    [self setObject:obj atIndex:idx];
}

#pragma mark - Public interface

- (NSInteger) count
{
    return [self.privateDataStructure allKeys].count;
}

- (UITableViewCell *) objectAtIndex:(NSInteger)index
{
    return (UITableViewCell *)[self.privateDataStructure objectForKey:[self keyFromIndex:index]];
}

- (void) setObject:(UITableViewCell *)object atIndex:(NSInteger)index
{
    if(! object)
    {
        [self.privateDataStructure removeObjectForKey:[self keyFromIndex:index]];
    }
    else if(![object isKindOfClass:[UITableViewCell class]])
    {
        NSLog(@"%@ - Trying to set a %@ where a %@ is expected", NSStringFromClass([self class]), NSStringFromClass([object class]), NSStringFromClass([UITableViewCell class]));
    }
    else
    {
        [self.privateDataStructure setObject:object forKey:[self keyFromIndex:index]];
    }
}

@end
