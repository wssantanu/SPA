//
//  ShowProfileViewController.m
//  SPA
//
//  Created by Santanu Das Adhikary on 06/11/15.
//  Copyright (c) 2015 Santanu Das Adhikary. All rights reserved.
//

#import "ShowProfileViewController.h"
#import "DataModel.h"
#import "UserDetails.h"
#import "UserDataCell.h"
#import "UserImageCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

typedef enum {
    userTypeTeacher,
    userTypeStudent
} userType;

@interface ShowProfileViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    UserDetails *FeatchUserdetails;
}
@property (nonatomic, strong) NSMutableArray *dataSourceTeacherheader,*dataSourceStudentheader;
@property (nonatomic, strong) NSArray * dataSourceTeacher,*dataSourceStudent;
@property (nonatomic, strong) UITableView* ProfileTableView;
@property (assign) userType     LogedinUserType;
@end

@implementation ShowProfileViewController

#pragma mark -
#pragma mark Init Methods

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _ProfileTableView = (UITableView *)[self.view viewWithTag:777];
        [_ProfileTableView setDelegate:self];
        [_ProfileTableView setDataSource:self];
        [_ProfileTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [_ProfileTableView setBackgroundColor:[UIColor clearColor]];
        [_ProfileTableView setShowsHorizontalScrollIndicator:NO];
        [_ProfileTableView setShowsVerticalScrollIndicator:NO];
    }
    return self;
}

#pragma mark -
#pragma mark View Lifecycle

