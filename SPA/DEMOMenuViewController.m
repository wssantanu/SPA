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
#import "SPASignoutSource.h"

int CurrentSelectedCell = 0;
BOOL isFirstLoad = NO;

@interface DEMOMenuViewController()<UIAlertViewDelegate>
@property (nonatomic,retain) MBProgressHUD *ActivityIndicator;
@end

@implementation DEMOMenuViewController
{
    NSArray *titleTireOne,*titleTireTwo,*imageClassTireOne,*imageClassTireTwo;
    AppDelegate *MainDelegate;
    UserDetails *FeatchUserdetails;
    UIImageView *ProfileImageView;
    UILabel *NameLabel;
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
    [UIView transitionWithView:self.tableView duration:0.35f options:UIViewAnimationOptionTransitionCrossDissolve animations:^(void) {
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
    
    ProfileImageView = [[UIImageView alloc] initWithFrame:CGRectMake(6, 14, 70, 70)];
    [ProfileImageView setBackgroundColor:[UIColor clearColor]];
    [ProfileImageView setImage:[UIImage imageNamed:@"menu_profile"]];
    [ProfileImageView.layer setCornerRadius:35.0f];
    [ProfileImageView.layer setBorderWidth:3.0f];
    [ProfileImageView setClipsToBounds:YES];
    [ProfileImageView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    if (FeatchUserdetails.picture.length > 0) {
        [ProfileImageView sd_setImageWithURL:[NSURL URLWithString:FeatchUserdetails.picture] placeholderImage:[UIImage imageNamed:@"menu_profile_selected"]];
    } else {
        [ProfileImageView sd_setImageWithURL:[NSURL URLWithString:@"http://studentplanner.dev.webspiders.com/sites/all/themes/studentplanner/images/profile-img.jpg"] placeholderImage:[UIImage imageNamed:@"menu_profile_selected"]];
    }
    [bgview addSubview:ProfileImageView];
    
    NameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, tableView.frame.size.width, 30)];
    NameLabel.backgroundColor = [UIColor clearColor];
    NameLabel.textColor = [UIColor whiteColor];
    [NameLabel setNumberOfLines:0];
    
    [NameLabel setTextAlignment:NSTextAlignmentCenter];
    NameLabel.font = [UIFont fontWithName:@"Roboto-Bold" size:14];
    NameLabel.text = FeatchUserdetails.user_full_name;
    [bgview addSubview:NameLabel];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(RefreshProfileInfo:) name:@"profiledatachanged" object:nil];
    
    return bgview;
}

-(void)RefreshProfileInfo:(NSNotification*)Obj {
    
    NSArray *SplitedArray = [Obj.object componentsSeparatedByString:@"|**|"];
    [ProfileImageView setImage:[UIImage imageWithData:[SplitedArray objectAtIndex:0]]];
    
    [NameLabel setText:[SplitedArray objectAtIndex:1]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)sectionIndex
{
    return 120;
}

-(void)ShowAletviewWIthTitle:(NSString *)ParamTitle Tag:(int)ParamTag Message:(NSString *)ParamMessage CancelButtonTitle:(NSString *)ParamCancelButtonTitle OtherButtonTitle:(NSString *)ParamOtherButtonTitle
{
    UIAlertView *AlertView = [[UIAlertView alloc] initWithTitle:ParamTitle message:ParamMessage delegate:self cancelButtonTitle:ParamCancelButtonTitle otherButtonTitles:ParamOtherButtonTitle, nil];
    [AlertView setTag:ParamTag];
    [AlertView show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 8820) {
        
        if (buttonIndex == 1) {
            
            SPASignoutSourceCompletionBlock completionBlock = ^(NSDictionary* data, NSString* errorString) {
                [_ActivityIndicator hide:YES];
                if (errorString) {
                    if (errorString.length>0) {
                        [self ShowAletviewWIthTitle:@"Sorry" Tag:780 Message:[[errorString substringToIndex:[errorString length] - 2] substringFromIndex:2] CancelButtonTitle:@"Ok" OtherButtonTitle:nil];
                    }
                } else {
                    if ([[data objectForKey:@"error"] intValue] == 1) {
                        [self ShowAletviewWIthTitle:@"Sorry" Tag:781 Message:[data objectForKey:@"message"] CancelButtonTitle:@"Ok" OtherButtonTitle:nil];
                    } else {
                        [self ShowAletviewWIthTitle:@"Success" Tag:782 Message:[data objectForKey:@"message"] CancelButtonTitle:@"Ok" OtherButtonTitle:nil];
                    }
                }
            };
            
            SPASignoutSource * source = [SPASignoutSource SignoutSource];
            [source doSignout:[NSArray arrayWithObjects:[FeatchUserdetails uid], nil] completion:completionBlock];
    
            _ActivityIndicator = [MBProgressHUD showHUDAddedTo:MainDelegate.window animated:YES];
            _ActivityIndicator.mode = MBProgressHUDModeIndeterminate;
            [_ActivityIndicator setOpacity:1.0];
            [_ActivityIndicator show:NO];
            _ActivityIndicator.labelText = @"Loading";
        }
    } else {
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
                UIAlertView *AlertViw = [[UIAlertView alloc] initWithTitle:@"Caution" message:@"Are you sure to signout" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
                [AlertViw setTag:8820];
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
