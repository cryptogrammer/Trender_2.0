//
//  UIViewController+CategoryViewController.h
//  LikedOrNope
//
//  Created by Utkarsh Garg on 1/25/15.
//  Copyright (c) 2015 modocache. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoryViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource> {
    int selectedIndex;
    NSArray *titleArray;
}

@property (nonatomic, strong) UILabel *descriptionLabel;


@end
