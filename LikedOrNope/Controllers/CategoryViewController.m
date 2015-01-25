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

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation CategoryViewController {

    UITableView *tableView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = false;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    selectedIndex = -1;
    titleArray = [[NSArray alloc] init];
    titleArray = [[NSArray alloc] initWithObjects:@"Men's Shirts", @"Women's Dresses", @"Men's Shoes", @"Women's Shoes", nil];
    
    tableView.backgroundColor = [UIColor whiteColor];
    
    // add to canvas
    //[self.view addSubview:tableView];
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        NSString *cellID1=@"CellOne";
        NSString *cellID2=@"CellTwo";
        NSString *cellID3=@"CellThree";
        NSString *cellID4=@"CellFour";
        
        UITableViewCell *cell = nil;
        
        if (0 == indexPath.row) {
            
            cell =[tableView dequeueReusableCellWithIdentifier:cellID1];
            if (cell == nil)
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID1];
            }
            cell.textLabel.text = @"Men's Shirts";
            
        }
        
        else if (1 == indexPath.row)
        {
            cell =[tableView dequeueReusableCellWithIdentifier:cellID2];
            if (cell == nil)
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID2];
            }
            cell.textLabel.text = @"Women's Dresses";
        }
        
        else if (2 == indexPath.row)
        {
            cell =[tableView dequeueReusableCellWithIdentifier:cellID3];
            if (cell == nil)
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID3];
            }
            cell.textLabel.text = @"Men's Shoes";
        }
        
        else
        {
            cell =[tableView dequeueReusableCellWithIdentifier:cellID3];
            if (cell == nil)
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID3];
            }
            cell.textLabel.text = @"Women's Shoes";
        }
        
        return cell;
    }

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (selectedIndex == indexPath.row)
        return 85;
    else
        return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (selectedIndex == indexPath.row) {
        selectedIndex = -1;
        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        return;
    }
    if (selectedIndex != -1){
        NSIndexPath *prevPath = [NSIndexPath indexPathForItem:selectedIndex inSection:0];
        selectedIndex = indexPath.row;
        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:prevPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    
    selectedIndex = indexPath.row;
    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)BtnClick:(UIButton *)sender {
    
}
@end
