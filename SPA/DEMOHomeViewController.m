//
//  DEMOHomeViewController.m
//  REFrostedViewControllerExample
//
//  Created by Roman Efimov on 9/18/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "DEMOHomeViewController.h"
#import "DEMONavigationController.h"
#import "UINavigationBar+Customnavigation.h"
#import "AddMoreView.h"
#import <HMSegmentedControl/HMSegmentedControl.h>

typedef enum {
    buttonrepostiontypenone,
    buttonrepostiontypeup,
    buttonrepostiontypedown
} buttonrepostiontype;

typedef enum {
    weakdaytypesunday,
    weakdaytypemonday,
    weakdaytypetuesday,
    weakdaytypewednesday,
    weakdaytypethirsday,
    weakdaytypefriday,
    weakdaytypesaturday
} weakdaytype;

typedef enum {
    aditionTypenormal,
    aditionTypeSegment
} aditionType;

@interface DEMOHomeViewController ()<UIScrollViewDelegate>

@property (nonatomic,retain) UIScrollView *MainScrollView;
@property (nonatomic,retain) NSMutableArray *GlobalTagArray;
@property (assign) buttonrepostiontype Buttonrepostiontype;
@property (assign) weakdaytype Weakdaytype;
@property (assign) aditionType AditionType;
@end

@implementation DEMOHomeViewController
{
    UIButton *SaveButton;
}

int addMoreViewTag = (int)AddmoreViewTag;

float scrollViewBasicHeight = 0.0f;
float saveButtonYposition = 0.0f;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    _Buttonrepostiontype = buttonrepostiontypenone;
    _Weakdaytype = weakdaytypesunday;
    _AditionType = aditionTypenormal;
    
    _GlobalTagArray = [[NSMutableArray alloc] initWithObjects:[[NSMutableArray alloc] initWithObjects:@1557, nil],[[NSMutableArray alloc] initWithObjects:@1558, nil],[[NSMutableArray alloc] initWithObjects:@1559, nil],[[NSMutableArray alloc] initWithObjects:@1560, nil],[[NSMutableArray alloc] initWithObjects:@1561, nil],[[NSMutableArray alloc] initWithObjects:@1562, nil],[[NSMutableArray alloc] initWithObjects:@1563, nil], nil];
    
    [self CustomizeHeaderwithTitle:@"Header Data" WithFontName:@"Arial" WithFontSize:36 withButton:YES withSelecter:@selector(adddata) WithButtonBgImage:@"Header_PlusIcon_White"];

    _MainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(MenuWidth, HeaderHeight, [[UIScreen mainScreen] bounds].size.width-MenuWidth, [[UIScreen mainScreen] bounds].size.height-HeaderHeight)];
    [_MainScrollView setBackgroundColor:[UIColor redColor]];
    [_MainScrollView setDelegate:self];
    [_MainScrollView setContentSize:CGSizeMake(_MainScrollView.frame.size.width, _MainScrollView.frame.size.height)];
    [self.view addSubview:_MainScrollView];
    
    SaveButton = [[UIButton alloc] initWithFrame:CGRectMake(10, _MainScrollView.frame.size.height-50, _MainScrollView.frame.size.width-20, 40)];
    [SaveButton setBackgroundColor:[UIColor greenColor]];
    [SaveButton setTitle:@"Save" forState:UIControlStateNormal];
    [_MainScrollView addSubview:SaveButton];
    
    HMSegmentedControl *segmentedControl1 = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"Sun", @"Mon", @"Tues",@"Wed",@"Th",@"Fri",@"Sat"]];
    [segmentedControl1 setBackgroundColor:[UIColor blackColor]];
    segmentedControl1.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
    segmentedControl1.frame = CGRectMake(0, 0, _MainScrollView.frame.size.width, 40);
    segmentedControl1.segmentEdgeInset = UIEdgeInsetsMake(0, 10, 0, 10);
    segmentedControl1.selectionStyle = HMSegmentedControlSelectionStyleBox;
    segmentedControl1.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationNone;
    segmentedControl1.verticalDividerEnabled = YES;
    segmentedControl1.verticalDividerColor = [UIColor whiteColor];
    segmentedControl1.verticalDividerWidth = 1.0f;
    [segmentedControl1 setTitleFormatter:^NSAttributedString *(HMSegmentedControl *segmentedControl, NSString *title, NSUInteger index, BOOL selected) {
        NSAttributedString *attString = [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
        return attString;
    }];
    [segmentedControl1 addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    [_MainScrollView addSubview:segmentedControl1];
    [self segmentedControlChangedValue:segmentedControl1];
    
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ViewAddedWithResponce) name:AddViewNotification object:nil];
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ViewDeletedWithResponceWithObject:) name:DeleteViewNotification object:nil];
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(TextfiledStartEditingNotificationWithObject:) name:TextfiledStartEditingNotification object:nil];
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(TextfiledEndEditingNotificationWithObject:) name:TextfiledEndEditingNotification object:nil];
    
    scrollViewBasicHeight   = _MainScrollView.contentSize.height;
    saveButtonYposition     = SaveButton.frame.origin.y;
}

