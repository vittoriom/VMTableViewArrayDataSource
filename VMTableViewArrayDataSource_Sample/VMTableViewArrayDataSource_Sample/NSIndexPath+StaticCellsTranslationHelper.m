//
//  NSIndexPath+StaticCellsTranslationHelper.m
//  VMTableViewArrayDataSource_Sample
//
//  Created by Vittorio Monaco on 11/01/14.
//  Copyright (c) 2014 Vittorio Monaco. All rights reserved.
//

#import "NSIndexPath+StaticCellsTranslationHelper.h"
#import <objc/runtime.h>

const char *kOriginalIndexPathKey = "origIndexPath";

@implementation NSIndexPath (StaticCellsTranslationHelper)

- (NSIndexPath *) originalIndexPath
{
    NSIndexPath *original = objc_getAssociatedObject(self, kOriginalIndexPathKey);
    if(!original)
        return self;
    
    return original;
}

- (void) setOriginalIndexPath:(NSIndexPath *)originalIndexPath
{
    objc_setAssociatedObject(self, kOriginalIndexPathKey, originalIndexPath, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
