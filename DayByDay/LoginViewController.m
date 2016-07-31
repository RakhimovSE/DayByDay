//
//  ViewController.m
//  DayByDay
//
//  Created by Admin on 18.01.16.
//  Copyright © 2016 Sevastyan Rakhimov. All rights reserved.
//

#import "DayByDayAppDelegate.h"
#import "UserDataController.h"
#import "LoginViewController.h"
#import "ResultTableViewController.h"
#import "SignupViewController.h"
#import "Sync.h"

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
BOOL isLogin;

- (void)viewDidLoad {
    [super viewDidLoad];
    isLogin = NO;
    
    userDataController = [[UserDataController alloc] init];
    
    if ([userDataController getUserCount] > 0) {
        [self performSegueWithIdentifier:@"resultSegue" sender:self];
    }
}

- (IBAction)login:(id)sender {
    [self.view endEditing:YES];
    isLogin = [userDataController login:userEmailTextField.text Password:userPasswordTextField.text];
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    if ([identifier isEqual:@"resultSegue"]) {
        if (!isLogin)
            return NO;
    }
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
