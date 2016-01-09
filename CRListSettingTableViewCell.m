//
//  CRListSettingTableViewCell.m
//  CRList
//
//  Created by caine on 1/9/16.
//  Copyright © 2016 com.caine. All rights reserved.
//

#import "CRListSettingTableViewCell.h"
#import "UIFont+MaterialDesignIcons.h"

@interface CRListSettingTableViewCell()

@end

@implementation CRListSettingTableViewCell

- (instancetype)initWithStyle:(NSString *)style{
    NSString *ID = style == CRListSettingTaViCeStyleColor ? CRListSettingTaViCeCoStyleID : CRListSettingTaViCeToStyleID;
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    if( self ){
        [self initClass:style];
    }
    return self;
}

- (void)initClass:(NSString *)style{
    
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.setLabel = ({
        UILabel *l = [[UILabel alloc] init];
        l.font = [UIFont systemFontOfSize:20 weight:UIFontWeightMedium];
        l.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:l];
        [l.topAnchor constraintEqualToAnchor:self.contentView.topAnchor].active = YES;
        [l.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor constant:52].active = YES;
        [l.rightAnchor constraintEqualToAnchor:self.contentView.rightAnchor constant:-72].active = YES;
        [l.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor].active = YES;
        l;
    });
    
    if( [style isEqualToString:CRListSettingTaViCeStyleColor] )
        [self initColorStyle];
    else if( [style isEqualToString:CRListSettingTaViCeStyleToggle] )
        [self initToggleStyle];
}

- (void)initColorStyle{
    self.dotLabel = ({
        UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
        l.textAlignment = NSTextAlignmentCenter;
        l.font = [UIFont MaterialDesignIconsWithSize:24];
        l.text = [UIFont mdiCheckboxBlankCircle];
        [self.contentView addSubview:l];
        l;
    });
}

- (void)initToggleStyle{
    self.toggle = ({
        GoogleToggle *tog = [[GoogleToggle alloc] init];
        [self.contentView addSubview:tog];
        [tog.rightAnchor constraintEqualToAnchor:self.contentView.rightAnchor constant:-8].active = YES;
        [tog.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor].active = YES;
        tog.tipTheme = [UIColor colorWithWhite:89 / 255.0 alpha:1];
        tog;
    });
}

@end