#pragma mark - Segment Control Delegate

- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl{

    switch (segmentedControl.selectedSegmentIndex)
    {
        case 0:
            _Weakdaytype = weakdaytypesunday;
            break;
        case 1:
            _Weakdaytype = weakdaytypemonday;
            break;
        case 2:
            _Weakdaytype = weakdaytypetuesday;
            break;
        case 3:
            _Weakdaytype = weakdaytypewednesday;
            break;
        case 4:
            _Weakdaytype = weakdaytypethirsday;
            break;
        case 5:
            _Weakdaytype = weakdaytypefriday;
            break;
        case 6:
            _Weakdaytype = weakdaytypesaturday;
            break;
    }
    
    for (id AllsubView in [_MainScrollView subviews])
    {
        if ([AllsubView isKindOfClass:[AddMoreView class]])
        {
            [AllsubView removeFromSuperview];
            [_MainScrollView setContentSize:CGSizeMake(_MainScrollView.frame.size.width,_MainScrollView.contentSize.height-AddmoreViewHeight)];
        }
    }
    
    SaveButton.frame     = CGRectMake(10, _MainScrollView.frame.size.height-50, _MainScrollView.frame.size.width-20, 40);
    
    //NSLog(@"[[_GlobalTagArray objectAtIndex:_Weakdaytype] count ===== %lu",(unsigned long)[[_GlobalTagArray objectAtIndex:_Weakdaytype] count]);
    
    if ([[_GlobalTagArray objectAtIndex:_Weakdaytype] count]>0)
    {
        for (int rr = 0 ; rr<[[_GlobalTagArray objectAtIndex:_Weakdaytype] count]; rr++)
        {
            [_MainScrollView setContentSize:CGSizeMake(_MainScrollView.frame.size.width,_MainScrollView.contentSize.height+AddmoreViewHeight)];
            
            NSMutableArray *DataObjectArray = [_GlobalTagArray objectAtIndex:_Weakdaytype];
            
            _AditionType = aditionTypeSegment;
            
            AddMoreView *moreView = [[AddMoreView alloc] initWithFrame:CGRectMake(0, _MainScrollView.contentSize.height-(AddmoreViewHeight+45), _MainScrollView.contentSize.width, AddmoreViewHeight-15) WithTag:[[DataObjectArray objectAtIndex:rr] intValue] WithDeleteButtonTag:(int)DeleteButtonAddTag WithSelecter:@selector(deletedata:)];
            [_MainScrollView addSubview:moreView];
            
            CGRect frame         = SaveButton.frame;
            frame.origin.y       = frame.origin.y+AddmoreViewHeight;
            SaveButton.frame     = frame;
        }
    }
}

