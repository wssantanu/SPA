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

int CurrentSelectedCell = 0;

@implementation DEMOMenuViewController
{
    NSArray *titleTireOne,*titleTireTwo,*imageClassTireOne,*imageClassTireTwo;
   
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.opaque = NO;
    self.tableView.backgroundColor = [UIColor blackColor];
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.scrollEnabled = NO;
    
    _menutypeorderlabel = menutypeorderfirstlabel;
    
    titleTireOne = @[@"Classes",@"Schedule", @"Tasks", @"Profile", @"Sign Out"];
    titleTireTwo = @[@"Agenda", @"Tasks", @"Materials",@"Students",@"Alert\nStudents",@"Class Info",@"Main Menu"];
    imageClassTireOne= @[@"menu_class",@"menu_schedule",@"menu_tasks",@"menu_profile",@"menu_signout"];
    imageClassTireTwo= @[@"menu_schedule",@"menu_tasks",@"menu_materials",@"menu_students",@"menu_alert_students",@"menu_classinfo",@"menu_mainmenu"];
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
    UIView *bgview = [[UIView alloc] init];
    [bgview setBackgroundColor:[UIColor blackColor]];
    UIImageView *ProfileImageView = [[UIImageView alloc] initWithFrame:CGRectMake(6, 6.5, 70, 70)];
    [ProfileImageView setBackgroundColor:[UIColor clearColor]];
    [ProfileImageView setImage:[UIImage imageNamed:@"menu_profile"]];
    [bgview addSubview:ProfileImageView];
    return bgview;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)sectionIndex
{
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    [self.tableView reloadData];
    
    MenuCellTableViewCell *cell = (MenuCellTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    
    if (_menutypeorderlabel == menutypeorderfirstlabel) {
        
        if (indexPath.row == 0) {
            
            _menutypeorderlabel = menutypeordersecondlabel;
            
            [UIView transitionWithView:self.tableView duration:0.35f options:UIViewAnimationOptionTransitionCrossDissolve
                            animations:^(void) {
                                [self.tableView reloadData];
                            } completion:nil];
            
        } else {
            
            [cell.MenuImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",[(_menutypeorderlabel == menutypeorderfirstlabel)?imageClassTireOne:imageClassTireTwo objectAtIndex:indexPath.row]]]];
            [cell.MenuName setTextColor:[UIColor yellowColor]];
            
            DEMOHomeViewController *homeViewController = [[DEMOHomeViewController alloc] init];
            DEMONavigationController *navigationController = [[DEMONavigationController alloc] initWithRootViewController:homeViewController];
            self.frostedViewController.contentViewController = navigationController;
        }
    } else {
        
        if (indexPath.row == 6) {
            _menutypeorderlabel = menutypeorderfirstlabel;
            
            [UIView transitionWithView:self.tableView duration:0.35f options:UIViewAnimationOptionTransitionCrossDissolve
                            animations:^(void) {
                 [self.tableView reloadData];
             } completion:nil];
            
        } else {
            
            [cell.MenuImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",[(_menutypeorderlabel == menutypeorderfirstlabel)?imageClassTireOne:imageClassTireTwo objectAtIndex:indexPath.row]]]];
            [cell.MenuName setTextColor:[UIColor yellowColor]];
            
            DEMOSecondViewController *secondViewController = [[DEMOSecondViewController alloc] init];
            DEMONavigationController *navigationController = [[DEMONavigationController alloc] initWithRootViewController:secondViewController];
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
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

@end
