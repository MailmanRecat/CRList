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
#import "CRLIAssetManager.h"
#import "Craig.h"

@interface ViewController()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

@property( nonatomic, strong ) UITableView *bear;
@property( nonatomic, strong ) UIVisualEffectView *section1Header;
@property( nonatomic, strong ) UIVisualEffectView *section2Header;
@property( nonatomic, strong ) UILabel *section1HeaderTitle;
@property( nonatomic, strong ) UILabel *section2HeaderTitle;

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

@property( nonatomic, strong ) UIView *ground;
@property( nonatomic, strong ) UIImageView *air;
@property( nonatomic, strong ) NSLayoutConstraint *tc;
@end

@implementation ViewController

- (void)letLoadAnimation{
    
    self.ground = ({
        UIView *g = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        g.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:g];
        g;
    });
    
    self.air = ({
        UIImageView *i = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"undos.png"]];
        i.contentMode = UIViewContentModeScaleAspectFit;
        i.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addSubview:i];
        [i.widthAnchor constraintEqualToAnchor:self.view.widthAnchor].active = YES;
        [i.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
        [i.heightAnchor constraintEqualToAnchor:i.widthAnchor].active = YES;
        self.tc = [i.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor];
        self.tc.active = YES;
        i;
    });
}

- (void)viewDidAppear:(BOOL)animated{
    
    if( self.ground && self.air ){
    
        self.tc.constant = -(self.view.frame.size.height + self.view.frame.size.width / 2);
    
        [UIView animateWithDuration:1.382
                              delay:0.25 options:UIViewAnimationOptionCurveLinear
                         animations:^{
                         
                             self.ground.alpha     = 0;
                             [self.view layoutIfNeeded];
                         
                         }completion:^(BOOL f){
                             [self.ground removeFromSuperview];
                             [self.air removeFromSuperview];
                         
                             self.tc     = nil;
                             self.ground = nil;
                             self.air    = nil;
                         }];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor clearColor]];
    [self setAdjust:YES];
    [self setAssets:[CRLIAssetManager fetchAssets]];
    [self letBear];
    [self letTextField];
    [self letObserver];
    
    [self letLoadAnimation];
}

- (void)setAssets:(NSMutableArray *)assets{
    _assets = assets;
    
    if( self.undoAssets == nil )
        self.undoAssets = [[NSMutableArray alloc] init];
    else
        [self.undoAssets removeAllObjects];
    
    if( self.checkedAssets == nil )
        self.checkedAssets = [[NSMutableArray alloc] init];
    else
        [self.checkedAssets removeAllObjects];
    
    self.r1c = self.r2c = 0;
    [assets enumerateObjectsUsingBlock:^(CRLIAsset *asset, NSUInteger index, BOOL *sS){
        if( [asset.checkedTime isEqualToString:CRLIAssetCheckedTimeDefVal] ){
            self.r1c++;
            [self.undoAssets addObject:asset];
        }else{
            self.r2c++;
            [self.checkedAssets addObject:asset];
        }
    }];
}

