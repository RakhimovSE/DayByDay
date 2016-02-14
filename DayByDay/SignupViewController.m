//
//  SignupViewController.m
//  DayByDay
//
//  Created by Admin on 01.02.16.
//  Copyright © 2016 Sevastyan Rakhimov. All rights reserved.
//

#import "SignupViewController.h"

@interface SignupViewController () {
    UserDataController *userDataController;
}

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *repeatPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UIButton *signupButton;

@end

@implementation SignupViewController

@synthesize emailTextField;
@synthesize passwordTextField;
@synthesize repeatPasswordTextField;
@synthesize nameTextField;

- (void)viewDidLoad {
    [super viewDidLoad];
    userDataController = [[UserDataController alloc] initWithDataController:_dataController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    BOOL signedUp = NO;
    if ([sender isEqual:_signupButton]) {
        signedUp = [userDataController signup:emailTextField.text
                                     Password:passwordTextField.text
                               RepeatPassword:repeatPasswordTextField.text
                                         Name:nameTextField.text];
    }
    return signedUp;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
