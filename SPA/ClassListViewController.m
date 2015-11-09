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

typedef enum {
    TableViewListTypeNormal,
    TableViewListTypeSearch
} TableViewListType;

@interface ClassListViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (nonatomic,retain) UITableView *ClassListTableView;
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
        
        _TableViewData = [@[@"Mahendra Singh Dhoni Mahendra Singh Dhoni Mahendra Singh Dhoni Mahendra Singh Dhoni Mahendra Singh Dhoni Mahendra Singh Dhoni Mahendra Singh Dhoni Mahendra Singh Dhoni Mahendra Singh Dhoni Mahendra Singh Dhoni Mahendra Singh Dhoni Mahendra Singh Dhoni"] mutableCopy];
        
        [_ClassListTableView reloadData];
        [_ClassListTableView registerNib:[UINib nibWithNibName:@"ClassListTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ClassListTableViewCell"];
        
        _SearchTextField = (UITextField *)[self.view viewWithTag:444];
        [_SearchTextField setDelegate:self];
        
        _TableViewListingType = TableViewListTypeNormal;
        
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
                
                for (ClassDetails *Classdetails in dataModelObj.fetchAllClassList) {
                    
                    NSLog(@"Classdetails ===> %@",Classdetails.name);
                    
                    for (ClassSlots *Classslots in [dataModelObj fetchAllSlotList:[Classdetails.classId stringValue]]) {
                        
                        NSLog(@"Classslots ===> %@ ---%@ ---%@ ---%@",Classslots.start_time,Classslots.end_time,Classslots.classId,Classslots.dayId);
                        
                    }
                }
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
    return NO;
}

- (void)textFieldDidEndEditing:(UITextField *)textField;
{
    [_SearchTextField resignFirstResponder];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length > 0)
    {
        _TableViewListingType = TableViewListTypeSearch;
        [_TableViewFilterData removeAllObjects];
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF contains[c] %@",string];
        _TableViewFilterData = [NSMutableArray arrayWithArray: [_TableViewData filteredArrayUsingPredicate:predicate]];
    }
    else
    {
        _TableViewListingType = TableViewListTypeNormal;
    }
    [_ClassListTableView reloadData];
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

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *alphaIdentifire = @"ClassListTableViewCell";
    ClassListTableViewCell *cell = (ClassListTableViewCell*) [tableView dequeueReusableCellWithIdentifier:alphaIdentifire];
    if (cell == nil) {
        cell = (ClassListTableViewCell *)[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:alphaIdentifire];
    }
    [cell.CellClassName setText:(_TableViewListingType == TableViewListTypeNormal)?[_TableViewData objectAtIndex:indexPath.row]:[_TableViewFilterData objectAtIndex:indexPath.row]];
    [cell.CellClassName setFont:[UIFont fontWithName:Constant.FontRobotoMedium size:18]];
//    [cell.CellClassName setNumberOfLines:0];
//    [cell.CellClassName sizeToFit];
    
    
    [cell.CellClassLocation setText:@"Classroom Location"];
    [cell.CellClassTime setText:@"Mon, Wed, Fri 9:00-10:00 AM"];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[NSNotificationCenter defaultCenter] postNotificationName:ClassDetailsMenuNotification object:nil];
    [self.navigationController pushViewController:Constant.AgendaListDayViewController animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* text = nil;
    
    text = (_TableViewListingType == TableViewListTypeNormal)?[_TableViewData objectAtIndex:indexPath.row]:[_TableViewFilterData objectAtIndex:indexPath.row];
    
    NSAttributedString * attributedString = [[NSAttributedString alloc] initWithString:text attributes:@{ NSFontAttributeName: [UIFont systemFontOfSize:18]}];
    
    CGSize constraintSize = CGSizeMake(tableView.frame.size.width - 5, MAXFLOAT);
    
    CGRect rect = [attributedString boundingRectWithSize:constraintSize options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) context:nil];
    
    rect.size.height = rect.size.height + 23;
    
    //return (rect.size.height < 44 ? 44 : rect.size.height);
    return UITableViewAutomaticDimension;;
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
