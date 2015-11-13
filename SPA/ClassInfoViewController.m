//
//  ClassInfoViewController.m
//  SPA
//
//  Created by Santanu Das Adhikary on 04/11/15.
//  Copyright (c) 2015 Santanu Das Adhikary. All rights reserved.
//

#import "ClassInfoViewController.h"
#import "Constant.h"
#import "ClassListTableViewCell.h"
#import "SPAClassListSource.h"
#import "DataModel.h"
#import "UserDetails.h"
#import "ClassDetails.h"
#import "ClassSlots.h"
#import "ClassDetailsTableViewCell.h"
#import "TeacherDetailsTableViewCell.h"
#import "ClassListTableViewCell.h"

@interface ClassInfoViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    DataModel *dataModelObj;
    NSString *ClassId;
}
@property (nonatomic,retain) UITableView *InformationTableView;
@property (nonatomic,retain) NSMutableArray *TableViewDataSource;
@end

@implementation ClassInfoViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        _InformationTableView = (UITableView *)[self.view viewWithTag:523];
        [_InformationTableView setDelegate:self];
        [_InformationTableView setDataSource:self];
        [_InformationTableView setBackgroundColor:[UIColor clearColor]];
        
        [_InformationTableView registerNib:[UINib nibWithNibName:@"ClassListTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ClassListTableViewCell"];
        [_InformationTableView registerNib:[UINib nibWithNibName:@"ClassListTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ClassListTableViewCell"];
        
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self.view setBackgroundColor:Constant.ColorSPAWhiteColor];
    [self CustomizeHeaderwithTitle:@"Algebra 2" WithFontName:Constant.FontRobotoBold WithFontSize:32];
    
    dataModelObj = [DataModel sharedEngine];
    ClassId = [[NSUserDefaults standardUserDefaults] objectForKey:KeychainSelectedClasskey];
    
    NSLog(@"class details ===> %@",[dataModelObj fetchedClassListWithClassId:ClassId]);
    NSLog(@"class time details ===> %@",[dataModelObj fetchAllSlotList:ClassId]);
}

