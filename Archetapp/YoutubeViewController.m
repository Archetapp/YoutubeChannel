//
//  YoutubeViewController.m
//  Archetapp
//
//  Created by Jared Davidson on 7/15/14.
//  Copyright (c) 2014 Archetapp. All rights reserved.
//

#import "YoutubeViewController.h"
#import "AFNetworking/AFNetworking.h"
#import "SWRevealViewController.h"
#import "VideoViewController.h"

@interface YoutubeViewController ()

@property (assign, nonatomic) BOOL ascending;

@end

@implementation YoutubeViewController

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
    [VideoViewController alloc];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
    
    //Create the array from the URL
    self.post = [[NSMutableArray alloc] init];
    
    //Create the reloading circle
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc]
                                        init];
    refreshControl.tintColor = [UIColor colorWithRed:(40/255.0) green:(200/255.0) blue:(252/255.0) alpha:1.0];
    
    //retrieveData is called
    [refreshControl addTarget:self action:@selector(retrieveData) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshControl;
    
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    [self retrieveData];
    
    
}

-(void) retrieveData {
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        //Change this link in order to get the data you want Change the Username!!!
        [manager GET:[NSString stringWithFormat:@"https://gdata.youtube.com/feeds/api/users/%@/uploads?v=2&alt=jsonc", _YoutuberName] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            //Parsing the JSON into something readable
            self.posts = (NSDictionary *)responseObject;
            self.post = self.posts[@"data"][@"items"];
            title = [[self.post valueForKeyPath:@"title"]count];
            // Reloading the Data in the Table
            [self.tableView reloadData];
            [self.refreshControl endRefreshing];
            
            NSLog(@"%@", self.post);
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
        
}
/*
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
*/
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return title;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    
    NSData *mydata = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[[self.post valueForKeyPath:@"thumbnail.hqDefault"] objectAtIndex:indexPath.row]]];
    UIImage *myimage = [[UIImage alloc] initWithData:mydata];
    
    UIImageView *thumbnail = (UIImageView *)[cell viewWithTag:10];
    thumbnail.image = myimage;
    
    UILabel *titleLabel = (UILabel *)[cell viewWithTag:5];
    titleLabel.text = [[self.post valueForKeyPath:@"title"] objectAtIndex:indexPath.row];
    
    return cell;
}

/*

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
 
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //This is where you carry over variables to another view controller
    

    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    // set whatever you want here in your destination view controller
    VideoViewController *destViewController = segue.destinationViewController;
    
    destViewController.videoName = [[self.post valueForKeyPath:@"title"] objectAtIndex:indexPath.row];
    
    destViewController.videoViews = [[self.post valueForKeyPath:@"viewCount"] objectAtIndex:indexPath.row];
    
    HTMLURL = [NSString stringWithFormat:@"http://www.youtube.com/embed/%@",[[self.post valueForKeyPath:@"id"] objectAtIndex:indexPath.row]];
    
    destViewController.videoURL = HTMLURL;
    
    destViewController.videoDescription = [[self.post valueForKeyPath:@"description"] objectAtIndex:indexPath.row];
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}




@end
