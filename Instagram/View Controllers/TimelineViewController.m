//
//  TimelineViewController.m
//  Instagram
//
//  Created by Daniel Shiferaw on 7/9/18.
//  Copyright © 2018 Daniel Shiferaw. All rights reserved.
//

#import "TimelineViewController.h"
#import "PhotoCell.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import <PFQuery.h>
#import "Post.h"

@interface TimelineViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *posts;

@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //setup
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    //initialize
    self.posts = [NSMutableArray new];
    //load posts
    [self loadPosts];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PhotoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PhotoCell" forIndexPath:indexPath];
    Post *post = self.posts[indexPath.row];
    [cell configureCell:post];
    return cell; 
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.posts.count;
}

//load posts
-(void)loadPosts {
    PFQuery *query = [PFQuery queryWithClassName:[Post parseClassName]];
    [query orderByAscending:@"author"];
    query.limit = 20;
    
    [query findObjectsInBackgroundWithBlock:^(NSArray<Post *>*  _Nullable posts, NSError * _Nullable error) {
        if (posts){
            for (Post *post in posts) [self.posts addObject:post];
            [self.tableView reloadData];
        }
        else NSLog(@"%@", [error localizedDescription]);
    }];
}

//logout
- (IBAction)didLogoutBtnTapped:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    appDelegate.window.rootViewController = loginViewController;
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