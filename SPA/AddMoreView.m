//
//  AddMoreView.m
//  SPA
//
//  Created by Santanu Das Adhikary on 28/10/15.
//  Copyright (c) 2015 Santanu Das Adhikary. All rights reserved.
//

#import "AddMoreView.h"
#import "Constant.h"

@implementation AddMoreView
{
    CGRect Framedata;
}

- (void) awakeFromNib
{
    [super awakeFromNib];
}

- (id)initWithFrame:(CGRect)frame WithTag:(int)addMoreViewTag WithDeleteButtonTag:(int)DeleteButtonTag WithSelecter:(SEL)SelecterMethod {
    
    self = [self initWithFrame:frame];
    
    if (self) {
        
//        self = [[[NSBundle mainBundle] loadNibNamed:[NSString stringWithFormat:@"%@", [self class]] owner:self options:nil] objectAtIndex:0];
//        [self setBackgroundColor:[UIColor yellowColor]];
//
        
        [self setTag:(int)addMoreViewTag];
        
        UIButton *DeleteButton = [[UIButton alloc] initWithFrame:CGRectMake(frame.size.width-40, 0, 40, 40)];
        [DeleteButton setBackgroundColor:[UIColor clearColor]];
        [DeleteButton setBackgroundImage:[UIImage imageNamed:@"cross_icon"] forState:UIControlStateNormal];
        [DeleteButton setBackgroundImage:[UIImage imageNamed:@"cross_icon"] forState:UIControlStateApplication];
        [DeleteButton setBackgroundImage:[UIImage imageNamed:@"cross_icon"] forState:UIControlStateHighlighted];
        [DeleteButton setBackgroundImage:[UIImage imageNamed:@"cross_icon"] forState:UIControlStateSelected];
        [DeleteButton setTag:(int)(addMoreViewTag+(int)DeleteButtonTag)];
        [DeleteButton addTarget:self action:SelecterMethod forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:DeleteButton];
        
//        UILabel *OneLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, frame.size.width, 20)];
//        [OneLabel setText:[NSString stringWithFormat:@"validation tag %d",addMoreViewTag]];
//        [self addSubview:OneLabel];
        
        UILabel *StartDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 15, frame.size.width/2-10, 20)];
        [StartDateLabel setText:@"Start Time"];
        [self addSubview:StartDateLabel];
        
        UILabel *EndDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width/2, 15, frame.size.width/2-10, 20)];
        [EndDateLabel setText:@"End Time"];
        [self addSubview:EndDateLabel];
        
        UITextField *TextFiledStartTime = [[UITextField alloc] initWithFrame:CGRectMake(5, 40, frame.size.width/2-10, 40)];
        [TextFiledStartTime setTag:165];
        [TextFiledStartTime setPlaceholder:@"Start Time"];
        [TextFiledStartTime setText:@"00:00 AM"];
        [TextFiledStartTime setDelegate:self];
        [self addSubview:TextFiledStartTime];
        
        UITextField *TextFiledEndTime = [[UITextField alloc] initWithFrame:CGRectMake(frame.size.width/2, 40, frame.size.width/2-10, 40)];
        [TextFiledEndTime setTag:166];
        [TextFiledEndTime setText:@"00:00 AM"];
        [TextFiledEndTime setPlaceholder:@"End Time"];
        [TextFiledEndTime setDelegate:self];
        [self addSubview:TextFiledEndTime];
        
        for (id AllLabel in [self subviews]) {
            if ([AllLabel isKindOfClass:[UILabel class]]) {
                UILabel *AllLabelInView = (UILabel *)AllLabel;
                [AllLabelInView setTextColor:Constant.ColorSPAGreyColor];
                [AllLabelInView setFont:[UIFont fontWithName:Constant.FontRobotoMedium size:16]];
            }
        }
        
        for (id AllTextFiled in [self subviews]) {
            if ([AllTextFiled isKindOfClass:[UITextField class]]) {
                UITextField *AllTextFiledInView = (UITextField *)AllTextFiled;
                [AllTextFiledInView setDelegate:self];
                [AllTextFiledInView setBorderStyle:UITextBorderStyleLine];
                
                UIView *LefftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, AllTextFiledInView.frame.size.height)];
                [LefftView setBackgroundColor:[UIColor clearColor]];
                [AllTextFiledInView setLeftView:LefftView];
                [AllTextFiledInView setLeftViewMode:UITextFieldViewModeAlways];
                
                UIView *RightView = [[UIView alloc] initWithFrame:CGRectMake(AllTextFiledInView.frame.size.width-AllTextFiledInView.frame.size.height, 0, AllTextFiledInView.frame.size.height, AllTextFiledInView.frame.size.height)];
                [RightView setBackgroundColor:[UIColor clearColor]];
                [AllTextFiledInView setRightView:RightView];
                [AllTextFiledInView setRightViewMode:UITextFieldViewModeAlways];
                
                UIImageView *calender1 =[[UIImageView alloc] initWithFrame:CGRectMake(0,0,25,25)];
                [calender1 setCenter:CGPointMake(AllTextFiledInView.frame.size.height/2, AllTextFiledInView.frame.size.height/2)];
                calender1.image=[UIImage imageNamed:@"Clock_image"];
                [RightView addSubview:calender1];
            }
        }
        
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:AddViewNotification object:nil];
    return self;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [[NSNotificationCenter defaultCenter] postNotificationName:TextfiledStartEditingNotification object:[NSString stringWithFormat:@"%ld||%ld",(long)self.tag,(long)textField.tag]];
    return NO;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [[NSNotificationCenter defaultCenter] postNotificationName:TextfiledEndEditingNotification object:[NSString stringWithFormat:@"%ld||%ld",(long)self.tag,(long)textField.tag]];
    [textField resignFirstResponder];
    return NO;
}

-(void)deletedata:(UIButton *)Selecter
{
    [self removeFromSuperview];
    [[NSNotificationCenter defaultCenter] postNotificationName:DeleteViewNotification object:Selecter];
}

@end
