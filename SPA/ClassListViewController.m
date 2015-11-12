//
//  ClassListViewController.m
//  SPA
//
//  Created by Santanu Das Adhikary on 30/10/15.
//  Copyright (c) 2015 Santanu Das Adhikary. All rights reserved.
//

#import "ClassListViewController.h"
#import "Constant.h"
#import "ClassListTableViewCell.h"
#import "SPAClassListSource.h"
#import "DataModel.h"
#import "UserDetails.h"
#import "ClassDetails.h"
#import "ClassSlots.h"
#import "UIColor+fromHex.h"

typedef enum {
    TableViewListTypeNormal,
    TableViewListTypeSearch
} TableViewListType;

@interface ClassListViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (nonatomic,retain)IBOutlet UITableView *ClassListTableView;
@property (nonatomic,retain) NSMutableArray *TableViewData,*TableViewFilterData;
@property (nonatomic,retain) UITextField *SearchTextField;
@property (nonatomic,retain) MBProgressHUD *ActivityIndicator;
@property (assign) TableViewListType TableViewListingType;
@end

@implementation ClassListViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        _ClassListTableView = (UITableView *)[self.view viewWithTag:777];
        [_ClassListTableView setDelegate:self];
        [_ClassListTableView setDataSource:self];
        [_ClassListTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [_ClassListTableView setShowsHorizontalScrollIndicator:NO];
        [_ClassListTableView setShowsVerticalScrollIndicator:NO];
        
        [_ClassListTableView reloadData];
        [_ClassListTableView registerNib:[UINib nibWithNibName:@"ClassListTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ClassListTableViewCell"];
         _ClassListTableView.estimatedRowHeight = UITableViewAutomaticDimension;
        
        _SearchTextField = (UITextField *)[self.view viewWithTag:444];
        [_SearchTextField setDelegate:self];
        
        _TableViewListingType = TableViewListTypeNormal;
        
        _TableViewFilterData = [[NSMutableArray alloc] init];
        
        for (id AllLabel in [self.view subviews]) {
            if ([AllLabel isKindOfClass:[UILabel class]]) {
                UILabel *AllLabelInView = (UILabel *)AllLabel;
                [AllLabelInView setTextColor:Constant.ColorSPABlackColor];
                [AllLabelInView setFont:[UIFont fontWithName:Constant.FontRobotoMedium size:16]];
            }
        }
        
        for (id AllTextFiled in [self.view subviews]) {
            
            if ([AllTextFiled isKindOfClass:[UITextField class]]) {
                
                UITextField *AllTextFiledInView = (UITextField *)AllTextFiled;
                [AllTextFiledInView setDelegate:self];
                
                UIView *LefftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, AllTextFiledInView.frame.size.height)];
                [LefftView setBackgroundColor:[UIColor clearColor]];
                [AllTextFiledInView setLeftView:LefftView];
                [AllTextFiledInView setLeftViewMode:UITextFieldViewModeAlways];
                
                UIImageView *SearchImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
                [SearchImage setImage:[UIImage imageNamed:@"icon_search"]];
                [AllTextFiledInView setRightView:SearchImage];
                [AllTextFiledInView setRightViewMode:UITextFieldViewModeAlways];
                
                AllTextFiledInView.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"search by teacher, book, etc" attributes:@{
                                                             NSForegroundColorAttributeName: Constant.ColorSPAGreyColor,
                                                             NSFontAttributeName : [UIFont fontWithName:Constant.FontRobotoRegular size:14.0]
                                                             }
                 ];
            }
        }
        
        [self ProcessFetchClassList];
    }
    return self;
}

#pragma mark - Navigate to different Screen