#pragma mark - UITableView Configure

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50.0f;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *HeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width-10, 50.0f)];
    [HeaderView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:HeaderView];
    
    UILabel *TitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(18, 10, HeaderView.layer.frame.size.width, HeaderView.layer.frame.size.height-10)];
    [TitleLabel setBackgroundColor:[UIColor clearColor]];
    [TitleLabel setTextColor:Constant.ColorSPAGreyColor];
    [TitleLabel setText:(section ==0)?@"Class information":@"Teacher Contact"];
    [TitleLabel setTextAlignment:NSTextAlignmentLeft];
    [TitleLabel setFont:[UIFont fontWithName:Constant.FontRobotoMedium size:22.0f]];
    [HeaderView addSubview:TitleLabel];
    return HeaderView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return (section==0)?0.0f:50.0f;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *FooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width-10, 50.0f)];
    [FooterView setBackgroundColor:[UIColor clearColor]];
    
    UIButton *LeaveClassButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 10, [[UIScreen mainScreen] bounds].size.width/2, 40)];
    [LeaveClassButton setTitle:@"leave Class" forState:UIControlStateNormal];
    [LeaveClassButton setBackgroundColor:Constant.ColorSPAGreyColor];
    [LeaveClassButton.titleLabel setFont:[UIFont fontWithName:Constant.FontRobotoMedium size:22.0f]];
    [LeaveClassButton.titleLabel setTextColor:[UIColor whiteColor]];
    [LeaveClassButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [FooterView addSubview:LeaveClassButton];
    [LeaveClassButton setCenter:FooterView.center];
    return (section==0)?[UIView new]:FooterView;
}
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    id superCell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
//    TeacherDetailsTableViewCell *cell = (TeacherDetailsTableViewCell*)superCell;
//    ClassDetails *LocalObject = [[dataModelObj fetchedClassListWithClassId:ClassId] objectAtIndex:0];
//
//    return [cell configureCell:LocalObject];
//}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        
        static NSString *alphaIdentifire = @"ClassListTableViewCell";
        ClassListTableViewCell *cell = (ClassListTableViewCell*) [self.InformationTableView dequeueReusableCellWithIdentifier:alphaIdentifire forIndexPath:indexPath];
        [cell setBackgroundColor:[UIColor clearColor]];
        if (cell == nil) {
            cell = (ClassListTableViewCell *)[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:alphaIdentifire];
            
        }
        [self setUpCell:cell atIndexPath:indexPath];
        
        //        [cell configureCell:LocalObject];
        return cell;
        
    } else if (indexPath.section == 1) {
        
        static NSString *alphaIdentifire = @"ClassListTableViewCell";
        ClassListTableViewCell *cell = (ClassListTableViewCell*) [self.InformationTableView dequeueReusableCellWithIdentifier:alphaIdentifire forIndexPath:indexPath];
        [cell setBackgroundColor:[UIColor clearColor]];
        if (cell == nil) {
            cell = (ClassListTableViewCell *)[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:alphaIdentifire];
            
        }
        [self setUpCell:cell atIndexPath:indexPath];
        
        
        //        [cell configureCell:LocalObject];
        return cell;
    }
    return nil;
}
- (void)setUpCell:(ClassListTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0)
    {
        for (id AllLabel in [cell.contentView subviews]) {
            if ([AllLabel isKindOfClass:[UILabel class]]) {
                UILabel *AllLabelInView = (UILabel *)AllLabel;
                [AllLabelInView setTextColor:(AllLabel == cell.CellClassName)?Constant.ColorSPABlackColor:Constant.ColorSPAGreyColor];
                [AllLabelInView setFont:(AllLabel == cell.CellClassName)?[UIFont fontWithName:Constant.FontRobotoMedium size:16]:[UIFont fontWithName:Constant.FontRobotoRegular size:14]];
            }
        }
        
        [cell setBackgroundColor:[UIColor clearColor]];
        ClassDetails *LocalObject = [[dataModelObj fetchedClassListWithClassId:ClassId] objectAtIndex:0];
        //ClassSlots *LocalTimeSlot = [dataModelObj fetchAllSlotList:ClassId];
        
        NSMutableString *DayString = [@"" mutableCopy];
        NSString *Dayval;
        int latdayid = -1;
        
        for (ClassSlots *Classslots in [dataModelObj fetchAllSlotList:[LocalObject.classId stringValue]]) {
            
            switch ([Classslots.dayId intValue]) {
                case 0: Dayval = @"Sun"; break;
                case 1: Dayval = @"Mon"; break;
                case 2: Dayval = @"Tue"; break;
                case 3: Dayval = @"Wed"; break;
                case 4: Dayval = @"Thu"; break;
                case 5: Dayval = @"Fri"; break;
                case 6: Dayval = @"Sat"; break;
            }
            
            (latdayid != [Classslots.dayId intValue])?[DayString appendString:[NSString stringWithFormat:@"%@ %@ - %@, \n ",Dayval,Classslots.start_time,Classslots.end_time]]:[DayString appendString:[NSString stringWithFormat:@"%@ - %@, ",Classslots.start_time,Classslots.end_time]];
            
            latdayid = [Classslots.dayId intValue];
        }
        
        cell.CellClassName.text = [LocalObject.name capitalizedString];
        cell.TeacherName.text = [NSString stringWithFormat:@"Teacher Name: %@",LocalObject.teacherFullname];
        cell.CellClassTime.text = DayString;
        cell.CellClassLocation.text = [NSString stringWithFormat:@"Location: %@",LocalObject.field_location];
        cell.classSection.text = [NSString stringWithFormat:@"Semester: %@",LocalObject.field_semester];
    }
    
    else if (indexPath.section == 1) {
        
        for (id AllLabel in [cell.contentView subviews]) {
            if ([AllLabel isKindOfClass:[UILabel class]]) {
                UILabel *AllLabelInView = (UILabel *)AllLabel;
                [AllLabelInView setTextColor:(AllLabel == cell.TeacherName)?Constant.ColorSPABlackColor:Constant.ColorSPAGreyColor];
                [AllLabelInView setFont:(AllLabel == cell.TeacherName)?[UIFont fontWithName:Constant.FontRobotoMedium size:16]:[UIFont fontWithName:Constant.FontRobotoRegular size:14]];
            }
        }
        
        [cell setBackgroundColor:[UIColor clearColor]];
        ClassDetails *LocalObject = [[dataModelObj fetchedClassListWithClassId:ClassId] objectAtIndex:0];
        
        cell.TeacherName.text = [LocalObject.teacherFullname capitalizedString];
        cell.CellClassLocation.text = [NSString stringWithFormat:@"Office Hours: %@",LocalObject.teacherofficehours];
        cell.classSection.text = [NSString stringWithFormat:@"Office Location: %@",LocalObject.teacherofficeLocation];
        cell.CellClassTime.text = [NSString stringWithFormat:@"Phone: %@",LocalObject.techerphoneno];
        cell.CellClassName.text = [NSString stringWithFormat:@"Email: %@",LocalObject.teacheremail];
        
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static ClassListTableViewCell *cell = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        cell = (ClassListTableViewCell*) [self.InformationTableView dequeueReusableCellWithIdentifier:@"ClassListTableViewCell" ];
    });
    
    [self setUpCell:cell atIndexPath:indexPath];
    return [self calculateHeightForConfiguredSizingCell:cell];
}

- (CGFloat)calculateHeightForConfiguredSizingCell:(ClassListTableViewCell *)sizingCell {
    
    CGFloat height = sizingCell.frame.size.height;
    [sizingCell layoutIfNeeded];
    height = sizingCell.frame.size.height;
    CGSize size = [sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    //    if (size.height >= 250) {
    //        height = size.height;
    //    } else {
    //        height = size.height-30;
    //    }
    return size.height;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
