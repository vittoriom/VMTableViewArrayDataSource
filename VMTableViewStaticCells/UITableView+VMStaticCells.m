//
//  UITableViewController+VMStaticCells.m
//  VMTableViewArrayDataSource_Sample
//
//  Created by Vittorio Monaco on 07/01/14.
//  Copyright (c) 2014 Vittorio Monaco. All rights reserved.
//

#import "UITableView+VMStaticCells.h"
#import <objc/runtime.h>
#import "VMStaticSectionsAdapter.h"
#import "VMStaticCellsAdapter.h"
#import "NSIndexPath+StaticCellsTranslationHelper.h"

const char *kAdapterKey = "VMStaticCellsAdapter";
const char *kChainedDelegateKey = "VMChainedDelegate";

@implementation UITableView (VMStaticCells)

@dynamic chainedDelegate;

- (VMStaticSectionsAdapter *) items
{
    VMStaticSectionsAdapter *adapter = objc_getAssociatedObject(self, kAdapterKey);
    if(!adapter)
    {
        adapter = [VMStaticSectionsAdapter new];
        objc_setAssociatedObject(self, kAdapterKey, adapter, OBJC_ASSOCIATION_RETAIN);
    }
    
    return adapter;
}

- (BOOL) cellIsStaticAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.items objectAtIndexPath:indexPath] != nil;
}

- (id<UITableViewDataSource>) chainedDelegate
{
    return objc_getAssociatedObject(self, kChainedDelegateKey);
}

- (void) setChainedDelegate:(id<UITableViewDataSource>)chainedDelegate
{
    objc_setAssociatedObject(self, kChainedDelegateKey, chainedDelegate, OBJC_ASSOCIATION_ASSIGN);
}

#pragma UITableViewDataSource

- (void) forwardInvocation:(NSInvocation *)anInvocation
{
    if([self.chainedDelegate respondsToSelector:[anInvocation selector]])
        [anInvocation invokeWithTarget:self.chainedDelegate];
    else
        [super forwardInvocation:anInvocation];
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger delegateSections = [self.chainedDelegate numberOfSectionsInTableView:tableView];
    NSInteger staticSections = [self.items count];
    
    NSInteger mergedSections = delegateSections + staticSections;
    
    //Iterate and find shared sections
    for(NSInteger i=0; i<delegateSections + staticSections; i++)
    {
        if([self.chainedDelegate tableView:tableView numberOfRowsInSection:i] > 0 &&
           [self.items[i] count] > 0)
            mergedSections--;
    }
    
    return mergedSections;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self cellIsStaticAtIndexPath:indexPath])
        return [self.items objectAtIndexPath:indexPath];
    else
    {
        NSIndexPath *translatedIndexPath = [self.items translateIndexPath:indexPath];
        [translatedIndexPath setOriginalIndexPath:indexPath];
        return [self.chainedDelegate tableView:tableView cellForRowAtIndexPath:translatedIndexPath];
    }
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger delegateRows = [self.chainedDelegate tableView:tableView numberOfRowsInSection:section];
    NSInteger staticRows = [self.items[section] count];
    
    return staticRows + delegateRows;
}

@end
