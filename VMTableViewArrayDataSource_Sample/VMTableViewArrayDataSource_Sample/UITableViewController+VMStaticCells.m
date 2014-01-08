//
//  UITableViewController+VMStaticCells.m
//  VMTableViewArrayDataSource_Sample
//
//  Created by Vittorio Monaco on 07/01/14.
//  Copyright (c) 2014 Vittorio Monaco. All rights reserved.
//

#import "UITableViewController+VMStaticCells.h"
#import <objc/runtime.h>
#import "VMArrayTableAdapter.h"

const char *kAdapterKey = "VMStaticCellsAdapter";
const char *kChainedDelegateKey = "VMChainedDelegate";

@implementation UITableView (VMStaticCells)

@dynamic chainedDelegate;

- (VMArrayTableAdapter *) rows
{
    VMArrayTableAdapter *adapter = objc_getAssociatedObject(self, kAdapterKey);
    if(!adapter)
    {
        adapter = [VMArrayTableAdapter new];
        objc_setAssociatedObject(self, kAdapterKey, adapter, OBJC_ASSOCIATION_RETAIN);
    }
    
    return adapter;
}

- (BOOL) cellIsStaticAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.rows objectAtIndexPath:indexPath] != nil;
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
    return [self.chainedDelegate numberOfSectionsInTableView:tableView];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self cellIsStaticAtIndexPath:indexPath])
        return (UITableViewCell *)[self.rows objectAtIndexPath:indexPath];
    else
        return [self.chainedDelegate tableView:tableView cellForRowAtIndexPath:indexPath];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.chainedDelegate tableView:tableView numberOfRowsInSection:section];
}

@end
