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
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [self.heightAnchor constraintEqualToConstant:104].active = YES;
    
    self.visual = ({
        UIVibrancyEffect *eff = [UIVibrancyEffect effectForBlurEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
        UIVisualEffectView *vis = [[UIVisualEffectView alloc] initWithEffect:eff];
        vis.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:vis];
        [vis.topAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
        [vis.leftAnchor constraintEqualToAnchor:self.leftAnchor].active = YES;
        [vis.rightAnchor constraintEqualToAnchor:self.rightAnchor].active = YES;
        [vis.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
        vis;
    });
    
    self.icon = ({
        UILabel *i = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 56, 54)];
        i.userInteractionEnabled = NO;
        i.textAlignment = NSTextAlignmentCenter;
        i.font = [UIFont MaterialDesignIconsWithSize:24];
        i.text = [UIFont mdiPencil];
        [self.visual.contentView addSubview:i];
        i;
    });
    
    self.title = ({
        UILabel *t = [[UILabel alloc] initWithFrame:CGRectMake(56, 0, 280, 54)];
        t.userInteractionEnabled = NO;
        t.font = [UIFont systemFontOfSize:24 weight:UIFontWeightMedium];
        t.text = @"Add undo";
        [self.visual.contentView addSubview:t];
        t;
    });
    
    self.border = ({
        CAShapeLayer *b = [CAShapeLayer layer];
        b.backgroundColor = [UIColor whiteColor].CGColor;
        [self.visual.contentView.layer addSublayer:b];
        b;
    });
    
    self.border2 = ({
        CAShapeLayer *b = [CAShapeLayer layer];
        b.backgroundColor = [UIColor whiteColor].CGColor;
        [self.visual.contentView.layer addSublayer:b];
        b;
    });
    
    self.textField = ({
        UITextField *tf = [[UITextField alloc] init];
        tf.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
        tf.leftViewMode = UITextFieldViewModeAlways;
        tf.keyboardAppearance = UIKeyboardAppearanceDark;
        tf.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 0)];
        tf.textColor = [UIColor whiteColor];
        tf.tintColor = [UIColor whiteColor];
        tf.clearButtonMode = UITextFieldViewModeWhileEditing;
        tf.layer.cornerRadius = 4.0f;
        tf.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"do..." attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
        tf.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:tf];
        [tf.heightAnchor constraintEqualToConstant:32].active = YES;
        [tf.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:8].active = YES;
        [tf.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:-72].active = YES;
        [tf.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-9].active = YES;
        [tf addTarget:self action:@selector(textFieldOnEdit:) forControlEvents:UIControlEventAllEditingEvents];
        tf;
    });
    
    self.done = ({
        UIButton *d = [[UIButton alloc] init];
        d.translatesAutoresizingMaskIntoConstraints = NO;
        [d setTitle:@"Cancel" forState:UIControlStateNormal];
        [self.visual.contentView addSubview:d];
        [d.heightAnchor constraintEqualToConstant:32].active = YES;
        [d.rightAnchor constraintEqualToAnchor:self.visual.rightAnchor].active = YES;
        [d.leftAnchor constraintEqualToAnchor:self.textField.rightAnchor].active = YES;
        [d.bottomAnchor constraintEqualToAnchor:self.visual.bottomAnchor constant:-9].active = YES;
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
    self.border.frame = CGRectMake(0, 54, self.frame.size.width, 0.5);
    self.border2.frame = CGRectMake(0, 103.5, self.frame.size.width, 0.5);
}

@end