- (void)uisegmentedControlChangedValue:(UISegmentedControl *)segmentedControl {
    NSLog(@"Selected index %ld", (long)segmentedControl.selectedSegmentIndex);
}

-(void)CustomizeHeaderwithTitle:(NSString *)Title WithFontName:(NSString *)FontName WithFontSize:(float)Size withButton:(BOOL)button withSelecter:(SEL)selecter WithButtonBgImage:(NSString *)WithButtonBgImage
{
    UIView *HeaderView = [[UIView alloc] initWithFrame:CGRectMake(MenuWidth, 0, [[UIScreen mainScreen] bounds].size.width-MenuWidth, HeaderHeight)];
    [HeaderView setBackgroundColor:UIColorFromRGB(0x52a63d)];
    HeaderView.layer.masksToBounds = NO;
    HeaderView.layer.shadowOffset = CGSizeMake(0, 1);
    HeaderView.layer.shadowRadius = 10;
    HeaderView.layer.shadowOpacity = 0.4;
    [self.view addSubview:HeaderView];
    
    UILabel *TitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, HeaderView.layer.frame.size.width-45, HeaderView.layer.frame.size.height-10)];
    [TitleLabel setBackgroundColor:[UIColor clearColor]];
    [TitleLabel setTextColor:[UIColor whiteColor]];
    [TitleLabel setText:Title];
    [TitleLabel setTextAlignment:NSTextAlignmentLeft];
    [TitleLabel setFont:[UIFont fontWithName:FontName size:Size]];
    [HeaderView addSubview:TitleLabel];
    
    if (button)
    {
        UIButton *HeaderButton = [[UIButton alloc] initWithFrame:CGRectMake(HeaderView.layer.frame.size.width-45, 24, 40, 40)];
        [HeaderButton setBackgroundColor:[UIColor clearColor]];
        [HeaderButton setBackgroundImage:[UIImage imageNamed:WithButtonBgImage] forState:UIControlStateNormal];
        [HeaderButton setBackgroundImage:[UIImage imageNamed:WithButtonBgImage] forState:UIControlStateApplication];
        [HeaderButton setBackgroundImage:[UIImage imageNamed:WithButtonBgImage] forState:UIControlStateHighlighted];
        [HeaderButton setBackgroundImage:[UIImage imageNamed:WithButtonBgImage] forState:UIControlStateSelected];
        [HeaderButton addTarget:self action:@selector(adddata) forControlEvents:UIControlEventTouchUpInside];
        [HeaderView addSubview:HeaderButton];
    }
}

-(void)deletedataWithTag:(int)TagVal
{
    _Buttonrepostiontype = buttonrepostiontypeup;
    
    //NSLog(@"ObjectArray after deletion %@",_GlobalTagArray);
    
    for (id AllsubView in [_MainScrollView subviews])
    {
        if ([AllsubView isKindOfClass:[AddMoreView class]])
        {
            AddMoreView *AddmoreView = (AddMoreView *)AllsubView;
            if ((int)AddmoreView.tag > TagVal)
            {
                CGRect frame        = AddmoreView.frame;
                frame.origin.y      = frame.origin.y-AddmoreViewHeight;
                AddmoreView.frame   = frame;
            }
        }
    }
    [self RepositioningScroollView];
}

-(void)deletedata:(UIButton *)Selecter
{
    _Buttonrepostiontype = buttonrepostiontypeup;
    
    NSMutableArray *ObjectArray = [_GlobalTagArray objectAtIndex:_Weakdaytype];
    [ObjectArray removeObject:[NSString stringWithFormat:@"%d",(int)Selecter.tag-(int)DeleteButtonAddTag]];
    
    //NSLog(@"ObjectArray after deletion %@",_GlobalTagArray);
    
    for (id AllsubView in [_MainScrollView subviews])
    {
        if ([AllsubView isKindOfClass:[AddMoreView class]])
        {
            AddMoreView *AddmoreView = (AddMoreView *)AllsubView;
            if ((int)AddmoreView.tag > (int)Selecter.tag-(int)DeleteButtonAddTag)
            {
                CGRect frame        = AddmoreView.frame;
                frame.origin.y      = frame.origin.y-AddmoreViewHeight;
                AddmoreView.frame   = frame;
            }
        }
    }
    [self RepositioningScroollView];
}

