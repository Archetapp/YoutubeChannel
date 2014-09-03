//
//  ViewController.m
//  Archetapp
//
//  Created by Jared Davidson on 7/14/14.
//  Copyright (c) 2014 Archetapp. All rights reserved.
//

#import "ViewController.h"
#import "SWRevealViewController.h"
#import "AFNetworking.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *websiteView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
           
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    [self.websiteView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://austinnotduncan.com"]]];
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
