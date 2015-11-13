//
//  AddMoreView.h
//  SPA
//
//  Created by Santanu Das Adhikary on 28/10/15.
//  Copyright (c) 2015 Santanu Das Adhikary. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddMoreView : UIView <UITextFieldDelegate>

@property (nonatomic,retain) IBOutlet UITextField *StartTimeTextField,*EndTimeTextField;
@property (nonatomic,retain) IBOutlet UIButton *DeleteButton;

- (id)initWithFrame:(CGRect)frame WithTag:(int)addMoreViewTag WithDeleteButtonTag:(int)DeleteButtonTag WithSelecter:(SEL)SelecterMethod;

@end