-(void)adddata
{
    _Buttonrepostiontype = buttonrepostiontypedown;
    [self RepositioningScroollView];
}

-(void)RepositioningScroollView
{
    [_MainScrollView setContentSize:CGSizeMake(_MainScrollView.frame.size.width, (_Buttonrepostiontype == buttonrepostiontypedown)?(_MainScrollView.contentSize.height+AddmoreViewHeight):(_MainScrollView.contentSize.height-AddmoreViewHeight))];
    
    if (_Buttonrepostiontype == buttonrepostiontypedown)
    {
        [_MainScrollView addSubview:[self AddMoreViewWithYpostion:_MainScrollView.contentSize.height-(AddmoreViewHeight+45)]];
    }
    
    CGRect frame         = SaveButton.frame;
    frame.origin.y       = (_Buttonrepostiontype == buttonrepostiontypedown)?frame.origin.y+AddmoreViewHeight:frame.origin.y-AddmoreViewHeight;
    SaveButton.frame     = frame;
    _Buttonrepostiontype = buttonrepostiontypenone;
    
}

-(UIView *)AddMoreViewWithYpostion:(float)Yposition
{
    AddMoreView *moreView = [[AddMoreView alloc] initWithFrame:CGRectMake(0, Yposition, _MainScrollView.contentSize.width, AddmoreViewHeight-15) WithTag:(int)addMoreViewTag WithDeleteButtonTag:(int)DeleteButtonAddTag WithSelecter:@selector(deletedata:)];
    return moreView;
}

-(void)ViewAddedWithResponce
{
    if (_AditionType == aditionTypenormal) {
        
        NSMutableArray *ObjectArray = [_GlobalTagArray objectAtIndex:_Weakdaytype];
        [ObjectArray addObject:[NSString stringWithFormat:@"%d",addMoreViewTag]];
        
       // NSLog(@"ObjectArray after addition %@",_GlobalTagArray);
        
        addMoreViewTag = addMoreViewTag +1;
    } else {
        _AditionType = aditionTypenormal;
    }
}

-(void)ViewDeletedWithResponceWithObject:(NSNotification*)Obj
{
    UIButton *ObjectButton = (UIButton *)Obj.object;
    [self deletedata:ObjectButton];
}

-(void)TextfiledStartEditingNotificationWithObject:(NSNotification*)Obj
{
    AddMoreView *AddmoreView = (AddMoreView *)[_MainScrollView viewWithTag:[Obj.object intValue]];
//    NSLog(@"AddmoreView.frame.origin.y === %f",AddmoreView.frame.origin.y);
    [UIView animateWithDuration:1.2 animations:^{_MainScrollView.contentOffset = CGPointMake(0, AddmoreView.frame.origin.y);}];
}

-(void)TextfiledEndEditingNotificationWithObject:(NSNotification*)Obj
{
    AddMoreView *AddmoreView = (AddMoreView *)[_MainScrollView viewWithTag:[Obj.object intValue]];
//    NSLog(@"AddmoreView.frame.origin.y === %f",AddmoreView.frame.origin.y);
    [UIView animateWithDuration:1.2 animations:^{_MainScrollView.contentOffset = CGPointMake(0, AddmoreView.frame.origin.y-500);}];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:AddViewNotification];
    [[NSNotificationCenter defaultCenter] removeObserver:DeleteViewNotification];
    [[NSNotificationCenter defaultCenter] removeObserver:TextfiledStartEditingNotification];
    [[NSNotificationCenter defaultCenter] removeObserver:TextfiledEndEditingNotification];
}

@end
