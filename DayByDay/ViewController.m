//
//  ViewController.m
//  DayByDay
//
//  Created by Admin on 18.01.16.
//  Copyright © 2016 Sevastyan Rakhimov. All rights reserved.
//

#import "ViewController.h"
#import "Constants.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *user_nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *user_passwordTextField;

@end

@implementation ViewController
@synthesize user_nameTextField;
@synthesize user_passwordTextField;

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)loginButton:(id)sender {
    //    We begin by creating our POST's body (ergo. what we'd like to send) as an NSString, and converting it to NSData.
    NSString *post = [NSString stringWithFormat:@"user_name=%@&user_password=%@", user_nameTextField.text, [Constants md5:user_passwordTextField.text]];
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    //    Next up, we read the postData's length, so we can pass it along in the request.
    //
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    //    Now that we have what we'd like to post, we can create an NSMutableURLRequest, and include our postData.
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:apiURL]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:postData];
    //    And finally, we can send our request, and read the reply by creating a new NSURLSession:
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        // json to NSString
        //NSString *requestReply = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
        NSLog(@"%ld", statusCode);
        if (statusCode == 200)
            dispatch_async(dispatch_get_main_queue(), ^{
                NSError *e;
                NSMutableArray *jsonList = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&e];
                NSLog(@"jsonList: %@", jsonList);
            });
    }] resume];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
