//
//  UserImageCell.m
//  SPA
//
//  Created by Santanu Das Adhikary on 06/11/15.
//  Copyright (c) 2015 Santanu Das Adhikary. All rights reserved.
//

#import "UserImageCell.h"

@implementation UserImageCell

- (void)awakeFromNib {
    _ProfileImage = (UIImageView *)[self viewWithTag:141];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
