//
//  VMArrayTableAdapter.m
//  VMTableViewArrayDataSource_Sample
//
//  Created by Vittorio Monaco on 07/01/14.
//  Copyright (c) 2014 Vittorio Monaco. All rights reserved.
//

#import "VMArrayTableAdapter.h"

@interface VMArrayTableAdapter ()

@property (nonatomic, strong) NSMutableDictionary *privateDataStructure;

@end

@implementation VMArrayTableAdapter

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
            
        }
    }
    
    return nil;
}

#pragma mark - Object subscripting

- (id)objectForKeyedSubscript:(id <NSCopying>)key
{
    NSObject *keyObject = (NSObject *)key;
    if([keyObject isKindOfClass:[NSString class]])
    {
        //Parse NSString into NSIndexPath
        NSIndexPath *parsed = [self indexPathFromString:(NSString *)keyObject];
        if(parsed)
            return [self objectAtIndexPath:parsed];
    } else if ([keyObject isKindOfClass:[NSIndexPath class]])
    {
        return [self objectAtIndexPath:(NSIndexPath *)keyObject];
    }
    
    return nil;
}

- (void)setObject:(id)obj forKeyedSubscript:(id <NSCopying>)key
{
    NSObject *keyObject = (NSObject *)key;
    if([keyObject isKindOfClass:[NSString class]])
    {
        //Parse NSString into NSIndexPath
        NSIndexPath *parsed = [self indexPathFromString:(NSString *)keyObject];
        [self setObject:obj atIndexPath:parsed];
    } else if ([keyObject isKindOfClass:[NSIndexPath class]])
    {
        [self setObject:obj atIndexPath:(NSIndexPath *)keyObject];
    }
}

- (id)objectAtIndexedSubscript:(NSUInteger)idx
{
    return [self objectAtIndexPath:[NSIndexPath indexPathForItem:idx inSection:0]];
}

- (void)setObject:(id)obj atIndexedSubscript:(NSUInteger)idx
{
    [self setObject:obj atIndexPath:[NSIndexPath indexPathForItem:idx inSection:0]];
}

#pragma mark - Public interface

- (id) objectAtIndexPath:(NSIndexPath *)indexPath
{
    if(! self.privateDataStructure)
        self.privateDataStructure = [NSMutableDictionary new];
    return [self.privateDataStructure objectForKey:[self stringFromIndexPath:indexPath]];
}

- (void) setObject:(id)object atIndexPath:(NSIndexPath *)indexPath
{
    if(! self.privateDataStructure)
        self.privateDataStructure = [NSMutableDictionary new];
    
    [self.privateDataStructure setObject:object forKey:[self stringFromIndexPath:indexPath]];
}

- (id) objectAtIndex:(NSInteger)index
{
    return [self objectAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
}

- (void) setObject:(id)object atIndex:(NSInteger)index
{
    [self setObject:object atIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
}

@end
