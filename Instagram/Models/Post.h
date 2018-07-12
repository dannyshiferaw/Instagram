//
//  Post.h
//  Instagram
//
//  Created by Daniel Shiferaw on 7/10/18.
//  Copyright © 2018 Daniel Shiferaw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <PFObject.h>
#import <PFFile.h>
#import <UIKit/UIKit.h>

@interface Post : PFObject<PFSubclassing>

@property (nonatomic, strong) NSString *postId;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) PFUser *author;

@property (nonatomic, strong) NSString *caption;
@property (nonatomic, strong) PFFile *image;
@property BOOL is_liked;
@property (nonatomic, strong) NSNumber *likeCount;
@property (nonatomic, strong) NSNumber *commentCount;

//post
+ (void)postUserImage: (UIImage * _Nullable )image withCaption: ( NSString * _Nullable )caption withCompletion: (PFBooleanResultBlock  _Nullable)completion;
+ (PFFile *)getPFFileFromImage: (UIImage * _Nullable)image;

@end
