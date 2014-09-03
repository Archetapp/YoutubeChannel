//
//  NavigationViewController.m
//  Archetapp
//
//  Created by Jared Davidson on 7/14/14.
//  Copyright (c) 2014 Archetapp. All rights reserved.
//

#import "YoutubeViewController.h"
#import "NavigationViewController.h"
#import "SWRevealViewController.h"

@interface NavigationViewController ()

@end

@implementation NavigationViewController{
    NSArray * menu;
    
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Enter the http://www.youtube.com/USERNAMEHERE <---- Username
    // Example ----> http://www.youtube.com/archetapp <---- This Username
    menu = @[@"marquesbrownlee",@"duncan33303",@"UnboxTherapy",@"linustechtips", @"pocketnowvideo", @"HardwareCanucks", @"archetapp"];
    
    // After doing this go into Your "Main.storyboard"
    // Create the number of cells that are in your array
    // Set the cell identifier equal to the placement in the "menu" array.
    // Connect a transition from the cell to the "YoutubeViewController"
    // Make sure the transition is set to "Reveal View Controller"
    // The title of the cell can be anything that you want
    // This title will carry over to the next view controller
    
    // !!!!!! MAKE SURE YOU HAVE THE SAME NUMBER OF CELLS AS ITEMS IN YOUR "menu" ARRAY !!!!!
    
    // Enjoy!!
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    
    
    return [menu count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [menu objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    return cell;

}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    // set whatever you want here in your destination view controller
    YoutubeViewController *destViewController = segue.destinationViewController;
    
    NSString *CellIdentifier = [menu objectAtIndex:indexPath.row];
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    
    
    destViewController.title = cell.textLabel.text;
    
    destViewController.YoutuberName = [menu objectAtIndex:indexPath.row];
    
    if ( [segue isKindOfClass: [SWRevealViewControllerSegue class]] ) {
        SWRevealViewControllerSegue *swSegue = (SWRevealViewControllerSegue*) segue;
        
        swSegue.performBlock = ^(SWRevealViewControllerSegue* rvc_segue, UIViewController* svc, UIViewController* dvc) {
            
            UINavigationController* navController = (UINavigationController*)self.revealViewController.frontViewController;
            [navController setViewControllers: @[dvc] animated: NO ];
            [self.revealViewController setFrontViewPosition: FrontViewPositionLeft animated: YES];
        };
        
    }
    cell.selected = false;

}


@end
