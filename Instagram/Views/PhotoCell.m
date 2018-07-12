//
//  PhotoCell.m
//  Instagram
//
//  Created by Daniel Shiferaw on 7/9/18.
//  Copyright © 2018 Daniel Shiferaw. All rights reserved.
//

#import "PhotoCell.h"
#import "Post.h"
#import <ParseUI.h>
#import <DateTools.h>
#import "User.h"


@implementation PhotoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

-(void)configure {
    //load username and profile picture
    User *user = (User *)[self.post author];
    NSString *username = [user username];
    self.username.text = username;
    self.usernameForCaption.text = username;
    PFFile *profile_picture = [user objectForKey:@"profilePicture"];
    if (profile_picture) {
        self.profileImage.file = profile_picture;
        [self.profileImage loadInBackground];
    }
    //load post image
    self.postImage.file = [self.post objectForKey:@"image"];
    [self.postImage loadInBackground];
    //load caption
    self.caption.text = [self.post objectForKey:@"caption"];
    //load timestamp
    self.createAt.text = [[self.post createdAt] shortTimeAgoSinceNow];
    //load likes count
    NSString *likes_count = [NSString stringWithFormat:@"%@", [self.post objectForKey:@"likeCount"]];
    self.views_count.text = [likes_count stringByAppendingString: @" likes"];
    //load comment count
    NSString *comments_count = [NSString stringWithFormat:@"%@", [self.post commentCount]];
    self.comment_count.text = [NSString stringWithFormat:@"%@%@",comments_count, @" comments"];
    
    //toggle button
    if (self.post.is_liked) self.likeBtn.selected= YES;
    else self.likeBtn.selected = NO;
}

-(void)refresh {
    self.views_count.text = [[NSString stringWithFormat:@"%@", self.post.likeCount] stringByAppendingString:@" likes"];
}

- (IBAction)didLikeBtnTapped:(id)sender {
    if (self.post.is_liked) {
        self.post.is_liked = NO;
        self.likeBtn.selected = NO;
        self.post.likeCount = @([self.post.likeCount intValue] - 1);
    } else {
        self.post.is_liked = YES;
        self.likeBtn.selected = YES;
        self.post.likeCount = @([self.post.likeCount intValue] + 1);
    }
    [self.post saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) [self refresh];
    }];
}


@end
