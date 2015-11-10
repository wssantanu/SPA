//
//  TeacherDetailsTableViewCell.h
//  SPA
//
//  Created by Santanu Das Adhikary on 10/11/15.
//  Copyright (c) 2015 Santanu Das Adhikary. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClassDetails.h"
@interface TeacherDetailsTableViewCell : UITableViewCell
@property (nonatomic,retain) IBOutlet UILabel *TeacherName,*TeacherOfficeHours,*TeacherOfficeLocation,*TeacherPhone,*TeacherEmail;

-(CGFloat)configureCell:(ClassDetails *)classDetails;
@end