- (void)viewWillAppear:(BOOL)animated
{
    [self.view setBackgroundColor:Constant.ColorSPAWhiteColor];
    [self CustomizeHeaderwithTitle:@"My Profile" WithFontName:Constant.FontRobotoBold WithFontSize:32 WithButton:YES];
    
}
-(void)gotoEditProfile
{
    [self.navigationController pushViewController:Constant.EditProfileViewController animated:YES];
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    [_ProfileTableView registerNib:[UINib nibWithNibName:@"UserDataCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"InfoListTableViewCell"];
    [_ProfileTableView registerNib:[UINib nibWithNibName:@"UserImageCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ImageListTableViewCell"];
    
    _dataSourceTeacherheader = [[NSMutableArray alloc] initWithObjects:@"Name",@"Email",@"School",@"Office Location",@"Office Hours",@"Phone",@"Photo",@"Receive emails from Kendall Hunt?",@"Keep me logged in on this device", nil];
    
    _dataSourceStudentheader = [[NSMutableArray alloc] initWithObjects:@"Name",@"Email",@"Photo",@"Receive emails from Kendall Hunt?",@"Keep me logged in on this device", nil];
    
    DataModel *dataModelObj = [DataModel sharedEngine];
    
    FeatchUserdetails = [dataModelObj fetchCurrentUser];
    
    if ([FeatchUserdetails.roles isEqualToString:@"4"]) {
        _LogedinUserType = userTypeTeacher;
    } else if ([FeatchUserdetails.roles isEqualToString:@"5"]) {
        _LogedinUserType = userTypeStudent;
    }
    
    _dataSourceTeacher = [[NSArray alloc] initWithObjects:FeatchUserdetails.user_full_name,FeatchUserdetails.mail,FeatchUserdetails.user_school,FeatchUserdetails.user_office_location,FeatchUserdetails.user_office_hours,FeatchUserdetails.user_phone,FeatchUserdetails.picture,FeatchUserdetails.user_receive_emails,FeatchUserdetails.keep_logged_in, nil];
    
    _dataSourceStudent = [[NSArray alloc] initWithObjects:FeatchUserdetails.user_full_name,FeatchUserdetails.mail,FeatchUserdetails.picture,FeatchUserdetails.user_receive_emails,FeatchUserdetails.keep_logged_in, nil];
    
}

#pragma mark -
#pragma mark UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *HeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 22)];
    [HeaderView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:HeaderView];
    
    UILabel *TitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, HeaderView.layer.frame.size.width-20, HeaderView.layer.frame.size.height)];
    [TitleLabel setBackgroundColor:[UIColor clearColor]];
    [TitleLabel setTextColor:Constant.ColorSPABlackColor];
    [TitleLabel setText:(_LogedinUserType == userTypeTeacher)?[_dataSourceTeacherheader objectAtIndex:section]:[_dataSourceStudentheader objectAtIndex:section]];
    [TitleLabel setTextAlignment:NSTextAlignmentLeft];
    [TitleLabel setFont:[UIFont fontWithName:Constant.FontRobotoBold size:15]];
    [HeaderView addSubview:TitleLabel];
    
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(0.0f, 22.0f, HeaderView.frame.size.width, 1.0f);
    bottomBorder.backgroundColor = [UIColor colorWithWhite:0.8f alpha:1.0f].CGColor;
    [HeaderView.layer addSublayer:bottomBorder];
    
    return HeaderView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 23.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ([indexPath section] == ([tableView numberOfSections] - 3))?100.0f:50.0f;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return (_LogedinUserType == userTypeTeacher)?[_dataSourceTeacherheader count]:[_dataSourceStudentheader count];
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    static NSString *alphaIdentifire = @"InfoListTableViewCell";
//    UserDataCell *cell = (UserDataCell*) [tableView dequeueReusableCellWithIdentifier:alphaIdentifire];
//    if (cell == nil) {
//        cell = (UserDataCell *)[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:alphaIdentifire];
//    }
//    [cell.CellLabel setText:(_LogedinUserType == userTypeTeacher)?[_dataSourceTeacher objectAtIndex:indexPath.row]:[_dataSourceStudent objectAtIndex:indexPath.row]];
    
    NSInteger sectionsAmount = [tableView numberOfSections];
    
    static NSString *MyIdentifier = @"CellIdentifier";
    
    UITableViewCell *InfoListTableViewCell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (InfoListTableViewCell == nil) {
        InfoListTableViewCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
    }
    
    if ([indexPath section] == (sectionsAmount - 1) || [indexPath section] == (sectionsAmount - 2)) {
        InfoListTableViewCell.textLabel.text = (_LogedinUserType == userTypeTeacher)?([[_dataSourceTeacher objectAtIndex:indexPath.section] isEqualToString:@"1"]?@"Yes":@"No"):([[_dataSourceStudent objectAtIndex:indexPath.section] isEqualToString:@"1"]?@"Yes":@"No");
    } else {
        InfoListTableViewCell.textLabel.text = (_LogedinUserType == userTypeTeacher)?[_dataSourceTeacher objectAtIndex:indexPath.section]:[_dataSourceStudent objectAtIndex:indexPath.section];
    }
    if ([indexPath section] == (sectionsAmount - 3)) {
        
        NSString *FrofileImage = (_LogedinUserType == userTypeTeacher)?[_dataSourceTeacher objectAtIndex:indexPath.section]:[_dataSourceStudent objectAtIndex:indexPath.section];
        
        UIImageView *ProfileImage = [[UIImageView alloc] initWithFrame:CGRectMake(InfoListTableViewCell.frame.size.width-120, 10, 80, 80)];
        [ProfileImage setBackgroundColor:[UIColor clearColor]];
        [ProfileImage setImage:[UIImage imageNamed:@"menu_profile_selected"]];
        [ProfileImage.layer setCornerRadius:40.0f];
        [ProfileImage.layer setBorderWidth:3.0f];
        [ProfileImage setClipsToBounds:YES];
        [ProfileImage.layer setBorderColor:[UIColor lightGrayColor].CGColor];
        [InfoListTableViewCell addSubview:ProfileImage];
        
        if (FrofileImage.length > 0) {
            [ProfileImage sd_setImageWithURL:[NSURL URLWithString:@"http://studentplanner.dev.webspiders.com/sites/all/themes/studentplanner/images/profile-img.jpg"] placeholderImage:[UIImage imageNamed:@"menu_profile_selected"]];
        } else {
            [ProfileImage sd_setImageWithURL:[NSURL URLWithString:@"http://studentplanner.dev.webspiders.com/sites/all/themes/studentplanner/images/profile-img.jpg"] placeholderImage:[UIImage imageNamed:@"menu_profile_selected"]];
        }
    }
    
    [InfoListTableViewCell.textLabel setFont:[UIFont fontWithName:Constant.FontRobotoRegular size:15]];
    return InfoListTableViewCell;
}

#pragma mark -
#pragma mark MemoryWarning

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
