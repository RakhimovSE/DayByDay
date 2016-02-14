//
//  ViewController.m
//  DayByDay
//
//  Created by Admin on 18.01.16.
//  Copyright © 2016 Sevastyan Rakhimov. All rights reserved.
//

#import "LoginViewController.h"
#import "ResultTableViewController.h"
#import "SignupViewController.h"

@interface LoginViewController () {
    UserDataController *userDataController;
}
@property (weak, nonatomic) IBOutlet UITextField *userEmailTextField;
@property (weak, nonatomic) IBOutlet UITextField *userPasswordTextField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *signupButton;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation LoginViewController

@synthesize userEmailTextField;
@synthesize userPasswordTextField;
BOOL loggedIn;

- (void)viewDidLoad {
    [super viewDidLoad];
    loggedIn = NO;
    userDataController = [[UserDataController alloc] initWithDataController:_dataController];
}

- (IBAction)login:(id)sender {
    [self.view endEditing:YES];
    loggedIn = [userDataController login:userEmailTextField.text Password:userPasswordTextField.text];
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    if ([sender isEqual:_loginButton] && !loggedIn) return NO;
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([sender isEqual:_loginButton]) {
        ResultTableViewController *resultViewController = (ResultTableViewController *)[segue destinationViewController];
        resultViewController.dataController = _dataController;
        return;
    }
    if ([sender isEqual:_signupButton]) {
        SignupViewController *signupViewController = (SignupViewController *)[segue destinationViewController];
        signupViewController.dataController = _dataController;
        return;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
