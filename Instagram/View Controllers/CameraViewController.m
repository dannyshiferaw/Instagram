//
//  CameraViewController.m
//  Instagram
//
//  Created by Daniel Shiferaw on 7/10/18.
//  Copyright © 2018 Daniel Shiferaw. All rights reserved.
//

#import "CameraViewController.h"
#import <ParseUI.h>

@interface CameraViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@end

@implementation CameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

//presentImagePicker
-(void)viewDidAppear:(BOOL)animated {
    //set up image picker, and read from photolibrary
    UIImagePickerController *imagePicker = [UIImagePickerController new];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    //present
    [self presentViewController:imagePicker animated:YES completion:nil];
}
//get image and present post controller
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    //get the image
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    
    //UIImage *resizedImage = [self resizeImage:originalImage withSize:CGSizeMake(239, 180)];
    
    //show image
    self.selectedImageView.image = resizedImage;
    
    //dismiss
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
