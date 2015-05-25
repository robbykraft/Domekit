//
//  DiagramViewController.m
//  Domekit
//
//  Created by Robby on 5/10/15.
//  Copyright (c) 2015 Robby. All rights reserved.
//

#import "DiagramViewController.h"
#import "EquidistantAzimuthView.h"
#import "MaterialsListTableViewCell.h"
#import "AppDelegate.h"

#define NAVBAR_HEIGHT 88
#define EXT_NAVBAR_HEIGHT 57


@interface DiagramViewController () <UIActionSheetDelegate>
{
    int polaris, octantis;
    NSArray *colorTable;
    EquidistantAzimuthView *equidistantAzimuthView;
}

@end

@implementation DiagramViewController

-(void) setGeodesicModel:(GeodesicModel *)geodesicModel{
    _geodesicModel = geodesicModel;
    [equidistantAzimuthView setGeodesic:_geodesicModel];
}

-(void) setMaterials:(NSDictionary *)materials{
    _materials = materials;
    NSLog(@"MATERIALS INVOLVED:\n%@",materials);
    [self.tableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0)
        return [[_materials objectForKey:@"lines"] count];
    else if(section == 1)
        return [[_materials objectForKey:@"points"] count];
    return 0;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(section == 0)
        return @"Struts";
    else if(section == 1)
        return @"Joints";
    else
        return @"";
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MaterialsListTableViewCell *cell = [[MaterialsListTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"MaterialsCell"];
    if(indexPath.section == 0){
        NSArray *lines = [_materials objectForKey:@"lines"];
        if(indexPath.row < [lines count]){
            // format strut length
            float length = [[lines objectAtIndex:indexPath.row] floatValue] * _scale;
            
            [[cell textLabel] setText:[((AppDelegate*)[[UIApplication sharedApplication] delegate]) unitifyNumber:length]];
            
            UIView *colorBar = [[UIView alloc] initWithFrame:CGRectMake(10, 18, 64, 8)];
            if(indexPath.row < [colorTable count])
                [colorBar setBackgroundColor:[colorTable objectAtIndex:indexPath.row]];
            else
                [colorBar setBackgroundColor:[UIColor grayColor]];
            [cell addSubview:colorBar];
            
            NSArray *lineQuantities = [_materials objectForKey:@"lineQuantities"];
            if([lineQuantities count]){
                [[cell detailTextLabel] setText:[NSString stringWithFormat:@"× %@",[lineQuantities objectAtIndex:indexPath.row]]];
            }
        }
    }
    else{
        [cell.textLabel setText:@""];
        NSArray *points = [_materials objectForKey:@"points"];
        [cell.detailTextLabel setText:[NSString stringWithFormat:@"x %@",[points objectAtIndex:indexPath.row]]];
 
    }
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


//-(NSArray*) getLengthOrder
//{
//    NSMutableArray *lengthOrder = [[NSMutableArray alloc] initWithCapacity:_geodesicModel.lineClassLengths.count];
//    int i, j, index;
//    for(i = 0; i < _geodesicModel.lineClassLengths.count; i++) [lengthOrder addObject:[[NSNumber alloc] initWithInt:0]];
//    for(i = 0; i < _geodesicModel.lineClassLengths.count; i++){
//        index = 0;
//        for(j = 0; j < _geodesicModel.lineClassLengths.count; j++){
//            if(i!=j && [_geodesicModel.lineClassLengths[i] doubleValue] > [_geodesicModel.lineClassLengths[j] doubleValue]) index++;
//        }
//        lengthOrder[index] = [[NSNumber alloc] initWithInt:i];
//    }
//    return [[NSArray alloc] initWithArray:lengthOrder];
//}


- (void)viewDidLoad {
    [super viewDidLoad];
    colorTable = [[NSArray alloc] initWithObjects:[UIColor colorWithRed:0.8 green:0 blue:0 alpha:1.0],  //red
                  [UIColor colorWithRed:0 green:0 blue:1.0 alpha:1.0],  //blue
                  [UIColor colorWithRed:0 green:0.8 blue:0 alpha:1.0],  //green
                  [UIColor colorWithRed:0.53 green:0 blue:0.8 alpha:1.0],  //purple
                  [UIColor colorWithRed:1 green:0.66 blue:0 alpha:1.0],   //orange
                  [UIColor colorWithRed:0 green:0.575 blue:0.7 alpha:1.0], //teal
                  [UIColor colorWithRed:0.88 green:0.88 blue:0 alpha:1.0],  //gold
                  [UIColor colorWithRed:0.86 green:0 blue:0.73 alpha:1.0],  //pink
                  [UIColor colorWithRed:0.66 green:.88 blue:0 alpha:1.0],  // lime green
                  [UIColor colorWithRed:0.62 green:.42 blue:0.27 alpha:1.0],  // brown
                  [UIColor colorWithRed:0.6 green:0.725 blue:0.95 alpha:1.0],  // light blue
                  [UIColor colorWithRed:1 green:0.81 blue:0.51 alpha:1.0],  // salmon
                  [UIColor colorWithRed:.89 green:0.6 blue:0.97 alpha:1.0],  // light purple
                  [UIColor colorWithRed:.5 green:1 blue:1 alpha:1.0],  // cyan
                  [UIColor colorWithRed:.75 green:.75 blue:.15 alpha:1.0],  // dull yellow
                  [UIColor colorWithRed:0 green:.63 blue:.42 alpha:1.0],  // sea green
                  [UIColor colorWithRed:0.26 green:0.19 blue:0.73 alpha:1.0],  // purple-blue
                  [UIColor colorWithRed:0.2 green:0.47 blue:0.16 alpha:1.0],  // forest green
                  [UIColor colorWithRed:0.19 green:0.37 blue:0.52 alpha:1.0],  // gray blue
                  [UIColor colorWithRed:0.66 green:0.66 blue:0.66 alpha:1.0], nil];  //gray
    

    // Do any additional setup after loading the view.

    
//    CGSize windowSize = [[UIScreen mainScreen] bounds].size;
//    EquidistantAzimuthView *azimuthView = [[EquidistantAzimuthView alloc] initWithFrame:CGRectMake(0, (windowSize.height-windowSize.width)*.5, windowSize.width, windowSize.width)];
//    [self.view addSubview:azimuthView];
    CGSize size = [[UIScreen mainScreen] bounds].size;
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
#define ZOOM 4
    
    equidistantAzimuthView = [[EquidistantAzimuthView alloc] initWithFrame:CGRectMake(0, 0, size.width * ZOOM, (size.width + EXT_NAVBAR_HEIGHT) * ZOOM)];
    [equidistantAzimuthView setColorTable:colorTable];
    [equidistantAzimuthView setGeodesic:_geodesicModel];
    [equidistantAzimuthView setBackgroundColor:[UIColor whiteColor]];

    UIScrollView *diagramScrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.width + EXT_NAVBAR_HEIGHT)];
    [diagramScrollview setContentSize:CGSizeMake(size.width * ZOOM, (size.width + EXT_NAVBAR_HEIGHT) * ZOOM)];
//    [diagramScrollview setZoomScale:.5];
    [diagramScrollview setDelegate:self];
    [diagramScrollview setMaximumZoomScale:1.0];
    [diagramScrollview setMinimumZoomScale:.25];
    [diagramScrollview setZoomScale:0.25];
    [diagramScrollview addSubview:equidistantAzimuthView];
    [self.view addSubview:diagramScrollview];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, size.width + EXT_NAVBAR_HEIGHT, size.width, size.height - size.width - EXT_NAVBAR_HEIGHT - 44) style:UITableViewStylePlain];
