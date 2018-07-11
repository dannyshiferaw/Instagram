//
//  TimelineViewController.h
//  Instagram
//
//  Created by Daniel Shiferaw on 7/9/18.
//  Copyright © 2018 Daniel Shiferaw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"

@protocol TimelineViewControllerDelegate

-(void)didPostTapped:(Post *)post;

@end
@interface TimelineViewController : UIViewController

@end
