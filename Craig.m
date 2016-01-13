//
//  Craig.m
//  CRList
//
//  Created by caine on 1/12/16.
//  Copyright © 2016 com.caine. All rights reserved.
//

#import "Craig.h"

@implementation Craig

+ (NSString *)timeString{
    NSArray *m = @[
                   @"January", @"Febuary", @"March", @"April", @"May", @"June", @"July", @"August", @"September", @"October", @"November", @"December"
                   ];
    NSDateComponents *date = [TimeTalkerBird currentDate];
    
    NSString *(^fT)(NSUInteger) = ^(NSUInteger t){
        return t < 10 ? [NSString stringWithFormat:@"0%ld", t] : [NSString stringWithFormat:@"%ld", t];
    };
    
    return [NSString stringWithFormat:@"%@ %ld, %ld  %@:%@", [m objectAtIndex:date.month - 1], date.day, date.year, fT(date.hour), fT(date.minute)];
}

+ (UIVisualEffectView *)headerViewWithTitle:(NSString *)title{
    UIVibrancyEffect *eff = [UIVibrancyEffect effectForBlurEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
    UIVisualEffectView *content = [[UIVisualEffectView alloc] initWithEffect:eff];
    
    UILabel *label = ({
        UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, 256, 44)];
        l.text = title;
        l.font = [UIFont systemFontOfSize:21 weight:UIFontWeightLight];
        l;
    });
    
    UIView *b = [[UIView alloc] init];
    b.backgroundColor = [UIColor whiteColor];
    b.translatesAutoresizingMaskIntoConstraints = NO;
    [content.contentView addSubview:b];
    [b.leftAnchor constraintEqualToAnchor:content.contentView.leftAnchor].active = YES;
    [b.rightAnchor constraintEqualToAnchor:content.contentView.rightAnchor].active = YES;
    [b.bottomAnchor constraintEqualToAnchor:content.contentView.bottomAnchor].active = YES;
    [b.heightAnchor constraintEqualToConstant:0.5].active = YES;
    
    [content.contentView addSubview:label];
    return content;
}

@end
