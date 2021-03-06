//
//  DEMOMenuViewController.h
//  REFrostedViewControllerExample
//
//  Created by Roman Efimov on 9/18/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REFrostedViewController.h"

typedef enum {
    menutypeorderfirstlabel,
    menutypeordersecondlabel
} menutypeorder;

@interface DEMOMenuViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>
@property (assign) menutypeorder menutypeorderlabel;
@end
