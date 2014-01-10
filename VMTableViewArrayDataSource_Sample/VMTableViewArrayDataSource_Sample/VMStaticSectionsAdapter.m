//
//  VMStaticSectionsAdapter.m
//  VMTableViewArrayDataSource_Sample
//
//  Created by Vittorio Monaco on 10/01/14.
//  Copyright (c) 2014 Vittorio Monaco. All rights reserved.
//

#import "VMStaticSectionsAdapter.h"
#import "VMStaticCellsAdapter.h"

@interface VMStaticSectionsAdapter ()

@property (nonatomic, strong) NSMutableDictionary *privateDataStructure;

@end

@implementation VMStaticSectionsAdapter

#pragma mark - Helpers

- (id) keyFromIndex:(NSInteger)index
{
    return [NSString stringWithFormat:@"%d",index];
}

- (NSMutableDictionary *) privateDataStructure
{
    if(!_privateDataStructure)
        _privateDataStructure = [NSMutableDictionary new];
    
    return _privateDataStructure;
}

#pragma mark - Object subscripting

- (VMStaticCellsAdapter *)objectAtIndexedSubscript:(NSUInteger)idx
{
    return [self objectAtIndex:idx];
}

- (void)setObject:(id)obj atIndexedSubscript:(NSUInteger)idx
{
    [self setObject:obj atIndex:idx];
}

#pragma mark - Public interface

- (NSInteger) count
{
    return [self.privateDataStructure allKeys].count;
}

- (VMStaticCellsAdapter *) objectAtIndex:(NSInteger)index
{
    VMStaticCellsAdapter *rows = (VMStaticCellsAdapter *)[self.privateDataStructure objectForKey:[self keyFromIndex:index]];
    
    if(! rows)
        rows = [VMStaticCellsAdapter new];
    
    [self.privateDataStructure setObject:rows forKey:[self keyFromIndex:index]];
    
    return rows;
}

- (void) setObject:(id)object atIndex:(NSInteger)index
{
    if(! self.privateDataStructure)
    {
        self.privateDataStructure = [NSMutableDictionary new];
    }
    
    if(! object)
    {
        [self.privateDataStructure removeObjectForKey:[self keyFromIndex:index]];
        return;
    }
    else
    {
        if([object isKindOfClass:[UITableViewCell class]])
        {
            VMStaticCellsAdapter *rows = [self objectAtIndex:0];
            if(! rows)
                rows = [VMStaticCellsAdapter new];
            
            [rows setObject:object atIndex:index];
            
            [self.privateDataStructure setObject:rows forKey:[self keyFromIndex:index]];
        } else if([object isKindOfClass:[NSArray class]])
        {
            VMStaticCellsAdapter *rows = [VMStaticCellsAdapter new];
            
            int i = 0;
            for(id element in object)
            {
                [rows setObject:element atIndex:i];
                i++;
            }
            
            [self.privateDataStructure setObject:rows forKey:[self keyFromIndex:index]];
        } else if([object isKindOfClass:[VMStaticCellsAdapter class]])
        {
            [self.privateDataStructure setObject:object forKey:[self keyFromIndex:index]];
        } else
        {
            NSLog(@"%@ - Trying to set a %@ where a %@, a %@ or a %@ is expected",
                  NSStringFromClass([self class]),
                  NSStringFromClass([object class]),
                  NSStringFromClass([UITableViewCell class]),
                  NSStringFromClass([NSArray class]),
                  NSStringFromClass([VMStaticCellsAdapter class])
                  );
            return;
        }
    }
}

#pragma mark - Helpers

- (BOOL) stringIsInteger:(NSString *)toCheck storeInto:(int *)pointer
{
    NSScanner* scan = [NSScanner scannerWithString:toCheck];
    return [scan scanInt:pointer] && [scan isAtEnd];
}

- (NSString *) stringFromIndexPath:(NSIndexPath *)indexPath
{
    if(!indexPath)
        return @"";
    
    return [NSString stringWithFormat:@"%d,%d",indexPath.section,indexPath.row];
}
/*
- (NSIndexPath *) indexPathFromString:(NSString *)string
{
    NSArray *components = [string componentsSeparatedByString:@","];
    if([components count] == 1)
    {
        //Try one integer
        int row;
        if([self stringIsInteger:components[0] storeInto:&row])
        {
            return [NSIndexPath indexPathForItem:row inSection:0];
        }
    } else if([components count] == 2)
    {
        //Try two integers
        int row, section;
        if([self stringIsInteger:components[0] storeInto:&section] && [self stringIsInteger:components[1] storeInto:&row])
        {
            return [NSIndexPath indexPathForItem:row inSection:section];
        } else if([self stringIsInteger:components[0] storeInto:&section] && [components[2] length] == 0)
        {
            //TODO
        }
    }
    
    return nil;
}*/

#pragma mark - Object subscripting

- (UITableViewCell *)objectForKeyedSubscript:(id <NSCopying>)key
{
    NSObject *keyObject = (NSObject *)key;
    if([keyObject isKindOfClass:[NSString class]])
    {
        NSLog(@"%@ - At the moment string subscripting is not supported", NSStringFromClass([self class]));
        return nil;
        
        //Parse NSString into NSIndexPath
        /*NSIndexPath *parsed = [self indexPathFromString:(NSString *)keyObject];
        if(parsed)
            return [self objectAtIndexPath:parsed];
         */
    } else if ([keyObject isKindOfClass:[NSIndexPath class]])
    {
        return [self objectAtIndexPath:(NSIndexPath *)keyObject];
    }
    
    return nil;
}

- (void)setObject:(UITableViewCell *)obj forKeyedSubscript:(id <NSCopying>)key
{
    NSObject *keyObject = (NSObject *)key;
    if([keyObject isKindOfClass:[NSString class]])
    {
        NSLog(@"%@ - At the moment string subscripting is not supported", NSStringFromClass([self class]));
        return;
        /*
        //Parse NSString into NSIndexPath
        NSIndexPath *parsed = [self indexPathFromString:(NSString *)keyObject];
        [self setObject:obj atIndexPath:parsed];
         */
    } else if ([keyObject isKindOfClass:[NSIndexPath class]])
    {
        [self setObject:obj atIndexPath:(NSIndexPath *)keyObject];
    }
}

#pragma mark - Public interface

- (UITableViewCell *) objectAtIndexPath:(NSIndexPath *)indexPath
{
    return [[self objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
}

- (void) setObject:(UITableViewCell *)object atIndexPath:(NSIndexPath *)indexPath
{
    VMStaticCellsAdapter *rows = [self objectAtIndex:indexPath.section];
    if(! rows)
        rows = [VMStaticCellsAdapter new];
    
    [rows setObject:object atIndex:indexPath.row];
    
    [self.privateDataStructure setObject:rows forKey:[self keyFromIndex:indexPath.section]];
}

@end