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
    }
    return self;
}

- (void)setOverline:(BOOL)overline{
    if( _overline == overline ) return;
    _overline = overline;
    
    
    if( overline )
        [self letDelete];
    else
        [self letRecover];
}

- (void)letDelete{
    CGRect selfRect = self.bounds;
    CGFloat lineHeight = 2;
    
    self.line.backgroundColor = self.textColor;
    self.line.frame = CGRectMake(-8, (selfRect.size.height - lineHeight) / 2, 0, lineHeight);
    [self addSubview:self.line];
    
    [UIView animateWithDuration:0.25
                          delay:0.0f options:(7 << 16)
                     animations:^{
                         self.line.frame = CGRectMake(-8, (selfRect.size.height - lineHeight) / 2, selfRect.size.width + 16, lineHeight);
                     }completion:nil];
}

- (void)letRecover{
    CGRect selfRect = self.bounds;
    CGFloat lineHeight = 2;
    
    [UIView animateWithDuration:0.25
                          delay:0.0f options:(7 << 16)
                     animations:^{
                         self.line.frame = CGRectMake(-8, (selfRect.size.height - lineHeight) / 2, 0, lineHeight);
                     }completion:nil];
}

@end
