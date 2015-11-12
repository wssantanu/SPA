//
//  ClassListTableViewCell.h
//  SPA
//
//  Created by Santanu Das Adhikary on 03/11/15.
//  Copyright (c) 2015 Santanu Das Adhikary. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClassListTableViewCell : UITableViewCell
@property (nonatomic,retain) IBOutlet UILabel *CellClassName;
@property (nonatomic,retain) IBOutlet UILabel *CellClassLocation;
@property (nonatomic,retain) IBOutlet UILabel *CellClassTime;
@property (nonatomic,retain) IBOutlet UILabel *classSection;
@property (nonatomic,retain) IBOutlet UILabel *TeacherName;
@property (nonatomic,retain) IBOutlet UILabel *ClassColor;
@end
