//
//  TabBarViewController.m
//  Vacation-Tracker
//
//  Created by Spencer Atkin on 6/24/15.
//  Copyright (c) 2015 Spencer Atkin. All rights reserved.
//

#import "TabBarViewController.h"
#import <Onboard/OnboardingContentViewController.h>
#import <Onboard/OnboardingViewController.h>

@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
        // Shows an information onboard the first time the app is launched.
        if (![[NSUserDefaults standardUserDefaults] boolForKey:@"HasLaunchedOnce"]) {
        // Welcome page
        OnboardingContentViewController *welcomePage = [OnboardingContentViewController contentWithTitle:@"Welcome!" body:@"Thank you for downloading VacationTracker." image:nil buttonText:nil action:nil];
        [welcomePage setTitleTextColor:[UIColor colorWithRed:.97 green:.33 blue:.1 alpha:1]];
        [welcomePage setUnderTitlePadding:185];
        
        // First info page
        OnboardingContentViewController *firstPage = [OnboardingContentViewController contentWithTitle:@"Introduction" body:@"VacationTracker automatically saves the places you visit during your vacations so they can easily be viewed later." image:nil buttonText:nil action:nil];
        [firstPage setUnderTitlePadding:150];
        
        OnboardingContentViewController *secondPage = [OnboardingContentViewController contentWithTitle:@"Controls" body:@"If you want to see all of your visits, they can be shown on the map. If you want to see info about them, visits are sorted by trip in the list view." image:nil buttonText:nil action:nil];
        [secondPage setUnderTitlePadding:130];
        
        // Second info page
        OnboardingContentViewController *thirdPage = [OnboardingContentViewController contentWithTitle:@"Controls" body:@"You can use the search button to discover places around you." image:nil buttonText:nil action:nil];
        [thirdPage setUnderTitlePadding:185];
        
        // Third info page
        OnboardingContentViewController *fourthPage = [OnboardingContentViewController contentWithTitle:@"Controls" body:@"You can also create a visit at your current place using the pin button." image:nil buttonText:@"Get Started!" action:^{
            [self dismissViewControllerAnimated:YES completion:nil];
            [[UIApplication sharedApplication] setStatusBarHidden:NO];
        }];
        [fourthPage setButtonTextColor:[UIColor colorWithRed:.97 green:.33 blue:.1 alpha:1]];
        [fourthPage setUnderTitlePadding:185];
        
        
        // Main onboarding vc
        OnboardingViewController *onboardingVC = [OnboardingViewController onboardWithBackgroundImage:[UIImage imageNamed:@"info-background"] contents:@[welcomePage, firstPage, secondPage, thirdPage, fourthPage]];
        
        // Configures appearance
        [onboardingVC setTopPadding:10];
        
        [onboardingVC setBottomPadding:10];
        [onboardingVC setShouldFadeTransitions:YES];
        
        // Configures page control
        [onboardingVC.pageControl setCurrentPageIndicatorTintColor:[UIColor whiteColor]];
        [onboardingVC.pageControl setBackgroundColor:[UIColor clearColor]];
        [onboardingVC.pageControl setOpaque:NO];
        // Allows the info to be skipped
        [onboardingVC setAllowSkipping:YES];
        onboardingVC.skipHandler = ^{
            [self dismissViewControllerAnimated:YES completion:nil];
            [[UIApplication sharedApplication] setStatusBarHidden:NO];
        };
        [self presentViewController:onboardingVC animated:YES completion:nil];
        [[UIApplication sharedApplication] setStatusBarHidden:YES];

        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"HasLaunchedOnce"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void)loadView {
    [super loadView];
    [[self tabBar] setTintColor:[UIColor colorWithRed:.97 green:.33 blue:.1 alpha:1]];  // Sets tab bar tint color to SocialRadar's orange
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

@end
