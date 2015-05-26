//
//  RearTableViewController.m
//  Social
//
//  Created by Robby on 12/15/14.
//  Copyright (c) 2014 Robby. All rights reserved.
//

#import "RearTableViewController.h"
#import "SWRevealViewController.h"
#import "NewDomeTableViewCell.h"
#import "AppDelegate.h"

@interface RearTableViewController () {
    NSInteger _previouslySelectedRow;
//    UIView *selectionView;
    NSInteger numberOfSavedDomes;
}

@end

@implementation RearTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlack];
    
    if (self.tableView.contentSize.height < self.tableView.frame.size.height) {
        self.tableView.scrollEnabled = NO;
    }
    else {
        self.tableView.scrollEnabled = YES;
    }
    
//    selectionView = [[UIView alloc] init];
//    [selectionView setBackgroundColor:[UIColor blueColor]];
    
//    [self loadTableSelection:[NSIndexPath indexPathForRow:0 inSection:0]];
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    UIEdgeInsets inset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.tableView.contentInset = inset;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0)
        return 1;
    else if (section == 1)
        return 1 + [[[NSUserDefaults standardUserDefaults] objectForKey:@"saved"] count];
    else if(section == 2)
        return 1;
    else if(section == 3)
        return 1;
    else
        return 0;
}
//-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 22;
//}
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0 && indexPath.row == 0)
        return 120;
    return 44;
}
-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}

-(NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(section == 0)
        return @"New Dome";
    else if (section == 1)
        return @"Saved Domes";
    else if(section == 2)
        return @"Domekit";
    else
        return @"";
}

//-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 44;
//}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    if(section == 0){
//        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 900, 3)];
//        [v setBackgroundColor:[UIColor whiteColor]];
//        return v;
//    }
    return nil;
}

//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    PFObject *theBuilding = _buildings[section];
//    
//    CGRect scr = [[UIScreen mainScreen] bounds];
//    
//    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,0,scr.size.width*.5,100)];
//
//    UILabel *tempLabel=[[UILabel alloc]initWithFrame:CGRectMake(-5,100 - [[UIScreen mainScreen] bounds ].size.width*.2*.75,400,[[UIScreen mainScreen] bounds ].size.width*.2)];
//    tempLabel.backgroundColor=[UIColor clearColor];
//    tempLabel.textColor = [UIColor whiteColor]; //here you can change the text color of header.
//    tempLabel.attributedText = attrStr;
//    tempLabel.font = [UIFont fontWithName:@"Avenir-Light" size:[[UIScreen mainScreen] bounds ].size.width*.2];
//    tempLabel.textAlignment = NSTextAlignmentLeft;
//    
//    [imageView addSubview:tempLabel];
//    return imageView;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0 && indexPath.row == 0){
        NewDomeTableViewCell *cell = [[NewDomeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"newDomeCell"];
        [[cell leftButton] addTarget:(AppDelegate*)[[UIApplication sharedApplication] delegate]  action:@selector(newIcosahedron) forControlEvents:UIControlEventTouchUpInside];
        [[cell rightButton] addTarget:(AppDelegate*)[[UIApplication sharedApplication] delegate]  action:@selector(newOctahedron) forControlEvents:UIControlEventTouchUpInside];
//        [cell.leftButton setTitle:@"Icosahedron" forState:UIControlStateNormal];
//        [cell.rightButton setTitle:@"Octahedron" forState:UIControlStateNormal];
        return cell;
    }

    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell;// = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    
    cell.backgroundColor = [UIColor whiteColor];
