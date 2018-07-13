//
//  CustomCameraViewController.m
//  Instagram
//
//  Created by Daniel Shiferaw on 7/12/18.
//  Copyright © 2018 Daniel Shiferaw. All rights reserved.
//

#import "CustomCameraViewController.h"
#import "Post.h"

@interface CustomCameraViewController () <AVCapturePhotoCaptureDelegate>

@property (weak, nonatomic) IBOutlet UIView *previewView;

@property (weak, nonatomic) IBOutlet UIImageView *captureImageView;

@property (weak, nonatomic) IBOutlet UITextView *caption;

@property (strong, nonatomic) UITapGestureRecognizer *gRecognizer;

@end

@implementation CustomCameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //setup tap gesture
    UITapGestureRecognizer *gRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(endEditing)];
    [self.view addGestureRecognizer:gRecognizer];
    
    
    self.session = [AVCaptureSession new];
    self.session.sessionPreset = AVCaptureSessionPresetPhoto;
    AVCaptureDevice *backCamera = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *error;
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:backCamera
                                                                        error:&error];
    if (error) {
        NSLog(@"%@", error.localizedDescription);
    } else if (self.session && [self.session canAddInput:input]) {
        [self.session addInput:input];
        self.stillImageOutput = [AVCapturePhotoOutput new];
    }
    
    if ([self.session canAddOutput:self.stillImageOutput]) {
        [self.session addOutput:self.stillImageOutput];
        
    }
    self.videoPreviewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    if (self.videoPreviewLayer) {
        self.videoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspect;
        self.videoPreviewLayer.connection.videoOrientation = AVCaptureVideoOrientationPortrait;
        [self.view.layer addSublayer:self.videoPreviewLayer];
        [self.session startRunning];
    }
    
}
-(void)endEditing {
    [self.view endEditing:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.videoPreviewLayer.frame = self.previewView.bounds;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didTakePhoto:(id)sender {
    AVCapturePhotoSettings *settings = [AVCapturePhotoSettings photoSettingsWithFormat:@{AVVideoCodecKey: AVVideoCodecTypeJPEG}];
    [self.stillImageOutput capturePhotoWithSettings:settings delegate:self];
}

- (void)captureOutput:(AVCapturePhotoOutput *)output didFinishProcessingPhoto:(AVCapturePhoto *)photo error:(nullable NSError *)error {
    NSData *imageData = photo.fileDataRepresentation;
    UIImage *image = [UIImage imageWithData:imageData];
    self.captureImageView.image = image;
}
- (IBAction)didShareBtnTapped:(id)sender {
    UIImage *image = self.captureImageView.image;
    NSString *caption = self.caption.text;
    if (image) {
        [Post postUserImage:image withCaption:caption withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
            if(succeeded) {
                NSLog(@"%@", @"Successfully posted");
            }
        }];
        self.tabBarController.selectedIndex = 0;
    }
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
