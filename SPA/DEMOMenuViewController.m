//
//  DEMOMenuViewController.m
//  REFrostedViewControllerExample
//
//  Created by Roman Efimov on 9/18/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "DEMOMenuViewController.h"
#import "DEMOHomeViewController.h"
#import "DEMOSecondViewController.h"
#import "DEMONavigationController.h"
#import "UIViewController+REFrostedViewController.h"
#import "MenuCellTableViewCell.h"
#import "Constant.h"
#import "AppDelegate.h"
#import "DataModel.h"
#import "UserDetails.h"
#import <SDWebImage/UIImageView+WebCache.h>

int CurrentSelectedCell = 0;
BOOL isFirstLoad = NO;

@interface DEMOMenuViewController()<UIAlertViewDelegate>

@end

@implementation DEMOMenuViewController
{
    NSArray *titleTireOne,*titleTireTwo,*imageClassTireOne,*imageClassTireTwo;
    AppDelegate *MainDelegate;
    UserDetails *FeatchUserdetails;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.opaque = NO;
    self.tableView.backgroundColor = [UIColor blackColor];
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.scrollEnabled = YES;
    
    
    isFirstLoad = YES;
    _menutypeorderlabel = menutypeorderfirstlabel;
    MainDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    titleTireOne = @[@"Classes",@"Schedule", @"Tasks", @"Profile", @"Sign Out"];
    titleTireTwo = @[@"Agenda", @"Tasks", @"Materials",@"Students",@"Alert Students",@"Class Info",@"Main Menu"];
    imageClassTireOne= @[@"menu_class",@"menu_schedule",@"menu_tasks",@"menu_profile",@"menu_signout"];
    imageClassTireTwo= @[@"menu_schedule",@"menu_tasks",@"menu_materials",@"menu_students",@"menu_alert_students",@"menu_classinfo",@"menu_mainmenu"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveMenuChangesNotification) name:ClassDetailsMenuNotification object:nil];
}

-(void)receiveMenuChangesNotification
{
    isFirstLoad = YES;
    _menutypeorderlabel = menutypeordersecondlabel;
    [UIView transitionWithView:self.tableView duration:0.35f options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^(void) {
                        [self.tableView reloadData];
                    } completion:nil];
}

