//
//  MenuTableViewController.h
//  DayByDay
//
//  Created by Admin on 23.03.16.
//  Copyright © 2016 Sevastyan Rakhimov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuTableViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userScoreLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userAvatarImageView;
@property BOOL syncStarted;
@property (weak, nonatomic) IBOutlet UIImageView *syncImageView;
@property (weak, nonatomic) IBOutlet UILabel *syncLabel;

- (void)setMenuTableViewControllerStyle;

@end