//    [self setTableView:tableView];
    [self.view addSubview:self.tableView];
    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];
    
//    UIBarButtonItem *makeButton = [[UIBarButtonItem alloc] initWithTitle:@"Share" style:UIBarButtonItemStylePlain target:nil action:NULL];
//    self.navigationItem.rightBarButtonItem = makeButton;

//    UIBarButtonItem *shareButton = [[UIBarButtonItem alloc] initWithTitle:@"Share" style:UIBarButtonItemStylePlain target:self action:@selector(shareButtonPressed)];
//    self.navigationItem.rightBarButtonItem = shareButton;
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(backButtonPressed)];
    self.navigationItem.leftBarButtonItem = backButton;
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

-(UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return equidistantAzimuthView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) backButtonPressed{
//    [UIView beginAnimations:nil context:NULL];
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//    [UIView setAnimationDuration:0.55];
//    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.navigationController.view cache:NO];
//    [UIView commitAnimations];
//    [UIView beginAnimations:nil context:NULL];
//    [UIView setAnimationDelay:0.375];
//    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
//    [UIView commitAnimations];
}

//-(void) shareButtonPressed{
//    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Back" destructiveButtonTitle:nil otherButtonTitles:@"Save to Photos", @"Email PDF", nil];
//    [actionSheet showInView:self.view];
//}

-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
