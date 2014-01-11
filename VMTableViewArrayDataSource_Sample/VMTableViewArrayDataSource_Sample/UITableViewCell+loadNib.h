//
//  UITableViewCell+loadNib.h
//  VMTableViewArrayDataSource_Sample
//
//  Created by Vittorio Monaco on 11/01/14.
//  Copyright (c) 2014 Vittorio Monaco. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (loadNib)

/**
 Returns a UITableViewCell subclass from a specified xib file.
 
 @param nibName the name of the xib file to load
 
 @return UITableViewCell the UITableViewCell if found (the first found if there are more than one) or nil.
 @discussion If you have more than one UITableViewCell object in the same xib file, please use one of the other two methods of this category
 */
+ (instancetype) loadFromNib:(NSString *)nibName;

/**
 Returns a UIView from a specified xib file, with a specified tag.
 
 @param nibName the name of the xib file to load
 @param tag the tag you want to retrieve
 
 @return UIView the UIView with the specified tag. You should take care of the class of this UIView object, nil if no view with the specified tag exists in the xib
 */
+ (instancetype) loadFromNib:(NSString *)nibName cellWithTag:(NSInteger)tag;

/**
 Returns a UITableViewCell from a specified xib file, with a specified reuseIdentifier
 
 @param nibName the name of the xib file to load
 @param identifier the reuseIdentifier you set for the static UITableViewCell in the xib
 
 @return UITableViewCell the UITableViewCell with the specified reuseIdentifier if found (the first found if there are more than one) or nil.
 */
+ (instancetype) loadFromNib:(NSString *)nibName cellWithIdentifier:(NSString *)identifier;

@end
