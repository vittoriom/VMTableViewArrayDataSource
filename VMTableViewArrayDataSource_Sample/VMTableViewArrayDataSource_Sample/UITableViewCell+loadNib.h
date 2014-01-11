//
//  UITableViewCell+loadNib.h
//  VMTableViewArrayDataSource_Sample
//
//  Created by Vittorio Monaco on 11/01/14.
//  Copyright (c) 2014 Vittorio Monaco. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (loadNib)

+ (instancetype) loadFromNib:(NSString *)nibName;

+ (instancetype) loadFromNib:(NSString *)nibName cellWithTag:(NSInteger)tag;

+ (instancetype) loadFromNib:(NSString *)nibName cellWithIdentifier:(NSString *)identifier;

@end
