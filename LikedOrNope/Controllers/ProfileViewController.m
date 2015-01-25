//
//  UIViewController+ProfileViewController.m
//  LikedOrNope
//
//  Created by Shyamak Aggarwal on 1/25/15.
//  Copyright (c) 2015 modocache. All rights reserved.
//

#import "ProfileViewController.h"
#import "ChoosePersonViewController.h"

@implementation ProfileViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    self.test.frame = CGRectMake(50, 50, 100, 60);
    
    [self.view addSubview:self.test];
    [self.test addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
}

- (IBAction)goBack:(UIButton *)sender {
    ChoosePersonViewController *goBack = [[ChoosePersonViewController alloc] init];
    [self.navigationController pushViewController:goBack animated:YES];
}


@end
