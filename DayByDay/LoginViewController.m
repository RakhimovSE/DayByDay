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
    
    DayByDayAppDelegate *app = (DayByDayAppDelegate*)[[UIApplication sharedApplication] delegate];
    userDataController = [[UserDataController alloc] initWithManagedObjectContext: app.managedObjectContext];
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

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
