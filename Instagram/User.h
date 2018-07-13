//
//  User.h
//  Instagram
//
//  Created by Daniel Shiferaw on 7/11/18.
//  Copyright © 2018 Daniel Shiferaw. All rights reserved.
//

#import "PFUser.h"
#import <UIKit/UIKit.h>
#import <PFFile.h>

@interface User : PFUser<PFSubclassing>

@property PFFile *profilePicture;

@end
