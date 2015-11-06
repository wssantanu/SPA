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

typedef enum {
    userTypeTeacher,
    userTypeStudent
} userType;

@interface ShowProfileViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    UserDetails *FeatchUserdetails;
}
@property (nonatomic, strong) NSMutableArray* dataSource,*dataSourceTeacherheader,*dataSourceStudentheader;
@property (nonatomic, strong) UIRefreshControl* refreshControl;
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
    [self CustomizeHeaderwithTitle:@"My Profile" WithFontName:Constant.FontRobotoBold WithFontSize:32];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [_ProfileTableView registerNib:[UINib nibWithNibName:@"UserDataCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ClassListTableViewCell"];
    [_ProfileTableView registerNib:[UINib nibWithNibName:@"UserImageCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ClassListTableViewCell"];
    
    _dataSourceTeacherheader = [[NSMutableArray alloc] initWithObjects:@"Name",@"Email",@"School",@"Office Location",@"Office Hours",@"Phone",@"Photo",@"Receive emails from Kendall Hunt?",@"Keep me logged in on this device", nil];
    
    _dataSourceStudentheader = [[NSMutableArray alloc] initWithObjects:@"Name",@"Email",@"Photo",@"Receive emails from Kendall Hunt?",@"Keep me logged in on this device", nil];
    
    DataModel *dataModelObj = [DataModel sharedEngine];
    
    FeatchUserdetails = [dataModelObj fetchCurrentUser];
    
    NSLog(@"FeatchUserdetails ==> %@",FeatchUserdetails.picture);
    
    if ([FeatchUserdetails.roles isEqualToString:@"4"]) {
        _LogedinUserType = userTypeTeacher;
    } else if ([FeatchUserdetails.roles isEqualToString:@"5"]) {
        _LogedinUserType = userTypeStudent;
    }
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return (_LogedinUserType == userTypeTeacher)?(FeatchUserdetails.picture == nil)?[_dataSourceTeacherheader count]-1:[_dataSourceTeacherheader count]:(FeatchUserdetails.picture == nil)?[_dataSourceStudentheader count]-1:[_dataSourceStudentheader count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    return cell;
}

#pragma mark -
#pragma mark MemoryWarning

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
