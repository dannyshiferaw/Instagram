//
//  SignupViewController.m
//  Instagram
//
//  Created by Daniel Shiferaw on 7/9/18.
//  Copyright © 2018 Daniel Shiferaw. All rights reserved.
//

#import "SignupViewController.h"
#import <PFUser.h>

@interface SignupViewController ()

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;



@end

@implementation SignupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didSignupBtnTapped:(id)sender {
    [self registerNewUser];
}

-(void)registerNewUser {
    //initialize new user
    PFUser *newUser = [PFUser user];
    
    //check user inputs
    newUser.email = self.emailTextField.text;
    newUser.username = self.usernameTextField.text;
    newUser.password = self.passwordTextField.text;
    
    if ([newUser.email isEqualToString:@""] ||
        [newUser.username isEqualToString:@""] ||
        [newUser.password isEqualToString:@""]) {

        //show alert view controller
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                       message:@"Please fill out all fields"
                                                                preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"Ok" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            [alert dismissViewControllerAnimated:YES completion:nil];
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    //register
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        //if sucessful goto timeline, otherwise alert user.
        if(succeeded) {
            //goto timeline view controller
            [self performSegueWithIdentifier:@"fromSignupToTimelineViewController" sender:nil];
        } else {
            //show alert view controller
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Login Failed"
                                                                           message:[error localizedDescription]
                                                                    preferredStyle:(UIAlertControllerStyleAlert)];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"Ok" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                [alert dismissViewControllerAnimated:YES completion:^{
                    //clear fields after user clicks on okay.
                    self.emailTextField.text = @"";
                    self.usernameTextField.text = @"";
                    self.passwordTextField.text = @"";
                }];
            }];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }];
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
