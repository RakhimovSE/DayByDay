//
//  ResultTableViewController.m
//  DayByDay
//
//  Created by Admin on 01.02.16.
//  Copyright © 2016 Sevastyan Rakhimov. All rights reserved.
//

#import "DayByDayAppDelegate.h"
#import "SWRevealViewController.h"
#import "ResultDataController.h"
#import "ResultTableViewController.h"
#import "NewResultViewController.h"

@interface ResultTableViewController () {
    ResultDataController *resultDataController;
    NSMutableDictionary *userResults;
    NSArray *resultNameArray;
    NSArray *periodTypeLengthArray;
}
@property (weak, nonatomic) IBOutlet UIBarButtonItem *createResultButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *menuButton;

@end

@implementation ResultTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    if (self.revealViewController) {
        [self.menuButton setTarget: self.revealViewController];
        [self.menuButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    resultDataController = [[ResultDataController alloc] init];
    
    userResults = [resultDataController getUserResults];
    resultNameArray = [userResults valueForKey:@"result_name"];
    periodTypeLengthArray = [userResults valueForKey:@"fk_periodType_length"];
}

- (IBAction)showMenu:(id)sender {
    [Constants showAlertMessage:[NSString stringWithFormat:@"%@", [resultDataController getUserResults]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return 0;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return resultNameArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"resultTableItem";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    if (!cell)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    cell.textLabel.text = [resultNameArray objectAtIndex:indexPath.row];
    NSString *length = [periodTypeLengthArray objectAtIndex:indexPath.row];
    NSString *detailText = @"";
    if ([length isEqualToString:@"0000-00-01"])
        detailText = @"Цель дня";
    if ([length isEqualToString:@"0000-00-07"])
        detailText = @"Цель недели";
    if ([length isEqualToString:@"0000-01-00"])
        detailText = @"Цель месяца";
    if ([length isEqualToString:@"0000-03-00"])
        detailText = @"Цель четверти";
    if ([length isEqualToString:@"0001-00-00"])
        detailText = @"Цель года";
    cell.detailTextLabel.text = detailText;
    return cell;
}


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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