-(void)ProcessFetchClassList {
        
        SPAClassListSourceCompletionBlock completionBlock = ^(NSDictionary* data, NSString* errorString) {
            
            [_ActivityIndicator hide:YES];
            if (errorString) {
                if (errorString.length>0) {
                    [super ShowAletviewWIthTitle:@"Sorry" Tag:780 Message:[[errorString substringToIndex:[errorString length] - 2] substringFromIndex:2] CancelButtonTitle:@"Ok" OtherButtonTitle:nil];
                }
            } else {
                
                DataModel *dataModelObj = [DataModel sharedEngine];
                _TableViewData = [[NSMutableArray alloc] init];
                
                for (ClassDetails *Classdetails in dataModelObj.fetchAllClassList) {
                    
                    NSMutableDictionary *TimeDetails = [[NSMutableDictionary alloc] init];
                    NSMutableString *DayString = [@"" mutableCopy];
                    NSString *Dayval;
                    int latdayid = -1;
                    
                    for (ClassSlots *Classslots in [dataModelObj fetchAllSlotList:[Classdetails.classId stringValue]]) {
                        
                        switch ([Classslots.dayId intValue]) {
                            case 0: Dayval = @"Sun"; break;
                            case 1: Dayval = @"Mon"; break;
                            case 2: Dayval = @"Tue"; break;
                            case 3: Dayval = @"Wed"; break;
                            case 4: Dayval = @"Thu"; break;
                            case 5: Dayval = @"Fri"; break;
                            case 6: Dayval = @"Sat"; break;
                        }
                        
                        (latdayid != [Classslots.dayId intValue])?[DayString appendString:[NSString stringWithFormat:@"%@ %@ - %@, \n",Dayval,Classslots.start_time,Classslots.end_time]]:[DayString appendString:[NSString stringWithFormat:@"%@ - %@, ",Classslots.start_time,Classslots.end_time]];
                        
                        latdayid = [Classslots.dayId intValue];
                    }
                    
                    [TimeDetails setObject:Classdetails forKey:@"Classdetails"];
                    [TimeDetails setObject:DayString forKey:@"Timedetails"];
                    [_TableViewData addObject:TimeDetails];
                }
                [_ClassListTableView reloadData];
            }
        };
    
        DataModel *dataModelObj = [DataModel sharedEngine];
        UserDetails * FeatchUserdetails = [dataModelObj fetchCurrentUser];
    
        SPAClassListSource * source = [SPAClassListSource SPAClassListSource];
        [source getClasslist:[[NSArray alloc] initWithObjects:[FeatchUserdetails uid], nil] completion:completionBlock];
        
        _ActivityIndicator = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        _ActivityIndicator.mode = MBProgressHUDModeIndeterminate;
        [_ActivityIndicator setOpacity:1.0];
        [_ActivityIndicator show:NO];
        _ActivityIndicator.labelText = @"Loading";
}

#pragma mark - UITextfield Delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    [_SearchTextField resignFirstResponder];
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == _SearchTextField) {
        [_SearchTextField resignFirstResponder];
        return NO;
    }
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField;
{
    [_SearchTextField resignFirstResponder];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([[textField.text stringByReplacingCharactersInRange:range withString:string] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length > 0)
    {
        _TableViewListingType = TableViewListTypeSearch;
        [_TableViewFilterData removeAllObjects];
        
        DataModel *dataModelObj = [DataModel sharedEngine];
        
        for (ClassDetails *Classdetails in dataModelObj.fetchAllClassList) {
            
            if([[Classdetails.name lowercaseString] rangeOfString:[[textField.text stringByReplacingCharactersInRange:range withString:string] lowercaseString]].location != NSNotFound){
                
                NSMutableDictionary *TimeDetails = [[NSMutableDictionary alloc] init];
                NSMutableString *DayString = [@"" mutableCopy];
                NSString *Dayval;
                int latdayid = -1;
                
                for (ClassSlots *Classslots in [dataModelObj fetchAllSlotList:[Classdetails.classId stringValue]]) {
                    
                    switch ([Classslots.dayId intValue]) {
                        case 0: Dayval = @"Sun"; break;
                        case 1: Dayval = @"Mon"; break;
                        case 2: Dayval = @"Tue"; break;
                        case 3: Dayval = @"Wed"; break;
                        case 4: Dayval = @"Thu"; break;
                        case 5: Dayval = @"Fri"; break;
                        case 6: Dayval = @"Sat"; break;
                    }
                    
                    (latdayid != [Classslots.dayId intValue])?[DayString appendString:[NSString stringWithFormat:@"%@ %@ - %@, \n",Dayval,Classslots.start_time,Classslots.end_time]]:[DayString appendString:[NSString stringWithFormat:@"%@ - %@, ",Classslots.start_time,Classslots.end_time]];
                    
                    latdayid = [Classslots.dayId intValue];
                }
                
                [TimeDetails setObject:Classdetails forKey:@"Classdetails"];
                [TimeDetails setObject:DayString forKey:@"Timedetails"];
                [_TableViewFilterData addObject:TimeDetails];
                
                NSLog(@"_TableViewFilterData ===> %@",_TableViewFilterData);
            }
        }
        [_ClassListTableView reloadData];
    }
    else
    {
        _TableViewListingType = TableViewListTypeNormal;
        [_ClassListTableView reloadData];
    }
    
    return YES;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self.view setBackgroundColor:Constant.ColorSPAWhiteColor];
    
    [self CustomizeHeaderwithTitle:@"my classes" WithFontName:Constant.FontRobotoBold WithFontSize:32];
}

