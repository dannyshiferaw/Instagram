//
//  DetailViewController.m
//  Instagram
//
//  Created by Daniel Shiferaw on 7/10/18.
//  Copyright © 2018 Daniel Shiferaw. All rights reserved.
//

#import "DetailViewController.h"
#import <ParseUI.h>
#import <PFUser.h>
#import <DateTools.h>

@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet PFImageView *photoImage;

@property (weak, nonatomic) IBOutlet UILabel *caption;

@property (weak, nonatomic) IBOutlet UILabel *comment_count;

@property (weak, nonatomic) IBOutlet UILabel *likes_count;

@property (weak, nonatomic) IBOutlet UILabel *createAt;



@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    self.photoImage.file = self.post[@"image"];
    [self.photoImage loadInBackground];
    self.caption.text = self.post[@"caption"];
    
    //load timestamp
    self.createAt.text = [[self.post createdAt] shortTimeAgoSinceNow];
    //load likes count
    NSString *likes_count = [NSString stringWithFormat:@"%@", [self.post objectForKey:@"likeCount"]];
    self.likes_count.text = [likes_count stringByAppendingString: @" likes"];
    //load comment count
    NSString *comments_count = [NSString stringWithFormat:@"%@", [self.post commentCount]];
    self.comment_count.text = [NSString stringWithFormat:@"%@%@",comments_count, @" comments"];

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
