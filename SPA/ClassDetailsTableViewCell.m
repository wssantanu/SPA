//
//  ClassDetailsTableViewCell.m
//  SPA
//
//  Created by Santanu Das Adhikary on 10/11/15.
//  Copyright (c) 2015 Santanu Das Adhikary. All rights reserved.
//

#import "ClassDetailsTableViewCell.h"
#import "Constant.h"
#define gap 4
#define totalItems 5;
#define margin 10;
#define fontsize 14;


@interface ClassDetailsTableViewCell()
@end

@implementation ClassDetailsTableViewCell

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(CGFloat)configureCell:(ClassDetails *)classDetails
{
    [self.ClassName setNumberOfLines:0];
    [self.ClassName sizeToFit];
    
    CGRect UserNameFrame = self.ClassName.frame;
    CGFloat namehg = [self getHeightForWidth:self.ClassName.frame.size.width andText:classDetails.teacherFullname andFont:[UIFont fontWithName:Constant.FontRobotoRegular size:14.0f]];
    UserNameFrame.size.height = namehg;
    UserNameFrame.origin.y = UserNameFrame.origin.y;
    [self.ClassName setFrame:UserNameFrame];
    
    
    CGRect OfficeHourFrame = self.ClassTeacherName.frame;
    CGFloat Hourhg = [self getHeightForWidth:(self.contentView.frame.size.width - 10) andText:classDetails.teacherofficehours andFont:[UIFont fontWithName:Constant.FontRobotoRegular size:14.0f]];
    OfficeHourFrame.size.height = Hourhg;
    OfficeHourFrame.origin.y = UserNameFrame.origin.y + UserNameFrame.size.height + gap;
    [self.ClassTeacherName setFrame:OfficeHourFrame];
    
    CGRect OfficeLocationFrame = self.ClassTime.frame;
    CGFloat Locationhg = [self getHeightForWidth:(self.contentView.frame.size.width - 10) andText:classDetails.teacherofficeLocation andFont:[UIFont fontWithName:Constant.FontRobotoRegular size:14.0f]];
    OfficeLocationFrame.size.height = Locationhg;
    OfficeLocationFrame.origin.y = OfficeHourFrame.origin.y + OfficeHourFrame.size.height + gap;
    [self.ClassTime setFrame:OfficeLocationFrame];
    
    CGRect PhoneFrame = self.ClassLocation.frame;
    CGFloat Phonehg = [self getHeightForWidth:(self.contentView.frame.size.width - 10) andText:classDetails.techerphoneno andFont:[UIFont fontWithName:Constant.FontRobotoRegular size:14.0f]];
    PhoneFrame.size.height = Phonehg;
    PhoneFrame.origin.y = OfficeLocationFrame.origin.y + OfficeLocationFrame.size.height + gap;
    [self.ClassLocation setFrame:PhoneFrame];
    
    CGRect EmailFrame = self.ClassSemister.frame;
    CGFloat Emailhg = [self getHeightForWidth:(self.contentView.frame.size.width - 10) andText:classDetails.teacheremail andFont:[UIFont fontWithName:Constant.FontRobotoRegular size:14.0f]];
    EmailFrame.size.height = Emailhg;
    EmailFrame.origin.y = PhoneFrame.origin.y + PhoneFrame.size.height + gap;
    [self.ClassSemister setFrame:EmailFrame];
    
    return self.ClassSemister.frame.origin.y+self.ClassSemister.frame.size.height+gap;
}

-(CGFloat)getDynamicHeightForWidth:(CGFloat)width andText:(NSString *)text andFont:(UIFont *)font{
    
    CGRect rect;
    CGFloat height=0.0;
    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
    {
        if(text.length>0)
        {
            NSAttributedString *attributedText =
            [[NSAttributedString alloc]
             initWithString:text
             attributes:@
             {
             NSFontAttributeName:font
             }];
            
            rect=[attributedText boundingRectWithSize:(CGSize){width, CGFLOAT_MAX}
                                              options:NSStringDrawingUsesLineFragmentOrigin context:nil];
            height=rect.size.height;
            
        }
    }
    else
    {
        CGSize constraintSize = CGSizeMake(width, MAXFLOAT);
        CGSize labelSize = [text sizeWithFont:font constrainedToSize:constraintSize lineBreakMode:NSLineBreakByWordWrapping];
        
        height=labelSize.height;
        
    }
    return height;
    
    
}

-(CGFloat) getHeightForWidth:(CGFloat)width andText:(NSString *)text andFont:(UIFont *)font
{
    CGRect rect;
    CGFloat height=0.0;
    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
    {
        if(text.length>0)
        {
            NSAttributedString *attributedText =
            [[NSAttributedString alloc]
             initWithString:text
             attributes:@
             {
             NSFontAttributeName:font
             }];
            
            rect=[attributedText boundingRectWithSize:(CGSize){width, CGFLOAT_MAX}
                                              options:NSStringDrawingUsesLineFragmentOrigin context:nil];
            height=rect.size.height;
            
        }
    }
    else
    {
        CGSize constraintSize = CGSizeMake(width, MAXFLOAT);
        CGSize labelSize = [text sizeWithFont:font constrainedToSize:constraintSize lineBreakMode:NSLineBreakByWordWrapping];
        
        height=labelSize.height;
        
    }
    return height;
}

-(CGFloat)textViewHeightForText: (NSString*)text andWidth: (CGFloat)width forFont:(UIFont *)font
{
    UITextView *calculationView = [[UITextView alloc] init];
    calculationView.font = font;
    [calculationView setText:text];
    CGSize size = [calculationView sizeThatFits:CGSizeMake(width, FLT_MAX)];
    return size.height;
}

@end
