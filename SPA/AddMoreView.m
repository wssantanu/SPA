//
//  AddMoreView.m
//  SPA
//
//  Created by Santanu Das Adhikary on 28/10/15.
//  Copyright (c) 2015 Santanu Das Adhikary. All rights reserved.
//

#import "AddMoreView.h"

@implementation AddMoreView

- (id)initWithFrame:(CGRect)frame WithTag:(int)addMoreViewTag WithDeleteButtonTag:(int)DeleteButtonTag WithSelecter:(SEL)SelecterMethod {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self setTag:(int)addMoreViewTag];
        [self setBackgroundColor:[UIColor yellowColor]];
        
        UIButton *DeleteButton = [[UIButton alloc] initWithFrame:CGRectMake(self.layer.frame.size.width-40, 0, 40, 40)];
        [DeleteButton setBackgroundColor:[UIColor clearColor]];
        [DeleteButton setBackgroundImage:[UIImage imageNamed:@"cross_icon"] forState:UIControlStateNormal];
        [DeleteButton setBackgroundImage:[UIImage imageNamed:@"cross_icon"] forState:UIControlStateApplication];
        [DeleteButton setBackgroundImage:[UIImage imageNamed:@"cross_icon"] forState:UIControlStateHighlighted];
        [DeleteButton setBackgroundImage:[UIImage imageNamed:@"cross_icon"] forState:UIControlStateSelected];
        [DeleteButton setTag:(int)(addMoreViewTag+(int)DeleteButtonTag)];
        [DeleteButton addTarget:self action:SelecterMethod forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:DeleteButton];
        
        UILabel *TitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, self.layer.frame.size.width-45, 10)];
        [TitleLabel setBackgroundColor:[UIColor clearColor]];
        [TitleLabel setTextColor:[UIColor blackColor]];
        [TitleLabel setText:[NSString stringWithFormat:@"View content %d",addMoreViewTag]];
        [TitleLabel setTextAlignment:NSTextAlignmentLeft];
        [TitleLabel setFont:[UIFont fontWithName:@"Arial" size:11]];
        [self addSubview:TitleLabel];
        
        UITextField *TextFiledStartTime = [[UITextField alloc] initWithFrame:CGRectMake(5, 40, self.frame.size.width/2-10, 30)];
        [TextFiledStartTime setBackgroundColor:[UIColor orangeColor]];
        [TextFiledStartTime setTag:165];
        [TextFiledStartTime setDelegate:self];
        [self addSubview:TextFiledStartTime];
        
        UITextField *TextFiledEndTime = [[UITextField alloc] initWithFrame:CGRectMake(self.frame.size.width/2, 40, self.frame.size.width/2-10, 30)];
        [TextFiledEndTime setBackgroundColor:[UIColor orangeColor]];
        [TextFiledEndTime setTag:166];
        [TextFiledEndTime setDelegate:self];
        [self addSubview:TextFiledEndTime];
        
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:AddViewNotification object:nil];
    return self;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [[NSNotificationCenter defaultCenter] postNotificationName:TextfiledStartEditingNotification object:[NSString stringWithFormat:@"%ld",(long)self.tag]];
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [[NSNotificationCenter defaultCenter] postNotificationName:TextfiledEndEditingNotification object:[NSString stringWithFormat:@"%ld",(long)self.tag]];
    [textField resignFirstResponder];
    return NO;
}

-(void)deletedata:(UIButton *)Selecter
{
    [self removeFromSuperview];
    [[NSNotificationCenter defaultCenter] postNotificationName:DeleteViewNotification object:Selecter];
}

@end
