//
//  ViewController.m
//  CRList
//
//  Created by caine on 1/8/16.
//  Copyright © 2016 com.caine. All rights reserved.
//

#define STATUS_BAR_HEIGHT [UIApplication sharedApplication].statusBarFrame.size.height

#import "ViewController.h"
#import "CRListTableViewCell.h"
#import "CRListTextField.h"
#import "CRListSettingView.h"
#import "UIColor+Theme.h"
#import "CRLIAsset.h"

@interface ViewController()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

@property( nonatomic, strong ) UITableView *bear;
@property( nonatomic, strong ) UIView *section1Header;
@property( nonatomic, strong ) UIView *section2Header;

@property( nonatomic, strong ) CRListTextField *tf;
@property( nonatomic, assign ) BOOL adjust;
@property( nonatomic, strong ) NSLayoutConstraint *tfLayoutGuide;

@property( nonatomic, strong ) CRListSettingView *sv;
@property( nonatomic, strong ) NSLayoutConstraint *svLayoutGuide;


@property( nonatomic, strong ) NSMutableArray *assets;
@property( nonatomic, strong ) NSMutableArray *undoAssets;
@property( nonatomic, strong ) NSMutableArray *checkedAssets;

@property( nonatomic, assign ) NSUInteger r1c;
@property( nonatomic, assign ) NSUInteger r2c;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    self.adjust = YES;
    
    NSArray *test = @[
                    [CRLIAsset assetFromDic:@{
                                              CRLIAssetTokenDicKey: CRLIAssetTokenDefVal,
                                              CRLIAssetItemDicKey: @"dasdbasdas",
                                              CRLIAssetAskBeforeCheckDicKey: CRLIAssetAskBeforeCheckDefVal,
                                              CRLIAssetShowBadgeNumberDicKey: CRLIAssetShowBadgeNumberDefVal,
                                              CRLIAssetCheckedTimeDicKey: CRLIAssetCheckedTimeDefVal,
                                              CRLIAssetAlertTimeDicKey: CRLIAssetAlertTimeDefVal,
                                              CRLIAssetColorDicKey: @"0"
                                              }],
                    [CRLIAsset assetFromDic:@{
                                              CRLIAssetTokenDicKey: CRLIAssetTokenDefVal,
                                              CRLIAssetItemDicKey: @"dasddasdasdsadsadsabasdas",
                                              CRLIAssetAskBeforeCheckDicKey: CRLIAssetAskBeforeCheckDefVal,
                                              CRLIAssetShowBadgeNumberDicKey: CRLIAssetShowBadgeNumberDefVal,
                                              CRLIAssetCheckedTimeDicKey: CRLIAssetCheckedTimeDefVal,
                                              CRLIAssetAlertTimeDicKey: CRLIAssetAlertTimeDefVal,
                                              CRLIAssetColorDicKey: @"1"
                                              }],
                    [CRLIAsset assetFromDic:@{
                                              CRLIAssetTokenDicKey: CRLIAssetTokenDefVal,
                                              CRLIAssetItemDicKey: @"dasdbadsasdas",
                                              CRLIAssetAskBeforeCheckDicKey: CRLIAssetAskBeforeCheckDefVal,
                                              CRLIAssetShowBadgeNumberDicKey: CRLIAssetShowBadgeNumberDefVal,
                                              CRLIAssetCheckedTimeDicKey: CRLIAssetCheckedTimeDefVal,
                                              CRLIAssetAlertTimeDicKey: CRLIAssetAlertTimeDefVal,
                                              CRLIAssetColorDicKey: @"2"
                                              }],
                    [CRLIAsset assetFromDic:@{
                                              CRLIAssetTokenDicKey: CRLIAssetTokenDefVal,
                                              CRLIAssetItemDicKey: @"dasas",
                                              CRLIAssetAskBeforeCheckDicKey: CRLIAssetAskBeforeCheckDefVal,
                                              CRLIAssetShowBadgeNumberDicKey: CRLIAssetShowBadgeNumberDefVal,
                                              CRLIAssetCheckedTimeDicKey: CRLIAssetCheckedTimeDefVal,
                                              CRLIAssetAlertTimeDicKey: CRLIAssetAlertTimeDefVal,
                                              CRLIAssetColorDicKey: @"3"
                                              }],
                    [CRLIAsset assetFromDic:@{
                                              CRLIAssetTokenDicKey: CRLIAssetTokenDefVal,
                                              CRLIAssetItemDicKey: @"d",
                                              CRLIAssetAskBeforeCheckDicKey: CRLIAssetAskBeforeCheckDefVal,
                                              CRLIAssetShowBadgeNumberDicKey: CRLIAssetShowBadgeNumberDefVal,
                                              CRLIAssetCheckedTimeDicKey: CRLIAssetCheckedTimeDefVal,
                                              CRLIAssetAlertTimeDicKey: CRLIAssetAlertTimeDefVal,
                                              CRLIAssetColorDicKey: @"4"
                                              }],
                    [CRLIAsset assetFromDic:@{
                                              CRLIAssetTokenDicKey: CRLIAssetTokenDefVal,
                                              CRLIAssetItemDicKey: @"dasdbadasdsadsasdas",
                                              CRLIAssetAskBeforeCheckDicKey: CRLIAssetAskBeforeCheckDefVal,
                                              CRLIAssetShowBadgeNumberDicKey: CRLIAssetShowBadgeNumberDefVal,
                                              CRLIAssetCheckedTimeDicKey: CRLIAssetCheckedTimeDefVal,
                                              CRLIAssetAlertTimeDicKey: CRLIAssetAlertTimeDefVal,
                                              CRLIAssetColorDicKey: @"6"
                                              }],
                    [CRLIAsset assetFromDic:@{
                                              CRLIAssetTokenDicKey: CRLIAssetTokenDefVal,
                                              CRLIAssetItemDicKey: @"dasddasbasdas",
                                              CRLIAssetAskBeforeCheckDicKey: CRLIAssetAskBeforeCheckDefVal,
                                              CRLIAssetShowBadgeNumberDicKey: CRLIAssetShowBadgeNumberDefVal,
                                              CRLIAssetCheckedTimeDicKey: CRLIAssetCheckedTimeDefVal,
                                              CRLIAssetAlertTimeDicKey: CRLIAssetAlertTimeDefVal,
                                              CRLIAssetColorDicKey: @"7"
                                              }],
                    [CRLIAsset assetFromDic:@{
                                              CRLIAssetTokenDicKey: CRLIAssetTokenDefVal,
                                              CRLIAssetItemDicKey: @"dasas",
                                              CRLIAssetAskBeforeCheckDicKey: CRLIAssetAskBeforeCheckDefVal,
                                              CRLIAssetShowBadgeNumberDicKey: CRLIAssetShowBadgeNumberDefVal,
                                              CRLIAssetCheckedTimeDicKey: CRLIAssetCheckedTimeDefVal,
                                              CRLIAssetAlertTimeDicKey: CRLIAssetAlertTimeDefVal,
                                              CRLIAssetColorDicKey: @"2"
                                              }],
                    [CRLIAsset assetFromDic:@{
                                              CRLIAssetTokenDicKey: CRLIAssetTokenDefVal,
                                              CRLIAssetItemDicKey: @"dasdbasddasdsadsaas",
                                              CRLIAssetAskBeforeCheckDicKey: CRLIAssetAskBeforeCheckDefVal,
                                              CRLIAssetShowBadgeNumberDicKey: CRLIAssetShowBadgeNumberDefVal,
                                              CRLIAssetCheckedTimeDicKey: CRLIAssetCheckedTimeDefVal,
                                              CRLIAssetAlertTimeDicKey: CRLIAssetAlertTimeDefVal,
                                              CRLIAssetColorDicKey: @"1"
                                              }],
                    ];
    
    self.assets = [[NSMutableArray alloc] initWithArray:test];
    
    [self updateData];
    
    [self letBear];
    [self letTextField];
    [self letObserver];
}

