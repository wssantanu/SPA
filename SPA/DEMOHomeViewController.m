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

typedef enum {
    buttonrepostiontypenone,
    buttonrepostiontypeup,
    buttonrepostiontypedown
} buttonrepostiontype;

@interface DEMOHomeViewController ()<UIScrollViewDelegate>

@property (nonatomic,retain) UIScrollView *MainScrollView;
@property (assign) buttonrepostiontype Buttonrepostiontype;
@end

@implementation DEMOHomeViewController
{
    UIButton *SaveButton;
}

int addMoreViewTag = (int)AddmoreViewTag;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    _Buttonrepostiontype = buttonrepostiontypenone;
    
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
    
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ViewAddedWithResponce) name:AddViewNotification object:nil];
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ViewDeletedWithResponceWithObject:) name:DeleteViewNotification object:nil];
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(TextfiledStartEditingNotificationWithObject:) name:TextfiledStartEditingNotification object:nil];
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(TextfiledEndEditingNotificationWithObject:) name:TextfiledEndEditingNotification object:nil];
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

-(void)deletedata:(UIButton *)Selecter
{
    _Buttonrepostiontype = buttonrepostiontypeup;
    
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
    addMoreViewTag = addMoreViewTag +1;
}

-(void)ViewDeletedWithResponceWithObject:(NSNotification*)Obj
{
    UIButton *ObjectButton = (UIButton *)Obj.object;
    [self deletedata:ObjectButton];
    
}

-(void)TextfiledStartEditingNotificationWithObject:(NSNotification*)Obj
{
    AddMoreView *AddmoreView = (AddMoreView *)[_MainScrollView viewWithTag:[Obj.object intValue]];
    NSLog(@"AddmoreView.frame.origin.y === %f",AddmoreView.frame.origin.y);
    [UIView animateWithDuration:1.2 animations:^{_MainScrollView.contentOffset = CGPointMake(0, AddmoreView.frame.origin.y);}];
}

-(void)TextfiledEndEditingNotificationWithObject:(NSNotification*)Obj
{
    AddMoreView *AddmoreView = (AddMoreView *)[_MainScrollView viewWithTag:[Obj.object intValue]];
    NSLog(@"AddmoreView.frame.origin.y === %f",AddmoreView.frame.origin.y);
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
