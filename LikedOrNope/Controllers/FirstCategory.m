//
//  UIViewController+FirstCategory.m
//  LikedOrNope
//
//  Created by Shyamak Aggarwal on 1/25/15.
//  Copyright (c) 2015 modocache. All rights reserved.
//

#import "FirstCategory.h"
#import "ChoosePersonViewController.h"

@interface FirstCategory ()
@end

@implementation FirstCategory

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = true;
    self.tabBarController.tabBar.hidden = true;
    
    //background image

   // CGRect* k = CGRectMake(CGFLoat(self.view.frame.origin.x), CGFLoat(self.view.frame.origin.y), CGFLoat(self.view.frame.size.width), CGFLoat(self.view.frame.size.height));
   self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"pic1.jpg"]];

    
    //image(right now, label)
    //    self.label1 = [[UILabel alloc] initWithFrame:CGRectMake(50, 50, 200, 25)];
    //    self.label1.hidden = false;
    //    self.label1.text = @"I am a label";
    
    //Button on the front screen
    self.start = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.start setImage:[UIImage imageNamed:@"pic4.png"] forState:UIControlStateNormal];
    //[self.start setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //self.start.titleLabel.font = [UIFont systemFontOfSize:14.0];
    self.start.frame = CGRectMake(90, 450, 100, 100);
    //self.start.backgroundColor = [UIColor colorWithRed:0.905 green:0.0 blue:0.552 alpha:1.0];
    self.start.clipsToBounds = YES;
    
    self.start.layer.cornerRadius = 100/2.0f;
    //self.start.layer.borderColor=[UIColor redColor].CGColor;
    //self.start.layer.borderWidth=2.0f;
    
    
    //[self.view addSubview:self.label1];
    [self.view addSubview:self.start];
    [self.start addTarget:self action:@selector(clickStart:) forControlEvents:UIControlEventTouchUpInside];
    //[self.start addTarget:self action:@selector(goToChooseScreen) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)clickStart:(UIButton *)sender {
    ChoosePersonViewController *goTo = [[ChoosePersonViewController alloc] init];
    [self.navigationController pushViewController:goTo animated:YES];
}

//- (void)goToChooseScreen {

//  [self.navigationController pushViewController:goTo animated:YES];
//}




@end
