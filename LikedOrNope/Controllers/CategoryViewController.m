//
//  UIViewController+CategoryViewController.m
//  LikedOrNope
//
//  Created by Utkarsh Garg on 1/25/15.
//  Copyright (c) 2015 modocache. All rights reserved.
//

#import "CategoryViewController.h"
#import "CategoryViewCell.h"
#import "CategoryData.h"

@interface CategoryViewController ()

@property NSMutableArray *toDoItems;

@end

@implementation CategoryViewController {

    UITableView *tableView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = false;
    self.toDoItems = [[NSMutableArray alloc] init];
    
    // init table view
    tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    // must set delegate & dataSource, otherwise the the table will be empty and not responsive
    tableView.delegate = self;
    tableView.dataSource = self;
    
    tableView.backgroundColor = [UIColor whiteColor];
    
    // add to canvas
    [self loadInitialData];
    [self.view addSubview:tableView];
}

#pragma mark - UITableViewDataSource
// number of section(s), now I assume there is only 1 section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)theTableView
{
    return 1;
}

// number of row in the section, I assume there is only 1 row
- (NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)section
{
    return [self.toDoItems count];
}

// the cell will be returned to the tableView
- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"HistoryCell";
    
    // Similar to UITableViewCell, but
    CategoryViewCell *cell = (CategoryViewCell *)[theTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[CategoryViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    // Just want to test, so I hardcode the data
    cell.descriptionLabel.text = @"Men's Shoes";
    return cell;
}

#pragma mark - UITableViewDelegate
// when user tap the row, what action you want to perform
- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"selected %d row", indexPath.row);
}

- (void)loadInitialData {
    CategoryData *item1 = [[CategoryData alloc] init];
    item1.itemName = @"Men's Shirts";
    [self.toDoItems addObject:item1];
    CategoryData *item2 = [[CategoryData alloc] init];
    item2.itemName = @"Women's Dresses";
    [self.toDoItems addObject:item2];
    CategoryData *item3 = [[CategoryData alloc] init];
    item3.itemName = @"Men's Shoes";
    [self.toDoItems addObject:item3];
    CategoryData *item4 = [[CategoryData alloc] init];
    item4.itemName = @"Women's Shoes";
    [self.toDoItems addObject:item4];
}


@end
