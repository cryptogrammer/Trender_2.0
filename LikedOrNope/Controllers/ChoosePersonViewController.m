//
// ChoosePersonViewController.m
//
// Copyright (c) 2014 to present, Brian Gesiak @modocache
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

#import "ChoosePersonViewController.h"
#import "Person.h"
#import <MDCSwipeToChoose/MDCSwipeToChoose.h>
#import "ProfileViewController.h"
#import "CategoryViewController.h"
//#import "GlobalVars.m"
#import "TrendViewController.h"

static const CGFloat ChoosePersonButtonHorizontalPadding = 80.f;
static const CGFloat ChoosePersonButtonVerticalPadding = 20.f;

@interface ChoosePersonViewController ()
@property (nonatomic, strong) NSMutableArray *people;
@end

static NSMutableArray *UIImageArray;

@implementation ChoosePersonViewController

#pragma mark - Object Lifecycle

- (instancetype)init {
    self = [super init];
    if (self) {
        // This view controller maintains a list of ChoosePersonView
        // instances to display.
        _people = [[self defaultPeople] mutableCopy];
    }
    return self;
}

#pragma mark - UIViewController Overrides

- (void)viewDidLoad {
    [super viewDidLoad];
    //UIImage *bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pic1.jpg"]];
    //bg.size.height = self.view.frame.size.height;
    //UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pic1.jpg"]];
    //[self.view addSubview:backgroundView];
    
    self.navigationController.navigationBarHidden = true;
    
    UIBarButtonItem *flipButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Trending"
                                   style:UIBarButtonItemStyleBordered
                                   target:self
                                   action:@selector(flipView:)];
    self.navigationItem.rightBarButtonItem = flipButton;
    //[flipButton setImage:[UIImage imageNamed:@"profilepic.jpg"] forState:UIControlStateNormal];
    
    //[flipButton release];
    
    // Display the first ChoosePersonView in front. Users can swipe to indicate
    // whether they like or dislike the person displayed.
    self.frontCardView = [self popPersonViewWithFrame:[self frontCardViewFrame]];
    [self.view addSubview:self.frontCardView];

    // Display the second ChoosePersonView in back. This view controller uses
    // the MDCSwipeToChooseDelegate protocol methods to update the front and
    // back views after each user swipe.
    self.backCardView = [self popPersonViewWithFrame:[self backCardViewFrame]];
    [self.view insertSubview:self.backCardView belowSubview:self.frontCardView];

    // Add buttons to programmatically swipe the view left or right.
    // See the `nopeFrontCardView` and `likeFrontCardView` methods.
    [self constructNopeButton];
    [self constructLikedButton];
    
    //Buy Now button
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTitle:@"Buy Now" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:1.0 alpha:0.5];
    button.frame = CGRectMake(80.0, 515.0, 160.0, 40.0);
    
    //Add Profile button
    UIButton *profileButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [profileButton setTitle:@"Categories" forState:UIControlStateNormal];
    profileButton.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:1.0 alpha:0.5];
    [profileButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    profileButton.frame = CGRectMake(20, 23, 125, 35);
    [profileButton addTarget:self action:@selector(goCategory:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *profileButton1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [profileButton1 setTitle:@"Trending" forState:UIControlStateNormal];
    profileButton1.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:1.0 alpha:0.5];
    [profileButton1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    profileButton1.frame = CGRectMake(175, 23, 123, 35);
    [profileButton1 addTarget:self action:@selector(doNothing:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
    [self.view addSubview:profileButton];
    [self.view addSubview:profileButton1];
    
    //---------------------------------------------------------------------

    
    
    
    
}

- (IBAction)flipView{
    ProfileViewController *kickAss = [[ProfileViewController alloc] init];
    [self.navigationController pushViewController:kickAss animated:YES];
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (IBAction)goCategory:(UIButton *)sender {
    CategoryViewController *goTo = [[CategoryViewController alloc] init];
    [self.navigationController pushViewController:goTo animated:YES];
}

- (IBAction)doNothing:(UIButton *)sender {
    TrendViewController *goTo = [[TrendViewController alloc] init];
    [self.navigationController pushViewController:goTo animated:YES];

}

#pragma mark - MDCSwipeToChooseDelegate Protocol Methods

// This is called when a user didn't fully swipe left or right.
- (void)viewDidCancelSwipe:(UIView *)view {
    NSLog(@"You couldn't decide on %@.", self.currentPerson.name);
}

// This is called then a user swipes the view fully left or right.
- (void)view:(UIView *)view wasChosenWithDirection:(MDCSwipeDirection)direction {
    // MDCSwipeToChooseView shows "NOPE" on swipes to the left,
    // and "LIKED" on swipes to the right.
    if (direction == MDCSwipeDirectionLeft) {
        NSLog(@"You noped %@.", self.currentPerson.name);
    } else {
        NSLog(@"You liked %@.", self.currentPerson.name);
    }

    // MDCSwipeToChooseView removes the view from the view hierarchy
    // after it is swiped (this behavior can be customized via the
    // MDCSwipeOptions class). Since the front card view is gone, we
    // move the back card to the front, and create a new back card.
    self.frontCardView = self.backCardView;
    if ((self.backCardView = [self popPersonViewWithFrame:[self backCardViewFrame]])) {
        // Fade the back card into view.
        self.backCardView.alpha = 0.f;
        [self.view insertSubview:self.backCardView belowSubview:self.frontCardView];
        [UIView animateWithDuration:0.5
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             self.backCardView.alpha = 1.f;
                         } completion:nil];
    }
}

#pragma mark - Internal Methods

- (void)setFrontCardView:(ChoosePersonView *)frontCardView {
    // Keep track of the person currently being chosen.
    // Quick and dirty, just for the purposes of this sample app.
    _frontCardView = frontCardView;
    self.currentPerson = frontCardView.person;
}

- (NSArray *)defaultPeople {
    // It would be trivial to download these from a web service
    // as needed, but for the purposes of this sample app we'll
    // simply store them in memory.
   // NSLog(@"%@", [[UIImageArray objectAtIndex:0] class]);
    NSString *keyword = @"shirt%20men";
    NSMutableString *url_1 = [[NSMutableString alloc] init ];
    [url_1 appendString:@"http://api.developer.sears.com/v2.1/products/search/Sears/json/keyword/%7B"];
    [url_1 appendString:keyword];
    [url_1 appendString:@"%7D?apikey=BkteZNjC7GR9P4FRq6H4G1XZ2FSHBQi1"];
    
    NSHTTPURLResponse *response = nil;
    NSString *jsonUrlString = url_1;
    NSURL *url = [NSURL URLWithString:[jsonUrlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    //-- Get request and response though URL
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    
    //-- JSON Parsing
    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:nil];
    NSMutableArray *productIds = [[NSMutableArray alloc] init];
    NSMutableArray *productNames = [[NSMutableArray alloc] init];
    // NSMutableArray *productBrandNames = [[NSMutableArray alloc] init];
    NSMutableArray *productImageURLs = [[NSMutableArray alloc] init];
    NSMutableArray *pricingArray = [[NSMutableArray alloc] init];
    UIImageArray = [[NSMutableArray alloc] init];
    
    
    for(int i=0;i<10;i++){
        [productIds addObject:[[[[[result objectForKey:@"SearchResults"] objectForKey:@"Products"] objectAtIndex:i] objectForKey:@"Id"] objectForKey:@"PartNumber"]];
        [productNames addObject:[[[[[result objectForKey:@"SearchResults"] objectForKey:@"Products"] objectAtIndex:i] objectForKey:@"Description"] objectForKey:@"Name"]];
        // [productBrandNames addObject:[[[[[result objectForKey:@"SearchResults"] objectForKey:@"Products"] objectAtIndex:i] objectForKey:@"Description"] objectForKey:@"BrandName"]];
        [productImageURLs addObject:[[[[[result objectForKey:@"SearchResults"] objectForKey:@"Products"] objectAtIndex:i] objectForKey:@"Description"] objectForKey:@"ImageURL"]];
        [pricingArray addObject:[[[[[result objectForKey:@"SearchResults"] objectForKey:@"Products"] objectAtIndex:i] objectForKey:@"Price"] objectForKey:@"DisplayPrice"]];
        // NSLog(@"%@",[productIds objectAtIndex:i]);
        //NSLog(@"%@",[productNames objectAtIndex:i]);
        //NSLog(@"%@",[productBrandNames objectAtIndex:i]);
        // NSLog(@"%@",[productImageURLs objectAtIndex:i]);
        NSURL *imageURL = [NSURL URLWithString:productImageURLs[i]];
        //NSLog(@"%@",[NSURL URLWithString:productImageURLs[i]]);
        NSData *data = [NSData dataWithContentsOfURL:imageURL];
        if(data != nil){
            UIImage* img = [[UIImage alloc] initWithData:data];
            [UIImageArray addObject:img];
           // NSLog(@"%@", [img class]);
            // NSLog(@"Lenght of imageArray: %i", [UIImageArray count]);
        }
        
    }

    return @[
        [[Person alloc] initWithName:[[productNames objectAtIndex:0] substringToIndex:10]
                                image:[UIImageArray objectAtIndex:0]
                                age:4],
        [[Person alloc] initWithName:[[productNames objectAtIndex:1] substringToIndex:10]
                                image:[UIImageArray objectAtIndex:1]
                                age:5
               ],
        [[Person alloc] initWithName:[[productNames objectAtIndex:2] substringToIndex:10]
                                image:[UIImageArray objectAtIndex:2]
                                age:2
               ],
        [[Person alloc] initWithName:[[productNames objectAtIndex:3] substringToIndex:10]
                                image:[UIImageArray objectAtIndex:3]
                                age:22
               ],
        [[Person alloc] initWithName:[[productNames objectAtIndex:4] substringToIndex:10]
                                image:[UIImageArray objectAtIndex:4]
                                age:11
               ],
        [[Person alloc] initWithName:[[productNames objectAtIndex:5] substringToIndex:10]
                                image:[UIImageArray objectAtIndex:5]
                                age:5
               ],
        [[Person alloc] initWithName:[[productNames objectAtIndex:6] substringToIndex:10]
                                image:[UIImageArray objectAtIndex:6]
                                age:3
               ],
        [[Person alloc] initWithName:[[productNames objectAtIndex:7] substringToIndex:10]
                                image:[UIImageArray objectAtIndex:7]
                                age:10
               ],
        [[Person alloc] initWithName:[[productNames objectAtIndex:8] substringToIndex:10]
                                image:[UIImageArray objectAtIndex:8]
                                age:42
               ],
        [[Person alloc] initWithName:[[productNames objectAtIndex:9] substringToIndex:10]
                                image:[UIImageArray objectAtIndex:9]
                                age:9
               ],
    ];
}

- (ChoosePersonView *)popPersonViewWithFrame:(CGRect)frame {
    if ([self.people count] == 0) {
        return nil;
    }

    // UIView+MDCSwipeToChoose and MDCSwipeToChooseView are heavily customizable.
    // Each take an "options" argument. Here, we specify the view controller as
    // a delegate, and provide a custom callback that moves the back card view
    // based on how far the user has panned the front card view.
    MDCSwipeToChooseViewOptions *options = [MDCSwipeToChooseViewOptions new];
    options.delegate = self;
    options.threshold = 160.f;
    options.onPan = ^(MDCPanState *state){
        CGRect frame = [self backCardViewFrame];
        self.backCardView.frame = CGRectMake(frame.origin.x,
                                             frame.origin.y - (state.thresholdRatio * 10.f),
                                             CGRectGetWidth(frame),
                                             CGRectGetHeight(frame));
    };

    // Create a personView with the top person in the people array, then pop
    // that person off the stack.
    ChoosePersonView *personView = [[ChoosePersonView alloc] initWithFrame:frame
                                                                    person:self.people[0]
                                                                   options:options];
    [self.people removeObjectAtIndex:0];
    return personView;
}

#pragma mark View Contruction

- (CGRect)frontCardViewFrame {
    CGFloat horizontalPadding = 20.f;
    CGFloat topPadding = 60.f;
    CGFloat bottomPadding = 200.f;
    return CGRectMake(horizontalPadding,
                      topPadding,
                      CGRectGetWidth(self.view.frame) - (horizontalPadding * 2),
                      CGRectGetHeight(self.view.frame) - bottomPadding);
}

- (CGRect)backCardViewFrame {
    CGRect frontFrame = [self frontCardViewFrame];
    return CGRectMake(frontFrame.origin.x,
                      frontFrame.origin.y + 10.f,
                      CGRectGetWidth(frontFrame),
                      CGRectGetHeight(frontFrame));
}

// Create and add the "nope" button.
- (void)constructNopeButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    UIImage *image = [UIImage imageNamed:@"nope"];
    button.frame = CGRectMake(ChoosePersonButtonHorizontalPadding,
                              CGRectGetMaxY(self.backCardView.frame) + ChoosePersonButtonVerticalPadding,
                              image.size.width,
                              image.size.height);
    [button setImage:image forState:UIControlStateNormal];
    [button setTintColor:[UIColor colorWithRed:247.f/255.f
                                         green:91.f/255.f
                                          blue:37.f/255.f
                                         alpha:1.f]];
    [button addTarget:self
               action:@selector(nopeFrontCardView)
     forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

// Create and add the "like" button.
- (void)constructLikedButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    UIImage *image = [UIImage imageNamed:@"liked"];
    button.frame = CGRectMake(CGRectGetMaxX(self.view.frame) - image.size.width - ChoosePersonButtonHorizontalPadding,
                              CGRectGetMaxY(self.backCardView.frame) + ChoosePersonButtonVerticalPadding,
                              image.size.width,
                              image.size.height);
    [button setImage:image forState:UIControlStateNormal];
    [button setTintColor:[UIColor colorWithRed:29.f/255.f
                                         green:245.f/255.f
                                          blue:106.f/255.f
                                         alpha:1.f]];
    [button addTarget:self
               action:@selector(likeFrontCardView)
     forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

#pragma mark Control Events

// Programmatically "nopes" the front card view.
- (void)nopeFrontCardView {
    [self.frontCardView mdc_swipe:MDCSwipeDirectionLeft];
}

// Programmatically "likes" the front card view.
- (void)likeFrontCardView {
    [self.frontCardView mdc_swipe:MDCSwipeDirectionRight];
}



/**
 * Utkarsh
 
 NSString *keyword = @"shirt%20men";
 NSMutableString *url_1 = [[NSMutableString alloc] init ];
 [url_1 appendString:@"http://api.developer.sears.com/v2.1/products/search/Sears/json/keyword/%7B"];
 [url_1 appendString:keyword];
 [url_1 appendString:@"%7D?apikey=BkteZNjC7GR9P4FRq6H4G1XZ2FSHBQi1"];
 
 NSHTTPURLResponse *response = nil;
 NSString *jsonUrlString = url_1;
 NSURL *url = [NSURL URLWithString:[jsonUrlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
 
 //-- Get request and response though URL
 NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
 NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
 
 //-- JSON Parsing
 NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseData options:nil error:nil];
 NSMutableArray *productIds = [[NSMutableArray alloc] init];
 NSMutableArray *productNames = [[NSMutableArray alloc] init];
 NSMutableArray *productBrandNames = [[NSMutableArray alloc] init];
 NSMutableArray *productImageURLs = [[NSMutableArray alloc] init];
 NSMutableArray *UIImageArray = [[NSMutableArray alloc] init];
 
 
 for(int i=0;i<[[[result objectForKey:@"SearchResults"] objectForKey:@"Products"] count];i++){
 [productIds addObject:[[[[[result objectForKey:@"SearchResults"] objectForKey:@"Products"] objectAtIndex:i] objectForKey:@"Id"] objectForKey:@"PartNumber"]];
 [productNames addObject:[[[[[result objectForKey:@"SearchResults"] objectForKey:@"Products"] objectAtIndex:i] objectForKey:@"Description"] objectForKey:@"Name"]];
 [productBrandNames addObject:[[[[[result objectForKey:@"SearchResults"] objectForKey:@"Products"] objectAtIndex:i] objectForKey:@"Description"] objectForKey:@"BrandName"]];
 [productImageURLs addObject:[[[[[result objectForKey:@"SearchResults"] objectForKey:@"Products"] objectAtIndex:i] objectForKey:@"Description"] objectForKey:@"ImageURL"]];
 
 
 NSLog(@"%@",[productIds objectAtIndex:i]);
 NSLog(@"%@",[productNames objectAtIndex:i]);
 NSLog(@"%@",[productBrandNames objectAtIndex:i]);
 NSLog(@"%@",[productImageURLs objectAtIndex:i]);
 NSURL *imageURL = [NSURL URLWithString:productImageURLs[i]];
 NSData *data = [NSData dataWithContentsOfURL:imageURL];
 [UIImageArray addObject:[[UIImage alloc] initWithData:data]];
 
 }
 */

@end
