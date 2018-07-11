//
//  PostCollectionCell.m
//  Instagram
//
//  Created by Daniel Shiferaw on 7/11/18.
//  Copyright © 2018 Daniel Shiferaw. All rights reserved.
//

#import "PostCollectionCell.h"
#import <ParseUI.h>

@implementation PostCollectionCell

- (void)awakeFromNib {
    
}

- (void) configure {
    self.postImage.file = [self.post objectForKey:@"image"];
    [self.postImage loadInBackground];
}
@end
