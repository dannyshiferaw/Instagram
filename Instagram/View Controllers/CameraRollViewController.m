//
//  CameraRollViewController.m
//  Instagram
//
//  Created by Daniel Shiferaw on 7/9/18.
//  Copyright © 2018 Daniel Shiferaw. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "CameraRollViewController.h"
#import "Post.h"
#import <ParseUI.h>
#import <MBProgressHUD.h>

@interface CameraRollViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet PFImageView *selectedImageView;
@property (weak, nonatomic) IBOutlet UITextView *captionTextField;

@end

@implementation CameraRollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //show border
    self.captionTextField.layer.borderWidth = 1;
    
    //setup gesture
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(setupView)];
    [self.view addGestureRecognizer:gestureRecognizer];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)endEditing {
    [self.view endEditing:YES];
}

-(void)setupView {
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

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    //get the image
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];

    UIImage *resizedImage = [self resizeImage:originalImage withSize:CGSizeMake(239, 180)];
    
    //set image
    self.selectedImageView.image = resizedImage;
    
    //dismiss
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)didPostBtnTapped:(id)sender {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES]; //show progress indicator
    [Post postUserImage:self.selectedImageView.image withCaption:self.captionTextField.text withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        if (!succeeded)
            NSLog(@"%@", [error localizedDescription]);
        [MBProgressHUD hideHUDForView:self.view animated:YES]; //hide progress indicator when completed
        self.tabBarController.selectedIndex = 0;               //show profile view controller
    }];
}
//resizes image
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

//exit controller if cancel button is clcked,
//go back to timeline
- (IBAction)didCanceBtnTapped:(id)sender {
    self.tabBarController.selectedIndex = 0;
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
