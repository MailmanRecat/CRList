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
    
//    if( i < 0 || i > 7 ) return [UIColor colorWithHex:CLThemeBluelight alpha:1];
//    int colors[] = {
//        CLThemeBluelight,
//        CLThemeBluedeep,
//        CLThemeYellowlight,
//        CLThemeYellowdeep,
//        CLThemeRedlight,
//        CLThemeReddeep,
//        CLThemeGreen,
//        CLThemeGray
//    };
    
    NSArray *colors = @[
//                        [UIColor colorWithRed:255 / 255.0 green:41  / 255.0 blue:104 / 255.0 alpha:1],
                        [self colorWithHex:CLThemeRedlight alpha:1],
//                        [UIColor colorWithRed:255 / 255.0 green:149 / 255.0 blue:0   / 255.0 alpha:1],
                        [self colorWithHex:CLThemeYellowdeep alpha:1],
//                        [UIColor colorWithRed:255 / 255.0 green:204 / 255.0 blue:1   / 255.0 alpha:1],
                        [self colorWithHex:CLThemeYellowlight alpha:1],
//                        [UIColor colorWithRed:99  / 255.0 green:218 / 255.0 blue:56  / 255.0 alpha:1],
                        [self colorWithHex:CLThemeGreen alpha:1],
//                        [UIColor colorWithRed:27  / 255.0 green:173 / 255.0 blue:248 / 255.0 alpha:1],
                        [self colorWithHex:CLThemeBluelight alpha:1],
                        [UIColor colorWithRed:204 / 255.0 green:115 / 255.0 blue:225 / 255.0 alpha:1],
                        [UIColor colorWithRed:161 / 255.0 green:131 / 255.0 blue:93  / 255.0 alpha:1]
                        ];
    
    if( i < 0 || i > 6 ) return colors.firstObject;
    
    return colors[i];
}

+ (UIColor *)colorWithHex:(uint32_t)hex alpha:(CGFloat)alpha{
    
    CGFloat red   = (CGFloat) ((hex & 0xff0000) >> 16) / 255.0f;
    CGFloat green = (CGFloat) ((hex & 0x00ff00) >>  8) / 255.0f;
    CGFloat blue  = (CGFloat) ( hex & 0x0000ff)        / 255.0f;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

@end