//    cell.selectedBackgroundView = selectionView;

    if(indexPath.section == 0){
//        if(indexPath.row == 0)
//            [cell.textLabel setText:@"Icosahedron"];
//        else if(indexPath.row == 1)
//            [cell.textLabel setText:@"Octahedron"];
    }
    else if(indexPath.section == 1){
        if(indexPath.row == 0){
            [cell.textLabel setText:@"+  Save Current Dome"];
            [cell.textLabel setTextColor:[UIColor colorWithRed:0 green:0.48 blue:1 alpha:1]];
        }
        else{
            NSArray *savedDomes = [[NSUserDefaults standardUserDefaults] objectForKey:@"saved"];
            NSDictionary *dome = [savedDomes objectAtIndex:indexPath.row-1];
            NSString *title;
            NSString *solid = @"";
            if([[dome objectForKey:@"solid"] isEqualToNumber:@0])
                solid = @"Icosahedron";
            else if([[dome objectForKey:@"solid"] isEqualToNumber:@1])
                solid = @"Octahedron";

            if([[dome objectForKey:@"numerator"] isEqualToNumber:[dome objectForKey:@"denominator"]]){
                title = [NSString stringWithFormat:@"%@V %@",[dome objectForKey:@"frequency"], solid ];
            }
            else{
                title = [NSString stringWithFormat:@"%@V %@/%@ %@", [dome objectForKey:@"frequency"], [dome objectForKey:@"numerator"], [dome objectForKey:@"denominator"], solid];
            }
            [cell.textLabel setText:title];
        }
    }
    else if(indexPath.section == 2){
        if(indexPath.row == 0)
            [cell.textLabel setText:@"Preferences"];
//        if(indexPath.row == 1)
//            [cell.textLabel setText:@"About Domes"];
    }
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    ViewController *viewController = [[ViewController alloc] init];
    if(indexPath.section == 0){
        if(indexPath.row == 0)
            [(AppDelegate*)[[UIApplication sharedApplication] delegate] newIcosahedron];
        if(indexPath.row == 1)
            [(AppDelegate*)[[UIApplication sharedApplication] delegate] newOctahedron];
    }
    else if(indexPath.section == 1){
        if(indexPath.row == 0){
            [(AppDelegate*)[[UIApplication sharedApplication] delegate] storeCurrentDome];
        }
        else{
            NSArray *savedDomes = [[NSUserDefaults standardUserDefaults] objectForKey:@"saved"];
            NSDictionary *dome = [savedDomes objectAtIndex:indexPath.row-1];
            [(AppDelegate*)[[UIApplication sharedApplication] delegate] loadDome:dome];
            
            SWRevealViewController *revealController = [self revealViewController];
            [revealController setFrontViewPosition:FrontViewPositionLeft animated:YES];
            [(AppDelegate*)[[UIApplication sharedApplication] delegate] updateUserPreferencesAcrossApp];
        }
    }
    else if(indexPath.section == 2){
        if(indexPath.row == 0)
            [(AppDelegate*)[[UIApplication sharedApplication] delegate] openPreferences];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    if(indexPath.row == 0)
//        [viewController setSolidType:0];
//    if(indexPath.row == 1)
//        [viewController setSolidType:1];
    
    
//        NavigationController *navController = [[NavigationController alloc] initWithRootViewController:viewController];
//    UINavigationController *navController = [[UINavigationController alloc] initWithNavigationBarClass:[NavigationBar class] toolbarClass:nil];
//    [navController setViewControllers:@[viewController]];
    
//    RearTableViewController *rearViewController = [[RearTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    
//    SWRevealViewController *mainRevealController = [SWRevealViewController new];
//    [[SWRevealViewController alloc] initWithRearViewController:rearViewController frontViewController:navController];

//    [revealController setFrontViewController:[[UINavigationController alloc] initWithRootViewController:viewController]];
//    SWRevealViewController *revealController = self.revealViewController;
//
//    if(_lastSelection.row == indexPath.row && _lastSelection.section == indexPath.section){
//        [revealController setFrontViewPosition:FrontViewPositionLeft animated:YES];
//        return;
//    }
//    else{
//        [self loadTableSelection:indexPath];
//    }
}

-(void) loadTableSelection:(NSIndexPath*)indexPath{
    _lastSelection = indexPath;
    
//    SWRevealViewController *revealController = self.revealViewController;

//    UIViewController *front = nil;
//    if(indexPath.row == 2){
//        BlogTableViewController *blogVC = [[BlogTableViewController alloc] init];
//        front = blogVC;
//    }
//    if(front){
//        [revealController setFrontViewController:front animated:YES];
//        [revealController setFrontViewPosition:FrontViewPositionLeft animated:YES];
//    }
    
    if(indexPath.section == 0){
//        NSLog(@"now overwriting front view controller correctly");
//        [revealController setFrontViewController:feed animated:YES];
//        [revealController setFrontViewPosition:FrontViewPositionLeft animated:YES];
    }
    else if (indexPath.section == 1){
        if(indexPath.row == 0){
//            ProfileNavigationController *profileNavController = [[ProfileNavigationController alloc] init];
//            [revealController setFrontViewController:profileNavController animated:YES];
//            [revealController setFrontViewPosition:FrontViewPositionLeft animated:YES];
        }
        else if(indexPath.row == 1){
        }
        else if(indexPath.row == 2){
        }
    }
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
