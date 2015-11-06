//
//  UserDataCell.m
//  SPA
//
//  Created by Santanu Das Adhikary on 06/11/15.
//  Copyright (c) 2015 Santanu Das Adhikary. All rights reserved.
//

#import "UserDataCell.h"

@implementation UserDataCell

- (void)awakeFromNib {
    _CellLabel = (UILabel *)[self viewWithTag:142];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