#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor blackColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont fontWithName:@"Roboto-Bold" size:22];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    DataModel *dataModelObj = [DataModel sharedEngine];
    
    FeatchUserdetails = [dataModelObj fetchCurrentUser];
    
    UIView *bgview = [[UIView alloc] init];
    [bgview setBackgroundColor:[UIColor blackColor]];
    UIImageView *ProfileImageView = [[UIImageView alloc] initWithFrame:CGRectMake(6, 14, 70, 70)];
    [ProfileImageView setBackgroundColor:[UIColor clearColor]];
    [ProfileImageView setImage:[UIImage imageNamed:@"menu_profile"]];
    if (FeatchUserdetails.picture.length > 0) {
        [ProfileImageView sd_setImageWithURL:[NSURL URLWithString:FeatchUserdetails.picture] placeholderImage:[UIImage imageNamed:@"menu_profile_selected"]];
    } else {
        [ProfileImageView sd_setImageWithURL:[NSURL URLWithString:@"http://studentplanner.dev.webspiders.com/sites/all/themes/studentplanner/images/profile-img.jpg"] placeholderImage:[UIImage imageNamed:@"menu_profile_selected"]];
    }
    [bgview addSubview:ProfileImageView];
    
    UILabel *NameLabel = [[UILabel alloc] initWithFrame:CGRectMake(-5, 70, tableView.frame.size.width, 30)];
    NameLabel.backgroundColor = [UIColor clearColor];
    NameLabel.textColor = [UIColor whiteColor];
    [NameLabel setNumberOfLines:0];
    
    [NameLabel setTextAlignment:NSTextAlignmentCenter];
    NameLabel.font = [UIFont fontWithName:@"Roboto-Bold" size:14];
    NameLabel.text = FeatchUserdetails.user_full_name;
    [ProfileImageView addSubview:NameLabel];
    
    return bgview;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)sectionIndex
{
    return 120;
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [MainDelegate LogoutUser];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    isFirstLoad = NO;
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    [self.tableView reloadData];
    
    MenuCellTableViewCell *cell = (MenuCellTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    
    DEMONavigationController *navigationController;
    
    [cell.MenuImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",[(_menutypeorderlabel == menutypeorderfirstlabel)?imageClassTireOne:imageClassTireTwo objectAtIndex:indexPath.row]]]];
    [cell.MenuName setTextColor:Constant.ColorSPAYellowColor];
    
    if (_menutypeorderlabel == menutypeorderfirstlabel) {
        
        switch (indexPath.row) {
            case 0:
                navigationController = [[DEMONavigationController alloc] initWithRootViewController:Constant.ClassListViewController];
                break;
            case 1:
                navigationController = [[DEMONavigationController alloc] initWithRootViewController:Constant.ScheduleViewController];
                break;
            case 2:
                navigationController = [[DEMONavigationController alloc] initWithRootViewController:Constant.TaskListViewController];
                break;
            case 3:
                navigationController = [[DEMONavigationController alloc] initWithRootViewController:Constant.ShowProfileViewController];
                break;
            case 4:
            {
                UIAlertView *AlertViw = [[UIAlertView alloc] initWithTitle:@"Caution" message:@"Are you sere to signout" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
                [AlertViw show];
            }
                break;
            default:
                navigationController = [[DEMONavigationController alloc] initWithRootViewController:Constant.ClassListViewController];
                break;
        }
        if(indexPath.row!=4)
            self.frostedViewController.contentViewController = navigationController;
        
    } else {
        
        if (indexPath.row == 6) {
            
            _menutypeorderlabel = menutypeorderfirstlabel;
            
            [UIView transitionWithView:self.tableView duration:0.35f options:UIViewAnimationOptionTransitionCrossDissolve
                            animations:^(void) {
                 [self.tableView reloadData];
             } completion:nil];
            
        } else {
            
            switch (indexPath.row) {
                case 0:
                    navigationController = [[DEMONavigationController alloc] initWithRootViewController:Constant.AgendaListDayViewController];
                    break;
                case 1:
                    navigationController = [[DEMONavigationController alloc] initWithRootViewController:Constant.ClassTasksViewController];
                    break;
                case 2:
                    navigationController = [[DEMONavigationController alloc] initWithRootViewController:Constant.MaterialsListViewController];
                    break;
                case 3:
                    navigationController = [[DEMONavigationController alloc] initWithRootViewController:Constant.StudentsViewController];
                    break;
                case 4:
                    navigationController = [[DEMONavigationController alloc] initWithRootViewController:Constant.AlertStudentsViewController];
                    break;
                case 5:
                    navigationController = [[DEMONavigationController alloc] initWithRootViewController:Constant.ClassInfoViewController];
                    break;
            }
            
            if(indexPath.row!=6)
                self.frostedViewController.contentViewController = navigationController;
        }
    }
}

#pragma mark -
#pragma mark UITableView Datasource


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return (_menutypeorderlabel == menutypeorderfirstlabel)?[titleTireOne count]:[titleTireTwo count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"MenuCellTableViewCell";
    
    MenuCellTableViewCell *cell = (MenuCellTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MenuCellTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    [cell.MenuName setFont:[UIFont fontWithName:@"Roboto-Bold" size:14]];
    if (_menutypeorderlabel == menutypeorderfirstlabel) {
         [cell.MenuImageView setImage:[UIImage imageNamed:[imageClassTireOne objectAtIndex:indexPath.row]]];
        cell.MenuName.text = titleTireOne[indexPath.row];
    } else {
        [cell.MenuImageView setImage:[UIImage imageNamed:[imageClassTireTwo objectAtIndex:indexPath.row]]];
        cell.MenuName.text = titleTireTwo[indexPath.row];
    }
    
    if (isFirstLoad && indexPath.row == 0) {
        [cell.MenuImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",[(_menutypeorderlabel == menutypeorderfirstlabel)?imageClassTireOne:imageClassTireTwo objectAtIndex:indexPath.row]]]];
        [cell.MenuName setTextColor:Constant.ColorSPAYellowColor];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)viewWillDisappear:(BOOL)animated
{
    isFirstLoad = NO;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
