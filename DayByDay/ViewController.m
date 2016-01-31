//
//  ViewController.m
//  DayByDay
//
//  Created by Admin on 18.01.16.
//  Copyright © 2016 Sevastyan Rakhimov. All rights reserved.
//

#import "ViewController.h"
#import "Constants.h"
#import "API.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *user_nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *user_passwordTextField;

@end

@implementation ViewController
@synthesize user_nameTextField;
@synthesize user_passwordTextField;
@synthesize outputTextField;
API *api;

- (void)viewDidLoad
{
    [super viewDidLoad];
    api = [[API alloc] init];
}

- (IBAction)loginButton:(id)sender {
    [self.view endEditing:YES];
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                    user_nameTextField.text, @"user_name",
                [Constants md5:user_passwordTextField.text], @"user_password", nil];
    //NSLog(@"result: ", [api getRequestResult:dict]);
    [api showRequestResult:dictionary];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
