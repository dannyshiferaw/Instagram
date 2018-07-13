//
//  TimelineViewController.m
//  Instagram
//
//  Created by Daniel Shiferaw on 7/9/18.
//  Copyright © 2018 Daniel Shiferaw. All rights reserved.
//

#import "TimelineViewController.h"
#import "DetailViewController.h"
#import "PhotoCell.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import <PFQuery.h>
#import "Post.h"

@interface TimelineViewController () <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *posts;

@property (strong, nonatomic) UIRefreshControl *refreshControl;

@property (assign, nonatomic) BOOL isMoreDataLoading;

@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //setup
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

    //setup refresh control
    self.refreshControl = [UIRefreshControl new];
    [self.refreshControl addTarget:self action:@selector(loadPosts) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview: self.refreshControl atIndex:0];
    
    
    //initialize
    self.posts = [NSMutableArray new];
    
    //load posts
    [self loadPosts];
    
}

//reloads whenever timeline controller appears
- (void) viewDidAppear:(BOOL)animated {
    [self loadPosts];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PhotoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PhotoCell" forIndexPath:indexPath];
    Post *post = self.posts[indexPath.row];
    [cell setPost:post];
    [cell configure];
    return cell; 
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.posts.count;
}

//load posts
-(void)loadPosts {
    PFQuery *query = [PFQuery queryWithClassName:[Post parseClassName]];
    [query includeKey:@"author"];
    [query orderByDescending:@"createdAt"];
    query.limit = 20;
    
    [query findObjectsInBackgroundWithBlock:^(NSArray<Post *>*  _Nullable posts, NSError * _Nullable error) {
        if (posts){
            self.posts = [NSMutableArray new]; //empty
            for (Post *post in posts) [self.posts addObject:post];
            [self.tableView reloadData];
            self.isMoreDataLoading = NO;
            [self.refreshControl endRefreshing];
        }
        else NSLog(@"%@", [error localizedDescription]);
    }];
}

//infinite loading
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if(!self.isMoreDataLoading){
        // Calculate the position of one screen length before the bottom of the results
        int scrollViewContentHeight = self.tableView.contentSize.height;
        int scrollOffsetThreshold = scrollViewContentHeight - self.tableView.bounds.size.height;
        
        // When the user has scrolled past the threshold, start requesting
        if(scrollView.contentOffset.y > scrollOffsetThreshold && self.tableView.isDragging) {
            self.isMoreDataLoading = true;
            [self loadPosts];
        }
    }
}

//logout
- (IBAction)didLogoutBtnTapped:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    appDelegate.window.rootViewController = loginViewController;
}


// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
   
    if ([[segue identifier] isEqualToString:@"toDetailViewController"]) {
        PhotoCell *tappedCell = sender;
        DetailViewController *detailViewController = [segue destinationViewController];
        NSIndexPath *index = [self.tableView indexPathForCell:tappedCell];
        detailViewController.post = self.posts[index.row];
    }
}


@end
