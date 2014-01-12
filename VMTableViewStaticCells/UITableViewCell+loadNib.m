//
//  UITableViewCell+loadNib.m
//  VMTableViewArrayDataSource_Sample
//
//  Created by Vittorio Monaco on 11/01/14.
//  Copyright (c) 2014 Vittorio Monaco. All rights reserved.
//

#import "UITableViewCell+loadNib.h"

@implementation UITableViewCell (loadNib)

+ (instancetype) loadFromNib:(NSString *)nibName
{
    NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil];
    
    for (id object in nibContents)
    {
        if([object isKindOfClass:[UITableViewCell class]])
            return object;
    }
    
    return nil;
}

+ (instancetype) loadFromNib:(NSString *)nibName cellWithIdentifier:(NSString *)identifier
{
    NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil];
    
    for (id object in nibContents)
    {
        if([object isKindOfClass:[UITableViewCell class]] && [[object reuseIdentifier] isEqualToString:identifier])
            return object;
    }
    
    return nil;
}

+ (instancetype) loadFromNib:(NSString *)nibName cellWithTag:(NSInteger)tag
{
    NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil];
    
    for (id object in nibContents)
    {
        if([object tag] == tag)
            return object;
    }
    
    return nil;
}

@end
