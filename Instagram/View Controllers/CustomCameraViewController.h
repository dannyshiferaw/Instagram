//
//  CustomCameraViewController.h
//  Instagram
//
//  Created by Daniel Shiferaw on 7/12/18.
//  Copyright © 2018 Daniel Shiferaw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface CustomCameraViewController : UIViewController

@property (nonatomic) AVCaptureSession *session;
@property (nonatomic) AVCapturePhotoOutput *stillImageOutput;
@property (nonatomic) AVCaptureVideoPreviewLayer *videoPreviewLayer;

@end
