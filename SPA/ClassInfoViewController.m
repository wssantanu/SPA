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
        
        [_InformationTableView registerNib:[UINib nibWithNibName:@"ClassDetailsTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ClassDetailsTableViewCell"];
        [_InformationTableView registerNib:[UINib nibWithNibName:@"TeacherDetailsTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"TeacherDetailsTableViewCell"];
        
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
    
    UILabel *TitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, HeaderView.layer.frame.size.width, HeaderView.layer.frame.size.height-10)];
    [TitleLabel setBackgroundColor:[UIColor clearColor]];
    [TitleLabel setTextColor:Constant.ColorSPABlackColor];
    [TitleLabel setText:(section ==0)?@"Class information":@"Teacher Contact"];
    [TitleLabel setTextAlignment:NSTextAlignmentLeft];
    [TitleLabel setFont:[UIFont fontWithName:Constant.FontRobotoMedium size:18.0f]];
    [HeaderView addSubview:TitleLabel];
    return HeaderView;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id superCell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    TeacherDetailsTableViewCell *cell = (TeacherDetailsTableViewCell*)superCell;
    ClassDetails *LocalObject = [[dataModelObj fetchedClassListWithClassId:ClassId] objectAtIndex:0];
    
    return [cell configureCell:LocalObject];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        
        static NSString *alphaIdentifire = @"ClassDetailsTableViewCell";
        ClassDetailsTableViewCell *cell = (ClassDetailsTableViewCell*) [tableView dequeueReusableCellWithIdentifier:alphaIdentifire];
        if (cell == nil) {
            cell = (ClassDetailsTableViewCell *)[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:alphaIdentifire];
        }
        
        for (id AllLabel in [cell.contentView subviews]) {
            if ([AllLabel isKindOfClass:[UILabel class]]) {
                UILabel *AllLabelInView = (UILabel *)AllLabel;
                [AllLabelInView setTextColor:(AllLabel == cell.ClassName)?Constant.ColorSPABlackColor:Constant.ColorSPAGreyColor];
                [AllLabelInView setFont:(AllLabel == cell.ClassName)?[UIFont fontWithName:Constant.FontRobotoMedium size:16]:[UIFont fontWithName:Constant.FontRobotoRegular size:14]];
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
        
        cell.ClassName.text = [LocalObject.name capitalizedString];
        cell.ClassTeacherName.text = [NSString stringWithFormat:@"Teacher Name: %@",LocalObject.teacherFullname];
        cell.ClassTime.text = DayString;
        cell.ClassLocation.text = [NSString stringWithFormat:@"Location: %@",LocalObject.field_location];
        cell.ClassSemister.text = [NSString stringWithFormat:@"Semester: %@",LocalObject.field_semester];
        
        [cell configureCell:LocalObject];
        return cell;
        
    } else if (indexPath.section == 1) {
        
        static NSString *alphaIdentifire = @"TeacherDetailsTableViewCell";
        TeacherDetailsTableViewCell *cell = (TeacherDetailsTableViewCell*) [tableView dequeueReusableCellWithIdentifier:alphaIdentifire];
        if (cell == nil) {
            cell = (TeacherDetailsTableViewCell *)[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:alphaIdentifire];
        }
        
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
        cell.TeacherOfficeHours.text = [NSString stringWithFormat:@"Office Hours: %@",LocalObject.teacherofficehours];
        cell.TeacherOfficeLocation.text = [NSString stringWithFormat:@"Office Location: %@",LocalObject.teacherofficeLocation];
        cell.TeacherPhone.text = [NSString stringWithFormat:@"Phone: %@",LocalObject.techerphoneno];
        cell.TeacherEmail.text = [NSString stringWithFormat:@"Email: %@",LocalObject.teacheremail];
        
        [cell configureCell:LocalObject];
        return cell;
    }
    return nil;
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
