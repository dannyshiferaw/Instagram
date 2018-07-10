//
//  ViewController.m
//  Instagram
//
//  Created by Daniel Shiferaw on 7/9/18.
//  Copyright © 2018 Daniel Shiferaw. All rights reserved.
//

#import "LoginViewController.h"
#import <PFUser.h>

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didLoginBtnTapped:(id)sender {
    //initialize
    PFUser *user = [PFUser user];
    
    //check attributes
    NSString *username = self.usernameTextField.text;
    NSString *password = self.passwordTextField.text;
    
    //check if attributes are empty
    if ([username isEqualToString:@""] ||
        [password isEqualToString:@""]) {
        //show alert view controller
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                       message:@"Please fill out all fields"
                                                                preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"Ok" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            [alert dismissViewControllerAnimated:YES completion:nil];
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    } else {
        //login
        [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * _Nullable user, NSError * _Nullable error) {
            if (error) { //failure
                //show alert view controller
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                               message:[error localizedDescription]
                                                                        preferredStyle:(UIAlertControllerStyleAlert)];
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"Ok" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                    [alert dismissViewControllerAnimated:YES completion:nil];
                }];
                [alert addAction:action];
                [self presentViewController:alert animated:YES completion:nil];
            } else { //success
                //present timeline view controller
                [self performSegueWithIdentifier:@"fromLoginToTimelineViewController" sender:nil];
            }
        }];
    }
    
    
}
//present signup page
- (IBAction)didSignupBtnTapped:(id)sender {
    [self performSegueWithIdentifier:@"fromLoginToSignupViewController" sender:nil];
}


@end