-(void)CustomizeHeaderwithTitle:(NSString *)Title WithFontName:(NSString *)FontName WithFontSize:(float)Size
{
    UIView *HeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, HeaderHeight)];
    [HeaderView setBackgroundColor:Constant.ColorSPAYellowColor];
    HeaderView.layer.masksToBounds = NO;
    HeaderView.layer.shadowOffset = CGSizeMake(0, 1);
    HeaderView.layer.shadowRadius = 10;
    HeaderView.layer.shadowOpacity = 0.4;
    HeaderView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:HeaderView];
    
    UILabel *TitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(MenuWidth+10, 10, HeaderView.layer.frame.size.width-20, HeaderView.layer.frame.size.height-10)];
    [TitleLabel setBackgroundColor:[UIColor clearColor]];
    [TitleLabel setTextColor:Constant.ColorSPAWhiteColor];
    [TitleLabel setText:Title];
    [TitleLabel setTextAlignment:NSTextAlignmentLeft];
    [TitleLabel setFont:[UIFont fontWithName:FontName size:Size]];
    [HeaderView addSubview:TitleLabel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Tableview Data Details

- (void)setUpCell:(ClassListTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    ClassDetails *LocalObjectClassDetails = (_TableViewListingType == TableViewListTypeNormal)?[[_TableViewData objectAtIndex:indexPath.row] objectForKey:@"Classdetails"]:[[_TableViewFilterData objectAtIndex:indexPath.row] objectForKey:@"Classdetails"];
    LocalObjectTimeDetails = (_TableViewListingType == TableViewListTypeNormal)?[[_TableViewData objectAtIndex:indexPath.row] objectForKey:@"Timedetails"]:[[_TableViewFilterData objectAtIndex:indexPath.row] objectForKey:@"Timedetails"];
    
    cell.CellClassName.text = LocalObjectClassDetails.name;
    [cell.CellClassName setTextAlignment:NSTextAlignmentJustified];
    [cell.CellClassName setFont:[UIFont fontWithName:Constant.FontRobotoBold size:15]];
    
    cell.classSection.text = LocalObjectClassDetails.field_semester;
    [cell.classSection setTextAlignment:NSTextAlignmentJustified];
    [cell.classSection setFont:[UIFont fontWithName:Constant.FontRobotoRegular size:15]];
    
    cell.TeacherName.text = LocalObjectClassDetails.teacherFullname;
    [cell.TeacherName setTextAlignment:NSTextAlignmentJustified];
    [cell.TeacherName setFont:[UIFont fontWithName:Constant.FontRobotoRegular size:15]];
    
    cell.CellClassLocation.text = LocalObjectClassDetails.field_location;
    [cell.CellClassLocation setTextAlignment:NSTextAlignmentJustified];
    [cell.CellClassLocation setFont:[UIFont fontWithName:Constant.FontRobotoRegular size:15]];
    
    cell.CellClassTime.text = LocalObjectTimeDetails;
    [cell.CellClassTime setTextAlignment:NSTextAlignmentJustified];
    [cell.CellClassTime setFont:[UIFont fontWithName:Constant.FontRobotoRegular size:15]];
    
    UIColor *color1 = [UIColor colorwithHexString:LocalObjectClassDetails.field_color_code alpha:1];
    [cell.ClassColor setBackgroundColor:color1];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *alphaIdentifire = @"ClassListTableViewCell";
    ClassListTableViewCell *cell = (ClassListTableViewCell*) [self.ClassListTableView dequeueReusableCellWithIdentifier:alphaIdentifire forIndexPath:indexPath];
    [cell setBackgroundColor:[UIColor clearColor]];
    if (cell == nil) {
        cell = (ClassListTableViewCell *)[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:alphaIdentifire];
        
    }
    [self setUpCell:cell atIndexPath:indexPath];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[NSNotificationCenter defaultCenter] postNotificationName:ClassDetailsMenuNotification object:nil];
    
    ClassDetails *LocalObjectClassDetails = (_TableViewListingType == TableViewListTypeNormal)?[[_TableViewData objectAtIndex:indexPath.row] objectForKey:@"Classdetails"]:[[_TableViewFilterData objectAtIndex:indexPath.row] objectForKey:@"Classdetails"];
    
    [[NSUserDefaults standardUserDefaults] setObject:LocalObjectClassDetails.classId forKey:KeychainSelectedClasskey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self.navigationController pushViewController:Constant.ClassInfoViewController animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static ClassListTableViewCell *cell = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        cell = (ClassListTableViewCell*) [self.ClassListTableView dequeueReusableCellWithIdentifier:@"ClassListTableViewCell" ];
    });
    
    [self setUpCell:cell atIndexPath:indexPath];
    return [self calculateHeightForConfiguredSizingCell:cell];
}

- (CGFloat)calculateHeightForConfiguredSizingCell:(ClassListTableViewCell *)sizingCell {
    
    CGFloat height = sizingCell.frame.size.height;
    [sizingCell layoutIfNeeded];
    height = sizingCell.frame.size.height;
    CGSize size = [sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    if (size.height >= 250) {
        height = size.height;
    } else {
        height = size.height-30;
    }
    return height;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (_TableViewListingType == TableViewListTypeNormal)?[_TableViewData count]:[_TableViewFilterData count];
}

@end