- (void)letObserver{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(DidKeyBoardChangeFrame:)
                                                 name:UIKeyboardDidChangeFrameNotification
                                               object:nil];
}

- (void)DidKeyBoardChangeFrame:(NSNotification *)keyboardInfo{
    NSDictionary *info = [keyboardInfo userInfo];
    CGFloat constant = self.view.frame.size.height - [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y;
    if( self.sv.superview == self.view ){
        self.sv.contentInset = UIEdgeInsetsMake(0, 0, constant + 8, 0);
    }
}

- (void)insertItem:(CRLIAsset *)asset{
    
}

- (void)updateItem:(CRLIAsset *)asset{
    
}

- (void)checkItem:(CRLIAsset *)asset{
    
}

- (void)recoverItem:(CRLIAsset *)asset{
    
}

- (void)updateData{
    if( self.undoAssets == nil )
        self.undoAssets = [[NSMutableArray alloc] init];
    
    if( self.checkedAssets == nil )
        self.checkedAssets = [[NSMutableArray alloc] init];
    
    self.r1c = self.r2c = 0;
    [self.assets enumerateObjectsUsingBlock:^(CRLIAsset *asset, NSUInteger index, BOOL *sS){
        if( [asset.checkedTime isEqualToString:CRLIAssetCheckedTimeDefVal] ){
            self.r1c++;
            [self.undoAssets addObject:asset];
        }else{
            self.r2c++;
            [self.checkedAssets addObject:asset];
        }
    }];
}

- (void)tfShouldEndTask{
    self.adjust = YES;
    if( [self.tf.done.titleLabel.text isEqualToString:@"Cancel"] )
        [self letCancel];
    else
        [self letItemAdd];
}

- (void)letItemAdd{
    
    CRLIAsset *asset = [CRLIAsset defaultAsset];
    asset.item  = self.tf.textField.text.length > 256 ? [self.tf.textField.text substringToIndex:256] : self.tf.textField.text;
    asset.color = [NSString stringWithFormat:@"%ld", self.sv.selectedIndexPath.row];
    
    NSLog(@"%@", asset);
    
    [self.undoAssets insertObject:asset atIndex:0];
    self.r1c++;
    
    [self.bear insertRowsAtIndexPaths:@[
                                        [NSIndexPath indexPathForRow:0 inSection:0]
                                        ]
                     withRowAnimation:UITableViewRowAnimationFade];
    
    [self letCancel];
}

- (void)letCancel{
    
    [self.tf.textField setText:@""];
    [self.tf.done setTitle:@"Cancel" forState:UIControlStateNormal];
    
    [self.bear setHidden:NO];
    [self.view endEditing:YES];
    [self.tfLayoutGuide setConstant:-( 104 + STATUS_BAR_HEIGHT )];
    [UIView animateWithDuration:0.25f
                          delay:0.0f options:(7 << 16)
                     animations:^{
                         [self.svLayoutGuide setConstant:self.view.frame.size.height];
                         [self.bear setAlpha:1];
                         [self.view layoutIfNeeded];
                     }completion:^(BOOL f){
                         [self.sv removeFromSuperview];
                     }];
}

- (void)letTextField{
    CRListTextField *tf = [[CRListTextField alloc] init];
    [self.view addSubview:tf];
    self.tfLayoutGuide = [tf.topAnchor constraintEqualToAnchor:self.view.topAnchor];
    self.tfLayoutGuide.constant = -104 - STATUS_BAR_HEIGHT;
    self.tfLayoutGuide.active = YES;
    [tf.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
    [tf.rightAnchor constraintEqualToAnchor:self.view.rightAnchor].active = YES;
    
    [tf.done addTarget:self action:@selector(tfShouldEndTask) forControlEvents:UIControlEventTouchUpInside];
    
    self.tf = tf;
}

- (void)letSetting{
    if( !self.sv ){
        self.sv = ({
            CRListSettingView *st = [[CRListSettingView alloc] init];
            st.translatesAutoresizingMaskIntoConstraints = NO;
            st;
        });
    }
    
    [self.view addSubview:self.sv];
    
    self.svLayoutGuide = [self.sv.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:self.view.frame.size.height];
    self.svLayoutGuide.active = YES;
    
    [self.sv.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
    [self.sv.rightAnchor constraintEqualToAnchor:self.view.rightAnchor].active = YES;
    [self.sv.heightAnchor constraintEqualToAnchor:self.view.heightAnchor constant:-(104 + STATUS_BAR_HEIGHT)].active = YES;
    [self.sv layoutIfNeeded];
    
    self.svLayoutGuide.constant = STATUS_BAR_HEIGHT + 104;
    
    [UIView animateWithDuration:0.25f
                          delay:0.0f options:(7 << 16)
                     animations:^{
                         [self.view layoutIfNeeded];
                     }completion:nil];
}

- (void)letBear{
    self.bear = ({
        UITableView *bear = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
        bear.translatesAutoresizingMaskIntoConstraints = NO;
        bear.showsHorizontalScrollIndicator = NO;
        bear.showsVerticalScrollIndicator = NO;
        bear.backgroundColor = [UIColor clearColor];
        bear.separatorStyle = UITableViewCellSeparatorStyleNone;
        bear.delegate = self;
        bear.dataSource = self;
        bear;
    });
    
    [self.view addSubview:self.bear];
    [self.bear.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:STATUS_BAR_HEIGHT].active = YES;
    [self.bear.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
    [self.bear.rightAnchor constraintEqualToAnchor:self.view.rightAnchor].active = YES;
    [self.bear.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section == 0 ? self.r1c : self.r2c;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if( indexPath.section == 0 )
        return 44.0f;
    else
        return 60.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 36.0f;
}

- (UIView *)headerViewWithTitle:(NSString *)title{
    UIView *content = [[UIView alloc] init];
    
    UILabel *label = ({
        UILabel *l = [[UILabel alloc] init];
        l.translatesAutoresizingMaskIntoConstraints = NO;
        l.text = title;
        l.font = [UIFont systemFontOfSize:21 weight:UIFontWeightMedium];
        l;
    });
    
    [content addSubview:label];
    [label.topAnchor constraintEqualToAnchor:content.topAnchor].active = YES;
    [label.leftAnchor constraintEqualToAnchor:content.leftAnchor constant:16].active = YES;
    [label.rightAnchor constraintEqualToAnchor:content.rightAnchor].active = YES;
    [label.bottomAnchor constraintEqualToAnchor:content.bottomAnchor].active = YES;
    
    return content;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    if( section == 0 ){
        return self.section1Header ? : ({
            self.section1Header = [self headerViewWithTitle:@"Undo"];
            ((UILabel *)self.section1Header.subviews.firstObject).textColor = [UIColor colorWithIndex:2];
            self.section1Header;
        });
    }else{
        return self.section2Header ? : ({
            self.section2Header = [self headerViewWithTitle:@"Checked"];
            ((UILabel *)self.section2Header.subviews.firstObject).textColor = [UIColor colorWithIndex:0];
            self.section2Header;
        });
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if( scrollView.contentOffset.y < 0 && self.adjust ){
        self.tfLayoutGuide.constant = fabs(scrollView.contentOffset.y) - 104 - STATUS_BAR_HEIGHT;
        scrollView.alpha = 1 - fabs(scrollView.contentOffset.y) / (104 + STATUS_BAR_HEIGHT);
        
        if( scrollView.contentOffset.y < -( 104 + STATUS_BAR_HEIGHT ) ){
            self.adjust = NO;
            self.tfLayoutGuide.constant = STATUS_BAR_HEIGHT;
            scrollView.hidden = YES;
            [self.tf.textField becomeFirstResponder];
            [self letSetting];
        }
        
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CRLIAsset *asset;
    if( indexPath.section == 0 )
        asset = self.undoAssets[indexPath.row];
    else
        asset = self.checkedAssets[indexPath.row];
        
    
    CRListTableViewCell *c = [[CRListTableViewCell alloc] init];
    c.listLabel.text = asset.item;
    c.themeColor = [UIColor colorWithIndex:[asset.color intValue]];
    
    return c;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CRListTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if( indexPath.section == 0 ){
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self letAlertActionWithTitle:@"Check this item?" msg:nil
                              actionTitle:@"Check"
                                  handler:^(UIAlertAction *action){
                                      cell.listLabel.overline = YES;
                                      self.r1c--;
                                      self.r2c++;
                                      
                                      [self.checkedAssets addObject:self.assets.firstObject];
                                      
                                      [tableView moveRowAtIndexPath:indexPath toIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
                                      cell.timeString = @"dasdsa";
                                      cell.selected = NO;
                                  } cancel:^(UIAlertAction *action){
                                      cell.selected = NO;
                                  }];
        });
    }else{

        dispatch_async(dispatch_get_main_queue(), ^{
            [self letAlertActionWithTitle:@"Are you sure want to recover this item?" msg:nil
                              actionTitle:@"Recover"
                                  handler:^(UIAlertAction *action){
                                      cell.listLabel.overline = NO;
                                      self.r1c++;
                                      self.r2c--;
                                      [tableView moveRowAtIndexPath:indexPath toIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
                                      cell.timeString = nil;
                                      cell.selected = NO;
                                  } cancel:^(UIAlertAction *action){
                                      cell.selected = NO;
                                  }];
        });
    }
}

- (void)letAlertActionWithTitle:(NSString *)t
                            msg:(NSString *)m
                    actionTitle:(NSString *)at
                        handler:(void (^ __nullable)(UIAlertAction *action))handler
                         cancel:(void (^ __nullable)(UIAlertAction *action))cancel{
    UIAlertController *al = [UIAlertController alertControllerWithTitle:t message:m preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction     *ca = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:cancel];
    UIAlertAction     *ac = [UIAlertAction actionWithTitle:at style:UIAlertActionStyleDefault handler:handler];
    
    [al addAction:ac];
    [al addAction:ca];
    [self presentViewController:al animated:YES completion:nil];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
