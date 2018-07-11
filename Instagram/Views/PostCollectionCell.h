//
//  PostCollectionCell.h
//  Instagram
//
//  Created by Daniel Shiferaw on 7/11/18.
//  Copyright © 2018 Daniel Shiferaw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"
#import <ParseUI.h>

@interface PostCollectionCell : UICollectionViewCell

@property (strong, nonatomic) Post *post;

@property (weak, nonatomic) IBOutlet PFImageView *postImage;

-(void) configure;



@end
