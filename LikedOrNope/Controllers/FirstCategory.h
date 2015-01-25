//
//  UIViewController+FirstCategory.h
//  LikedOrNope
//
//  Created by Shyamak Aggarwal on 1/25/15.
//  Copyright (c) 2015 modocache. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface FirstCategory : UIViewController

//@property (nonatomic, strong) FirstScreenView *displayView;
@property (strong, nonatomic) UILabel *label1;
@property (strong, nonatomic) UIButton *start;
@property (strong, nonatomic) UIImageView *basePic;
- (IBAction)clickStart:(UIButton *)sender;

@end
