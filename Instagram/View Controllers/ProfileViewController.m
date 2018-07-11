//
//  ProfileViewController.m
//  Instagram
//
//  Created by Daniel Shiferaw on 7/10/18.
//  Copyright © 2018 Daniel Shiferaw. All rights reserved.
//

#import "ProfileViewController.h"
#import <PFQuery.h>
#import "Post.h"
#import "PostCollectionCell.h"

@interface ProfileViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *postCollectionView;

@property (strong, nonatomic) NSMutableArray *userPosts;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.postCollectionView.delegate = self;
    self.postCollectionView.dataSource = self;
    
    [self loadUserPosts];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PostCollectionCell *postCollectionCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PostCollectionCell" forIndexPath:indexPath];
    Post *post = self.userPosts[indexPath.row];
    [postCollectionCell setPost:post];
    [postCollectionCell configure];
    return postCollectionCell; 
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.userPosts.count;
}

-(void)loadUserPosts {
    PFQuery *query = [PFQuery queryWithClassName:[Post parseClassName]];
    [query includeKey:@"author"];
    [query whereKey:@"author" equalTo:[PFUser currentUser]];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray<Post * >* _Nullable userPosts, NSError * _Nullable error) {
        if (userPosts) {
            self.userPosts = [[NSMutableArray alloc] initWithArray:userPosts];
            [self.postCollectionView reloadData];
        }
        else NSLog(@"%@", [error localizedDescription]);
    }];
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
