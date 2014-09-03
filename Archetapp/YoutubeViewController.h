//
//  YoutubeViewController.h
//  Archetapp
//
//  Created by Jared Davidson on 7/15/14.
//  Copyright (c) 2014 Archetapp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoViewController.h"

@interface YoutubeViewController : UITableViewController{
    
    NSString *HTMLURL;

    int title;
}

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@property (weak, nonatomic) NSString *YoutuberName;
@property (weak, nonatomic) NSString *YoutuberTitle;
@property (strong, nonatomic) NSDictionary *posts;
@property (strong, nonatomic) NSMutableArray *post;
@property (strong, nonatomic) id responseObject;

-(void) retrieveData;

@end
