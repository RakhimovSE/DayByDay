//
//  MenuTableViewController.m
//  DayByDay
//
//  Created by Admin on 23.03.16.
//  Copyright © 2016 Sevastyan Rakhimov. All rights reserved.
//

#import "MenuTableViewController.h"
#import "SWRevealViewController.h"
#import "LoginViewController.h"
#import "SettingsTableViewController.h"
#import "DBRemover.h"
#import "Variables.h"
#import "Users.h"
#import "DataController.h"
#import <AFNetworking.h>
#import "UIImageView+AFNetworking.h"
#import "Sync.h"

@interface MenuTableViewController ()

@end

@implementation MenuTableViewController {
    NSArray *menuItems;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.syncStarted = 0;
    [self setMenuTableViewControllerStyle];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setMenuTableViewControllerStyle {
    void (^setUserAvatarImageViewStyle)(void) = ^() {
        self.userAvatarImageView.layer.cornerRadius = self.userAvatarImageView.frame.size.height /2;
        self.userAvatarImageView.layer.masksToBounds = YES;
        self.userAvatarImageView.layer.borderWidth = 0;
    };
    setUserAvatarImageViewStyle();
    
    Variables *lastSyncLocal = [Variables getVariableWithKey:@"lastSyncLocal"];
    if (lastSyncLocal)
        self.syncLabel.text = [API getSyncDateString:lastSyncLocal.variable_value];
    else
        self.syncLabel.text = NSLocalizedString(@"neverSynced", @"Sync has never been done");
    long userId = [[[DataController alloc] init] getUserId];
    Users *user = (Users *)[Variables getVariable:@"Users" EntityIdKey:@"user_id"
                                    EntityIdValue:[NSString stringWithFormat:@"%ld", userId]];
    
    if (user) {
        self.userNameLabel.text = user.user_name;
        NSString *(^getScoreCase)(void) = ^NSString *() {
            NSString *singularNominative = NSLocalizedString(@"scoreSingularNominative", @"User's score in singular nominative form");
            NSString *singularGenetive = NSLocalizedString(@"scoreSingularGenetive", @"User's score in singular genetive form");
            NSString *pluralGenetive = NSLocalizedString(@"scorePluralGenetive", @"User's score in plural genetive form");
            if (user.user_score % 100 >= 11 && user.user_score % 100 <= 19)
                return pluralGenetive;
            int mod = user.user_score % 10;
            if (mod == 1) return singularNominative;
            if (mod >= 2 && mod <= 4) return singularGenetive;
            return pluralGenetive;
        };
        self.userScoreLabel.text = [NSString stringWithFormat:@"%i %@", user.user_score, getScoreCase()];
        UIImage *userAvatarImage = user.user_avatar ? [UIImage imageWithData:user.user_avatar] :
        [UIImage imageNamed:@"no_avatar.png"];
        self.userAvatarImageView.image = userAvatarImage;
    }
    if (self.syncStarted) {
        self.syncLabel.text = NSLocalizedString(@"syncingProcess", @"Started syncing");
//        [self runSpinAnimationOnView:self.syncImageView duration:1 rotations:1 repeat:HUGE_VALF];
    }
}

- (void)runSpinAnimationOnView:(UIView*)view duration:(CGFloat)duration rotations:(CGFloat)rotations repeat:(float)repeat {
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 /* full rotation*/ * rotations * duration ];
    rotationAnimation.duration = duration;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = repeat;
    
    [view.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

- (void)startSync {
    [self runSpinAnimationOnView:self.syncImageView duration:1 rotations:1 repeat:HUGE_VALF];
    self.syncStarted = 1;
    self.syncLabel.textColor = [UIColor darkGrayColor];
    self.syncLabel.text = NSLocalizedString(@"syncingProcess", @"Started syncing");
    [Sync syncAllData:self];
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return menuItems.count;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell.reuseIdentifier isEqualToString:@"sync"] && !self.syncStarted) {
        [self startSync];
    }
//    NSLog(@"%@", cell.reuseIdentifier);
}

//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSString *CellIdentifier = [menuItems objectAtIndex:indexPath.row];
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
//    
//    return cell;
//}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
}

@end