- (void)letSynchronize{
    [CRLIAssetManager updateAssets:self.assets];
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

- (void)tfShouldEndTask{
    self.adjust = YES;
    if( [self.tf.done.titleLabel.text isEqualToString:@"Cancel"] )
        [self letCancel];
    else
        [self letItemAdd];
}

- (void)letItemAdd{
    
    if( [self.tf.textField.text isEqualToString:@"app.execute.clear"] ){
        [CRLIAssetManager clearAllAssets:YES];
        [self setAssets:[CRLIAssetManager fetchAssets]];
        [self letCancel];
        [self.bear reloadData];
        return;
    }
    
    CRLIAsset *asset = [CRLIAsset defaultAsset];
    asset.item  = self.tf.textField.text.length > 256 ? [self.tf.textField.text substringToIndex:256] : self.tf.textField.text;
    asset.color = [NSString stringWithFormat:@"%ld", self.sv.selectedIndexPath.row];
    
    [self.assets insertObject:asset atIndex:0];
    [self.undoAssets insertObject:asset atIndex:0];
    self.r1c++;
    
    [self.bear insertRowsAtIndexPaths:@[
                                        [NSIndexPath indexPathForRow:0 inSection:0]
                                        ]
                     withRowAnimation:UITableViewRowAnimationFade];
    
    self.section1HeaderTitle.text = [NSString stringWithFormat:@"Todo ( %ld items )", self.r1c];

    [self letSynchronize];
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
    self.sv = ({
        CRListSettingView *st = [[CRListSettingView alloc] init];
        st.translatesAutoresizingMaskIntoConstraints = NO;
        st;
    });
    
    self.bear = ({
        UITableView *bear = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
        bear.translatesAutoresizingMaskIntoConstraints = NO;
        bear.showsHorizontalScrollIndicator = NO;
        bear.showsVerticalScrollIndicator = NO;
        bear.contentInset  = UIEdgeInsetsMake(8, 0, 0, 0);
        bear.contentOffset = CGPointMake(0, -8);
        bear.backgroundColor = [UIColor clearColor];
        bear.separatorEffect = [UIVibrancyEffect effectForBlurEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
        bear.separatorInset  = UIEdgeInsetsMake(0, 64, 0, 0);
        bear.allowsMultipleSelectionDuringEditing = NO;
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
        return 68.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 36.0f;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)updateHeaderView{
    self.section1HeaderTitle.text = [NSString stringWithFormat:@"Todo ( %ld items )", self.r1c];
    self.section2HeaderTitle.text = [NSString stringWithFormat:@"Done ( %ld items )", self.r2c];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    if( section == 0 ){
        return self.section1Header ? : ({
            self.section1Header = [Craig headerViewWithTitle:[NSString stringWithFormat:@"Todo ( %ld items )", self.r1c]];
            [self.section1Header.contentView.subviews enumerateObjectsUsingBlock:^(UIView *v, NSUInteger ind, BOOL *sS){
                if( [v isKindOfClass:[UILabel class]] ){
                    self.section1HeaderTitle = (UILabel *)v;
                    *sS = YES;
                }
            }];
            self.section1Header;
        });
    }else{
        return self.section2Header ? : ({
            self.section2Header = [Craig headerViewWithTitle:[NSString stringWithFormat:@"Done ( %ld items )", self.r2c]];
            [self.section2Header.contentView.subviews enumerateObjectsUsingBlock:^(UIView *v, NSUInteger ind, BOOL *sS){
                if( [v isKindOfClass:[UILabel class]] ){
                    self.section2HeaderTitle = (UILabel *)v;
                    *sS = YES;
                }
            }];

            self.section2Header;
        });
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if( scrollView.contentOffset.y < -8 && self.adjust ){
        self.tfLayoutGuide.constant = fabs(scrollView.contentOffset.y) - 112 - STATUS_BAR_HEIGHT;
        
        if( scrollView.contentOffset.y < -( 112 + STATUS_BAR_HEIGHT ) ){
            self.adjust = NO;
            self.tfLayoutGuide.constant = STATUS_BAR_HEIGHT;
            scrollView.hidden = YES;
            [self.tf.textField becomeFirstResponder];
            [self letSetting];
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CRListTableViewCell *hair;
    CRLIAsset *asset;
    
    if( indexPath.section == 0 )
        asset = self.undoAssets[indexPath.row];
    else
        asset = self.checkedAssets[indexPath.row];
    
    hair = (CRListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CRListTableViewCellID] ? : [CRListTableViewCell new];
    
    hair.themeColor = [UIColor colorWithIndex:[asset.color intValue]];
    
    if( indexPath.section == 0 ){
        
        hair.listLabel.text = asset.item;
        hair.timeString = CRLIAssetCheckedTimeDefVal;
        [hair.listLabel setOverline:NO animation:NO];
        
    }else if( indexPath.section == 1 ){
        
        hair.listLabel.text = asset.item;
        hair.timeString = asset.checkedTime;
        [hair.listLabel setOverline:YES animation:NO];
        
    }
    
    return hair;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CRListTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if( indexPath.section == 0 ){
        
        CRLIAsset *asset = [self.undoAssets objectAtIndex:indexPath.row];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self letAlertActionWithTitle:@"Done this item?" msg:nil
                              actionTitle:@"Done"
                                tintColor:[UIColor colorWithIndex:[asset.color intValue]]
                                  handler:^(UIAlertAction *action){
                                      cell.listLabel.overline = YES;
                                      self.r1c--;
                                      self.r2c++;
                                      
                                      [asset setCheckedTime:[Craig timeString]];
                                      [cell setTimeString:asset.checkedTime];
                                      
                                      [self.undoAssets removeObjectAtIndex:indexPath.row];
                                      [self.checkedAssets insertObject:asset atIndex:0];
                                      [self.assets removeObject:asset];
                                      [self.assets insertObject:asset atIndex:0];
                                      [self letSynchronize];
                                      
                                      [tableView moveRowAtIndexPath:indexPath toIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
                                      
                                      [self updateHeaderView];
                                      [tableView deselectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1] animated:NO];

                                  } cancel:^(UIAlertAction *action){
                                      
                                      [tableView deselectRowAtIndexPath:indexPath animated:NO];
                                      
                                  }];
        });
    }else{
        
        CRLIAsset *asset = [self.checkedAssets objectAtIndex:indexPath.row];

        dispatch_async(dispatch_get_main_queue(), ^{
            [self letAlertActionWithTitle:@"Are you sure want to recover this item?" msg:nil
                              actionTitle:@"Recover"
                                tintColor:[UIColor colorWithIndex:[asset.color intValue]]
                                  handler:^(UIAlertAction *action){
                                      cell.listLabel.overline = NO;
                                      self.r1c++;
                                      self.r2c--;
                                      
                                      cell.timeString = asset.checkedTime = CRLIAssetCheckedTimeDefVal;
                                      
                                      [self.checkedAssets removeObjectAtIndex:indexPath.row];
                                      [self.undoAssets insertObject:asset atIndex:0];
                                      [self.assets removeObject:asset];
                                      [self.assets insertObject:asset atIndex:0];
                                      [self letSynchronize];
                                      
                                      [tableView moveRowAtIndexPath:indexPath toIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
                                      
                                      [self updateHeaderView];
                                      [tableView deselectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO];

                                  } cancel:^(UIAlertAction *action){
                                      
                                      [tableView deselectRowAtIndexPath:indexPath animated:NO];
                                      
                                  }];
        });
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
                                            forRowAtIndexPath:(NSIndexPath *)indexPath{
    if( editingStyle == UITableViewCellEditingStyleDelete ){
        
        CRLIAsset *editingAsset = indexPath.section == 0 ? self.undoAssets[indexPath.row] : self.checkedAssets[indexPath.row];
        
        if( indexPath.section == 0 ){
            self.r1c--;
            [self.undoAssets removeObject:editingAsset];
        }else{
            self.r2c--;
            [self.checkedAssets removeObject:editingAsset];
        }
        
        [self.assets removeObject:editingAsset];
        [self letSynchronize];
        
        [tableView deleteRowsAtIndexPaths:@[ indexPath ] withRowAnimation:UITableViewRowAnimationLeft];
        [self updateHeaderView];
    }
}

- (void)letAlertActionWithTitle:(NSString *)t
                            msg:(NSString *)m
                    actionTitle:(NSString *)at
                      tintColor:(UIColor *)tintColor
                        handler:(void (^ __nullable)(UIAlertAction *action))handler
                         cancel:(void (^ __nullable)(UIAlertAction *action))cancel{
    UIAlertController *al = [UIAlertController alertControllerWithTitle:t message:m preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction     *ca = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:cancel];
    UIAlertAction     *ac = [UIAlertAction actionWithTitle:at style:UIAlertActionStyleDefault handler:handler];
    
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:t];
    [title addAttribute:NSFontAttributeName
                  value:[UIFont systemFontOfSize:20 weight:UIFontWeightRegular]
                  range:NSMakeRange(0, title.length)];
        [title addAttribute:NSForegroundColorAttributeName
                      value:tintColor
                      range:NSMakeRange(0, title.length)];
        [al setValue:title forKey:@"attributedTitle"];
    
    [al addAction:ac];
    [al addAction:ca];
    [self presentViewController:al animated:YES completion:nil];
    al.view.tintColor = tintColor;
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
