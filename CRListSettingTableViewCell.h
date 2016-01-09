//
//  CRListSettingTableViewCell.h
//  CRList
//
//  Created by caine on 1/9/16.
//  Copyright © 2016 com.caine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoogleToggle.h"

static NSString *const CRListSettingTaViCeStyleColor = @"CR_LIST_TABLE_VIEW_CELL_STYLE_COLOR";
static NSString *const CRListSettingTaViCeStyleToggle = @"CR_LIST_TABKE_VIEW_CELL_STYLE_TOGGLE";

static NSString *const CRListSettingTaViCeCoStyleID = @"CR_LIST_TABLE_VIEW_CELL_COLOR_STYLE_ID";
static NSString *const CRListSettingTaViCeToStyleID = @"CR_LIST_TABLE_VIEW_CELL_TOGGLE_STYLE_ID";

@interface CRListSettingTableViewCell : UITableViewCell

@property( nonatomic, strong ) UILabel *setLabel;
@property( nonatomic, strong ) UILabel *dotLabel;
@property( nonatomic, strong ) GoogleToggle *toggle;

- (instancetype)initWithStyle:(NSString *)style;

@end
