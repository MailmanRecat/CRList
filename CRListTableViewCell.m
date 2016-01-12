//
//  CRListTableViewCell.m
//  CRList
//
//  Created by caine on 1/8/16.
//  Copyright © 2016 com.caine. All rights reserved.
//

#import "CRListTableViewCell.h"
#import "UIFont+MaterialDesignIcons.h"
#import "CRLIAsset.h"

@interface CRListTableViewCell()

@property( nonatomic, strong ) UILabel *icon;

@end

@implementation CRListTableViewCell

- (instancetype)init{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CRListTableViewCellID];
    if( self ){
        [self initClass];
    }
    return self;
}

- (void)initClass{
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle  = UITableViewCellSelectionStyleDefault;
    
    self.icon = ({
        UILabel *i = [[UILabel alloc] init];
        i.textAlignment = NSTextAlignmentCenter;
        i.font = [UIFont MaterialDesignIconsWithSize:24];
        i.text = [UIFont mdiCheckboxBlankCircleOutline];
        [self.contentView addSubview:i];
        i;
    });
    
    self.listLabel = ({
        CRListLabel *l = [[CRListLabel alloc] init];
        l.numberOfLines = 1;
        l.font = [UIFont systemFontOfSize:21 weight:UIFontWeightLight];
        l.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:l];
        [l.topAnchor constraintEqualToAnchor:self.contentView.topAnchor].active = YES;
        [l.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor constant:64].active = YES;
        [l.heightAnchor constraintEqualToConstant:44].active = YES;
        [l.widthAnchor constraintGreaterThanOrEqualToConstant:0].active = YES;
        [l.widthAnchor constraintLessThanOrEqualToAnchor:self.contentView.widthAnchor constant:-88].active = YES;
        l;
    });
    
    self.selectedBackgroundView = ({
        UIVibrancyEffect *eff = [UIVibrancyEffect effectForBlurEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
        UIVisualEffectView *visual = [[UIVisualEffectView alloc] initWithEffect:eff];
        UIView *v = [[UIView alloc] init];
        v.backgroundColor = [UIColor whiteColor];
        v.translatesAutoresizingMaskIntoConstraints = NO;
        [visual.contentView addSubview:v];
        [v.topAnchor constraintEqualToAnchor:visual.contentView.topAnchor].active = YES;
        [v.leftAnchor constraintEqualToAnchor:visual.contentView.leftAnchor].active = YES;
        [v.rightAnchor constraintEqualToAnchor:visual.contentView.rightAnchor].active = YES;
        [v.bottomAnchor constraintEqualToAnchor:visual.contentView.bottomAnchor].active = YES;
        visual;
    });
    
    self.timeLabel = ({
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(64, 36, 256, 20)];
        timeLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightLight];
        timeLabel.textColor = [UIColor colorWithWhite:1 alpha:0.9];
        timeLabel;
    });
}

- (void)setThemeColor:(UIColor *)themeColor{
    _themeColor = themeColor;
    self.listLabel.textColor = self.icon.textColor = themeColor;
}

- (void)setTimeString:(NSString *)timeString{
    _timeString = timeString;
    
    if( [timeString isEqualToString:CRLIAssetCheckedTimeDefVal] == NO ){
        [self.contentView addSubview:self.timeLabel];
        [self.timeLabel setText:timeString];
        [self.icon setText:[UIFont mdiCheckboxMarkedCircle]];
    }else{
        [self.timeLabel removeFromSuperview];
        [self.timeLabel setText:nil];
        [self.icon setText:[UIFont mdiCheckboxBlankCircleOutline]];
    }
}

- (void)prepareForReuse{
    self.editing  = NO;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.icon.frame = CGRectMake(0, 0, 56, self.frame.size.height);
}

@end
