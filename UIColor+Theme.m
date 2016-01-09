//
//  UIColor+Theme.m
//  CRList
//
//  Created by caine on 1/9/16.
//  Copyright © 2016 com.caine. All rights reserved.
//

#define CLThemeBluelight   0x54c7fc
#define CLThemeBluedeep    0x0076ff
#define CLThemeYellowlight 0xffcd00
#define CLThemeYellowdeep  0xff9600
#define CLThemeRedlight    0xff2851
#define CLThemeReddeep     0xff3824
#define CLThemeGreen       0x44db5e
#define CLThemeGray        0x8e8e93

#import "UIColor+Theme.h"

@implementation UIColor (Theme)

+ (UIColor *)colorWithIndex:(int)i{
    
    if( i < 0 || i > 7 ) return [UIColor colorWithHex:CLThemeBluelight alpha:1];
    
    int colors[] = {
        CLThemeBluelight,
        CLThemeBluedeep,
        CLThemeYellowlight,
        CLThemeYellowdeep,
        CLThemeRedlight,
        CLThemeReddeep,
        CLThemeGreen,
        CLThemeGray
    };
    
    return [self colorWithHex:colors[i] alpha:1];
}

+ (UIColor *)colorWithHex:(uint32_t)hex alpha:(CGFloat)alpha{
    
    CGFloat red   = (CGFloat) ((hex & 0xff0000) >> 16) / 255.0f;
    CGFloat green = (CGFloat) ((hex & 0x00ff00) >>  8) / 255.0f;
    CGFloat blue  = (CGFloat) ( hex & 0x0000ff)        / 255.0f;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

@end
