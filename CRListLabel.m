//
//  CRListLabel.m
//  CRList
//
//  Created by caine on 1/8/16.
//  Copyright © 2016 com.caine. All rights reserved.
//

#import "CRListLabel.h"

@interface CRListLabel()

@property( nonatomic, strong ) UIView *line;

@end

@implementation CRListLabel

- (instancetype)init{
    self = [super init];
    if( self ){
        self.line = [[UIView alloc] init];
        self.line.layer.cornerRadius = 1;
        self.numberOfLines = 1;
    }
    return self;
}

- (void)setTextColor:(UIColor *)textColor{
    [super setTextColor:textColor];
    
    self.line.backgroundColor = textColor;
}

- (void)setOverline:(BOOL)overline{
    if( _overline == overline ) return;
    _overline = overline;
    
    if( overline )
        [self letDelete:YES];
    else
        [self letRecove:YES];
}

- (void)setOverline:(BOOL)overline animation:(BOOL)animation{
    if( _overline == overline ) return;
    _overline = overline;
    
    if( overline )
        [self letDelete:animation];
    else
        [self letRecove:animation];
}

- (void)letDelete:(BOOL)animation{
    CGRect selfRect = self.bounds;
    CGFloat lineHeight = 2;
    
    self.line.backgroundColor = self.textColor;
    self.line.frame = CGRectMake(-8, (selfRect.size.height - lineHeight) / 2, 0, lineHeight);
    [self addSubview:self.line];
    
    if( animation )
        [UIView animateWithDuration:0.25f
                              delay:0.25f options:(7 << 16)
                         animations:^{
                             self.line.frame = CGRectMake(-8, (selfRect.size.height - lineHeight) / 2, selfRect.size.width + 16, lineHeight);
                         }completion:nil];
    else
        self.line.frame = CGRectMake(-8, (selfRect.size.height - lineHeight) / 2, selfRect.size.width + 16, lineHeight);
}

- (void)letRecove:(BOOL)animation{
    CGRect selfRect = self.bounds;
    CGFloat lineHeight = 2;
    
    if( animation )
        [UIView animateWithDuration:0.25
                              delay:0.25f options:(7 << 16)
                         animations:^{
                             self.line.frame = CGRectMake(-8, (selfRect.size.height - lineHeight) / 2, 0, lineHeight);
                         }completion:nil];
    else
        self.line.frame = CGRectMake(-8, (selfRect.size.height - lineHeight) / 2, 0, lineHeight);
}

- (void)layoutSubviews{
    if( self.overline ){
        CGFloat lineHeight = 2;
        self.line.frame = CGRectMake(-8, (self.frame.size.height - lineHeight) / 2, self.frame.size.width + 16, lineHeight);
    }
}

@end
