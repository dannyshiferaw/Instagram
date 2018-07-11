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
@implementation PhotoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

-(void)configureCell: (Post *) post {
    self.post = post;
    self.postImage.file = post[@"image"];
    [self.postImage loadInBackground];
    self.caption.text = post[@"caption"];
}

@end
