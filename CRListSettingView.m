//
//  CRListSettingView.m
//  CRList
//
//  Created by caine on 1/9/16.
//  Copyright © 2016 com.caine. All rights reserved.
//

#import "CRListSettingView.h"
#import "CRListSettingTableViewCell.h"
#import "UIColor+Theme.h"

@interface CRListSettingView()<UITableViewDataSource, UITableViewDelegate>

@property( nonatomic, strong ) NSArray *names;

@end

@implementation CRListSettingView

- (instancetype)init{
    self = [super init];
    if( self ){
        [self initClass];
    }
    return self;
}

- (void)initClass{
    self.selectedIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    self.names = @[
                   @"Blue light",
                   @"Blue deep",
                   @"Yellow light",
                   @"Yellow deep",
                   @"Red light",
                   @"Red deep",
                   @"Green",
                   @"Gray"
                   ];
    
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator   = NO;
    self.backgroundColor = [UIColor clearColor];
    self.separatorEffect = [UIVibrancyEffect effectForBlurEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
    self.separatorInset  = UIEdgeInsetsMake(0, 52, 0, 0);
    self.delegate = self;
    self.dataSource = self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 7;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CRListSettingTableViewCell *c;
    
    c = [tableView dequeueReusableCellWithIdentifier:CRListSettingTaViCeCoStyleID];
    if( c == nil )
        c = [[CRListSettingTableViewCell alloc] initWithStyle:CRListSettingTaViCeStyleColor];
    
    if( indexPath.row == self.selectedIndexPath.row ){
        c.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        c.accessoryType = UITableViewCellAccessoryNone;
    }
    
    c.dotLabel.textColor = [UIColor colorWithIndex:(int)indexPath.row];
    c.setLabel.textColor = c.dotLabel.textColor;
    
    c.setLabel.text = self.names[indexPath.row];
    
    return c;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if( indexPath == self.selectedIndexPath ) return;
    
    UITableViewCell *c = [tableView cellForRowAtIndexPath:self.selectedIndexPath];
    c.accessoryType = UITableViewCellAccessoryNone;
    c = [tableView cellForRowAtIndexPath:indexPath];
    c.accessoryType = UITableViewCellAccessoryCheckmark;
    
    self.selectedIndexPath = indexPath;
}

- (void)willMoveToSuperview:(UIView *)newSuperview{
    if( self.selectedIndexPath.row != 0 ){
        UITableViewCell *c = [self cellForRowAtIndexPath:self.selectedIndexPath];
        c.accessoryType = UITableViewCellAccessoryNone;
        c = [self cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        c.accessoryType = UITableViewCellAccessoryCheckmark;
        self.selectedIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    }

}

- (void)didMoveToSuperview{
    [self scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
                atScrollPosition:UITableViewScrollPositionTop
                        animated:NO];

}

@end
