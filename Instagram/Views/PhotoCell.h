//
//  PhotoCell.h
//  Instagram
//
//  Created by Daniel Shiferaw on 7/9/18.
//  Copyright © 2018 Daniel Shiferaw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"

@interface PhotoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *profileImage;

@property (weak, nonatomic) IBOutlet UILabel *username;

@property (weak, nonatomic) IBOutlet UIImageView *postImage;

@property (weak, nonatomic) IBOutlet UILabel *views_count;

@property (weak, nonatomic) IBOutlet UILabel *caption;

@property (weak, nonatomic) IBOutlet UILabel *comment_count;


-(void)configureCell: (Post *) post;




@end