//
//  ProfileUploadViewController.m
//  Instagram
//
//  Created by Daniel Shiferaw on 7/11/18.
//  Copyright © 2018 Daniel Shiferaw. All rights reserved.
//

#import "ProfileUploadViewController.h"
#import <ParseUI.h>
#import <PFUser.h>
#import "Post.h"
#import "User.h"

@interface ProfileUploadViewController ()<UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet PFImageView *profilePic;

@end

@implementation ProfileUploadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //setup gesture
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(presentImagePicker)];
    [self.view addGestureRecognizer:gestureRecognizer];
}

-(void) presentImagePicker {
    //set up image picker, and read from photolibrary
    UIImagePickerController *imagePicker = [UIImagePickerController new];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else {
        NSLog(@"Camera 🚫 available so we will use photo library instead");
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    //present
    [self presentViewController:imagePicker animated:YES completion:nil];
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    
    UIImage *resizedImage = [self resizeImage:originalImage withSize:CGSizeMake(239, 180)];
    
    //set image
    self.profilePic.image = resizedImage;
    //dismiss
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)didUploadTapButton:(id)sender {
    User *user = [User currentUser];
    UIImage *image = self.profilePic.image;
    if (image) {
        user.profilePicture = [Post getPFFileFromImage:image];
        [user saveInBackground];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
    resizeImageView.image = image;
    
    UIGraphicsBeginImageContext(size);
    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
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
