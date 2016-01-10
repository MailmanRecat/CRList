//
//  CRListLabel.h
//  CRList
//
//  Created by caine on 1/8/16.
//  Copyright © 2016 com.caine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CRListLabel : UILabel

@property( nonatomic, assign ) BOOL overline;

- (void)setOverline:(BOOL)overline animation:(BOOL)animation;

@end
