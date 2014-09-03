//
//  VideoViewController.m
//  
//
//  Created by Jared Davidson on 8/8/14.
//
//

#import "VideoViewController.h"

@interface VideoViewController ()
@property (weak, nonatomic) IBOutlet UILabel *VideoLabel;
@property (weak, nonatomic) IBOutlet UIWebView *Video;
@property (weak, nonatomic) IBOutlet UITextView *Description;
@property (weak, nonatomic) IBOutlet UILabel *Views;

@end

@implementation VideoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.VideoLabel.text = self.videoName;

    
    self.Views.text = [NSString stringWithFormat:@"Views : %@",self.videoViews];
    
    [self.Video loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", self.videoURL]]]];
    
    self.Description.text = self.videoDescription;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
