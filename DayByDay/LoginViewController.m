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

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *user_nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *user_passwordTextField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *signupButton;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation LoginViewController

@synthesize user_nameTextField;
@synthesize user_passwordTextField;
@synthesize dataController;
BOOL loggedIn;

- (void)viewDidLoad {
    [super viewDidLoad];
    loggedIn = NO;
}

- (IBAction)login:(id)sender {
    [self.view endEditing:YES];
    loggedIn = [dataController login:user_nameTextField.text Password:user_passwordTextField.text];
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    if ([sender isEqual:_loginButton] && !loggedIn) return NO;
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([sender isEqual:_loginButton]) {
        ResultTableViewController *resultViewController = (ResultTableViewController *)[segue destinationViewController];
        resultViewController.dataController = [[ResultDataController alloc] initWithManagedObjectContext:dataController.managedObjectContext];
        return;
    }
    if ([sender isEqual:_signupButton]) {
        SignupViewController *signupViewController = (SignupViewController *)[segue destinationViewController];
        signupViewController.dataController = [[UserDataController alloc] initWithManagedObjectContext:dataController.managedObjectContext];
        return;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
