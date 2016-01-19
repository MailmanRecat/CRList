//
//  CRListTextField.m
//  CRList
//
//  Created by caine on 1/9/16.
//  Copyright © 2016 com.caine. All rights reserved.
//

#import "CRListTextField.h"
#import "UIFont+MaterialDesignIcons.h"

@interface CRListTextField()

@property( nonatomic, strong ) UIVisualEffectView *visual;
@property( nonatomic, strong ) UILabel *icon;
@property( nonatomic, strong ) UILabel *title;
@property( nonatomic, strong ) CAShapeLayer *border;
@property( nonatomic, strong ) CAShapeLayer *border2;

@end

@implementation CRListTextField

- (instancetype)init{
    self = [super init];
    if( self ){
        [self initClass];
    }
    return self;
}

- (void)initClass{
    CGFloat STATUS_BAR_HEIGHT = [UIApplication sharedApplication].statusBarFrame.size.height;
    
    [self setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.2]];
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.heightAnchor constraintEqualToConstant:88 + STATUS_BAR_HEIGHT].active = YES;
    
    self.title = ({
        UILabel *t = [[UILabel alloc] init];
        t.userInteractionEnabled = NO;
        t.font = [UIFont systemFontOfSize:20 weight:UIFontWeightMedium];
        t.text = @"Add todo";
        t.textColor = [UIColor whiteColor];
        t.textAlignment = NSTextAlignmentCenter;
        [self addSubview:t];
        [t setTranslatesAutoresizingMaskIntoConstraints:NO];
        [t.topAnchor constraintEqualToAnchor:self.topAnchor constant:20].active = YES;
        [t.leftAnchor constraintEqualToAnchor:self.leftAnchor].active = YES;
        [t.rightAnchor constraintEqualToAnchor:self.rightAnchor].active = YES;
        [t.heightAnchor constraintEqualToConstant:44].active = YES;
        t;
    });
    
    self.textField = ({
        UITextField *tf = [[UITextField alloc] init];
        tf.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
        tf.leftViewMode = UITextFieldViewModeAlways;
        tf.keyboardAppearance = UIKeyboardAppearanceDark;
        tf.returnKeyType = UIReturnKeyDone;
        tf.enablesReturnKeyAutomatically = YES;
        tf.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 0)];
        tf.font = [UIFont systemFontOfSize:17 weight:UIFontWeightRegular];
        tf.textColor = [UIColor whiteColor];
        tf.tintColor = [UIColor whiteColor];
        tf.clearButtonMode = UITextFieldViewModeWhileEditing;
        tf.layer.cornerRadius = 3.0f;
        tf.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"do..."
                                                                   attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
        tf.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:tf];
        [tf.heightAnchor constraintEqualToConstant:30].active = YES;
        [tf.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:8].active = YES;
        [tf.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:-72].active = YES;
        [tf.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-7].active = YES;
        [tf addTarget:self action:@selector(textFieldOnEdit:) forControlEvents:UIControlEventAllEditingEvents];
        tf;
    });
    
    self.done = ({
        UIButton *d = [[UIButton alloc] init];
        d.translatesAutoresizingMaskIntoConstraints = NO;
        [d setTitle:@"Cancel" forState:UIControlStateNormal];
        [d setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [d setTitleColor:[UIColor colorWithWhite:1 alpha:0.4] forState:UIControlStateHighlighted];
        [self addSubview:d];
        [d.heightAnchor constraintEqualToConstant:44].active = YES;
        [d.rightAnchor constraintEqualToAnchor:self.rightAnchor].active = YES;
        [d.leftAnchor constraintEqualToAnchor:self.textField.rightAnchor].active = YES;
        [d.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
        d;
    });
}

- (void)textFieldOnEdit:(UITextField *)textField{
    if( [textField.text isEqualToString:@""] == NO ){
        [self.done setTitle:@"Done" forState:UIControlStateNormal];
    }else{
        [self.done setTitle:@"Cancel" forState:UIControlStateNormal];
    }
}

- (void)layoutSubviews{
//    self.border.frame = CGRectMake(0, 54, self.frame.size.width, 0.5);
//    self.border2.frame = CGRectMake(0, 103.5, self.frame.size.width, 0.5);
}

@end
