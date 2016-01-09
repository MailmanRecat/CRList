//
//  CRListTableViewCell.h
//  CRList
//
//  Created by caine on 1/8/16.
//  Copyright © 2016 com.caine. All rights reserved.
//

#define CRListTableViewCellID @"CR_LIST_TABLE_VIEW_CELL_ID"

#import <UIKit/UIKit.h>
#import "CRListLabel.h"

@interface CRListTableViewCell : UITableViewCell

@property( nonatomic, strong ) CRListLabel *listLabel;
@property( nonatomic, strong ) UILabel     *timeLabel;
@property( nonatomic, strong ) NSString    *timeString;
@property( nonatomic, strong ) UIColor     *themeColor;
@property( nonatomic, assign ) BOOL check;

@end
