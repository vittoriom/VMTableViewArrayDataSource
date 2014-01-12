VMTableViewArrayDataSource
==========================

A simple category to use static UITableViewCells without having to use storyboards

Install:
--------------

If you use CocoaPods, this is as simple as

<code>pod 'VMTableViewStaticCells'</code>

If you don't use CocoaPods, just download the source and copy the content of the folder VMTableViewStaticCells in your project.
You can <code>#import "UITableView+StaticCells.h"</code> and this is all you'll need.

Usage:
--------------

**Setup the UITableView**

To setup the UITableView to work with static cells via code, you only have to

```
self.tableView.dataSource = self.tableView;
self.tableView.chainedDelegate = self;
```

Don't worry for setting the <code>dataSource</code> to the <code>tableView</code> itself, it will automatically forward all the methods to the <code>chainedDelegate</code>!

**Setup a static cell for your UITableView programmatically**

It's as simple as calling

```
self.tableView.items[0][1] = staticCell;
```

And the second row of the first section will automagically be a static cell, as set up in the <code>staticCell</code> instance.

**Setup a static cell loaded from a XIB**

Nothing simpler! Just

```
self.tableView.items[1][1] = [UITableViewCell loadFromNib:@"StaticCells" cellWithIdentifier:@"buttonCell"];
```

To load the <code>UITableViewCell</code> with the <code>reuseIdentifier</code> equal to "buttonCell".
Or if you want to use tags, 

```
self.tableView.items[1][3] = [UITableViewCell loadFromNib:@"StaticCells" cellWithTag:10];
```

And the <code>UITableViewCell</code> will be loaded from the same XIB, but based on the tag value.

**Mix static and dynamic cells**

You can setup a fully-static <code>UITableView</code>, but you can also mix static and dynamic cells, in the same section or in different sections.
To do this, simply setup as above only the static cells you need.
In the

```
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
```

method, you will get the <code>indexPath</code> automatically translated to your system. This means that, e.g.:

```
self.tableView.items[0][0] = staticCell1;
self.tableView.items[0][2] = staticCell2;

self.dynamicItems = @[myItem, myItem2];
```

In this scenario, you will only get 

```
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

```

called twice. Once for the item <code>[0][1]</code> and once for the item <code>[0][3]</code>. 
BUT, you will actually get index paths with values <code>[0][0]</code> and <code>[0][1]</code>, so that you don't have to remember where the static cells are and translate indexes of the array because it's all already done by the <code>UITableView</code> itself ;)
Anyway, if you set up everything with a clever method of translating indexes or with some data structure that doesn't care of getting the indexes translated, you can always access the original <code>indexPath</code> by calling 

```
[indexPath originalIndexPath];
```

Keep in mind that in 

```
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
```

you should only return the number of sections you manage yourself (not sections with only static cells).
To help the category work better, please

return <code>0</code> in

```
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
```

for all the sections you don't manage (completely static sections) like in the following snippet:

```
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
        return _firstSectionObjects.count;
    else if(section == 1)
        return _secondSectionObjects.count;
    else if(section == 3)
        return _fourthSectionObjects.count;
    else
        return 0; //third section is completely static
}
```

**Advanced ways of setting up the static cells**

There are several ways to setup the static cells.
Apart from initializing the cells programmatically or from a XIB file, you can setup arrays of static cells in the following ways:

- You can pass a <code>NSIndexPath</code> directly instead of using indexed subscripting.

```
NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:2];
self.tableView.items[indexPath] = staticCell1;
```

- You can pass a whole <code>NSArray</code> of static cells.

```
self.tableView.items[1] = @[staticCell1, staticCell2, staticCell3];
```

**Removing static cells at runtime**

When you're done with a static cell after the user generated some interesting event, you can simply set nil instead of the static cell and reload the data when you're ready.

```
self.tableView.items[0][0] = nil;
[self.tableView reloadData];
```
