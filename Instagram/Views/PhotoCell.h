//
//  PhotoCell.h
//  Instagram
//
//  Created by Daniel Shiferaw on 7/9/18.
//  Copyright © 2018 Daniel Shiferaw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"
#import "PhotoCell.h"
#import <ParseUI.h>




@interface PhotoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *profileImage;

@property (weak, nonatomic) IBOutlet UILabel *username;

@property (weak, nonatomic) IBOutlet PFImageView *postImage;


@property (weak, nonatomic) IBOutlet UILabel *views_count;

@property (weak, nonatomic) IBOutlet UILabel *caption;

@property (weak, nonatomic) IBOutlet UILabel *comment_count;

@property (strong, nonatomic) Post *post;


-(void)configureCell: (Post *) post;

@end


