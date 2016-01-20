//
//  ViewController.m
//  CRList
//
//  Created by caine on 1/8/16.
//  Copyright © 2016 com.caine. All rights reserved.
//

#define STATUS_BAR_HEIGHT [UIApplication sharedApplication].statusBarFrame.size.height
#define LIST_MAX_ITEM_LEN 128

#import "ViewController.h"
#import "CRListTableViewCell.h"
#import "CRListTextField.h"
#import "CRListSettingView.h"
#import "UIColor+Theme.h"
#import "CRLIAssetManager.h"
#import "CRLIManager.h"
#import "Craig.h"
#import "CRPreviewController.h"

@interface ViewController()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate, UITextFieldDelegate, UIViewControllerPreviewingDelegate, CRPreviewControllerActionDelegate>

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

@property( nonatomic, strong ) UIView *ground;
@property( nonatomic, strong ) UIImageView *air;
@property( nonatomic, strong ) NSLayoutConstraint *tc;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor clearColor]];
    [self setAdjust:YES];
    
    [self letBear];
    [self letTextField];
    
    [self let3DTouch];
    [self letObserver];
    
    [self letLoadAnimation];
}

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

- (void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit{}

- (UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location{
    NSIndexPath *indexPath = [self.bear indexPathForRowAtPoint:location];
    if( indexPath == nil ) return nil;
    
    CRListTableViewCell *hair = [self.bear cellForRowAtIndexPath:indexPath];
    previewingContext.sourceRect = hair.frame;
    
    CRPreviewController *previewController = [[CRPreviewController alloc] init];
    previewController.title = indexPath.section == 0 ? ((CRLIAsset *)[CRLIManager defaultManager].doneAssets[indexPath.row]).item : ((CRLIAsset *)[CRLIManager defaultManager].doneAssets[indexPath.row]).item;
    
    previewController.indexPath = indexPath;
    previewController.delegate  = self;
    
    return previewController;
}

- (void)CRPreviewAction:(NSString *)type fromController:(UIViewController *)controller{
    if( [type isEqualToString:@"Delete"] ){
        
        [self letDelete:self.bear atIndexPath:((CRPreviewController *)controller).indexPath];
        
    }else if( [type isEqualToString:@"Done"] ){
        
        [self letDone:self.bear atIndexPath:((CRPreviewController *)controller).indexPath];
        
    }else if( [type isEqualToString:@"Recover"] ){
        
        [self letRecover:self.bear atIndexPath:((CRPreviewController *)controller).indexPath];
        
    }
}

- (void)let3DTouch{
    BOOL support3DTouch = YES;
    
    if( self.traitCollection.forceTouchCapability != UIForceTouchCapabilityAvailable ) support3DTouch = NO;
    if( ![self.traitCollection respondsToSelector:@selector(forceTouchCapability)] ) support3DTouch = NO;
    
    if( support3DTouch )
        [self registerForPreviewingWithDelegate:self sourceView:self.bear];
}

- (void)letSynchronize{
    [CRLIAssetManager updateAssets:[CRLIManager defaultManager].assets];
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
        return;
    }
    
    CRLIAsset *asset = [CRLIAsset defaultAsset];
    asset.item  = self.tf.textField.text.length > LIST_MAX_ITEM_LEN ? [self.tf.textField.text substringToIndex:LIST_MAX_ITEM_LEN] : self.tf.textField.text;
    asset.color = [NSString stringWithFormat:@"%ld", self.sv.selectedIndexPath.row];
    
    [[CRLIManager defaultManager].assets insertObject:asset atIndex:0];
    [[CRLIManager defaultManager].todoAssets insertObject:asset atIndex:0];
    
    [self.bear insertRowsAtIndexPaths:@[
                                        [NSIndexPath indexPathForRow:0 inSection:0]
                                        ]
                     withRowAnimation:UITableViewRowAnimationFade];
    
    [self updateHeaderView];

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
    self.tfLayoutGuide.constant = -(88 + STATUS_BAR_HEIGHT);
    self.tfLayoutGuide.active = YES;
    [tf.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
    [tf.rightAnchor constraintEqualToAnchor:self.view.rightAnchor].active = YES;
    
    [tf.done addTarget:self action:@selector(tfShouldEndTask) forControlEvents:UIControlEventTouchUpInside];
    
    self.tf = tf;
    self.tf.textField.delegate = self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self tfShouldEndTask];
    
    return YES;
}

- (void)letDotPicker{
    
    [self.view addSubview:self.sv];
    
    self.svLayoutGuide = [self.sv.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:self.view.frame.size.height];
    self.svLayoutGuide.active = YES;
    
    [self.sv.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
    [self.sv.rightAnchor constraintEqualToAnchor:self.view.rightAnchor].active = YES;
    [self.sv.heightAnchor constraintEqualToAnchor:self.view.heightAnchor constant:-(88 + STATUS_BAR_HEIGHT)].active = YES;
    [self.sv layoutIfNeeded];
    
    self.svLayoutGuide.constant = STATUS_BAR_HEIGHT + 88;
    
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
        bear.sectionFooterHeight = 0.0f;
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

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section == 0 ? [CRLIManager defaultManager].todoAssets.count : [CRLIManager defaultManager].doneAssets.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if( indexPath.section == 0 )
        return 44.0f;
    else
        return 68.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44.0f;
}

- (void)updateHeaderView{
    NSUInteger r0c = [CRLIManager defaultManager].todoAssets.count;
    NSUInteger r1c = [CRLIManager defaultManager].doneAssets.count;
    self.section1HeaderTitle.text = [NSString stringWithFormat:@"Todo ( %ld %@ )", r0c, r0c > 1 ? @"items" : @"item"];
    self.section2HeaderTitle.text = [NSString stringWithFormat:@"Done ( %ld %@ )", r1c, r1c > 1 ? @"items" : @"item"];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    if( section == 0 ){
        return self.section1Header ? : ({
            self.section1Header = [Craig headerViewWithTitle:[NSString stringWithFormat:@"Todo ( %ld items )", [CRLIManager defaultManager].todoAssets.count]];
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
            self.section2Header = [Craig headerViewWithTitle:[NSString stringWithFormat:@"Done ( %ld items )", [CRLIManager defaultManager].doneAssets.count]];
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
    if( scrollView.contentOffset.y < 0 && self.adjust ){
        self.tfLayoutGuide.constant = fabs(scrollView.contentOffset.y) - (88 + STATUS_BAR_HEIGHT * 2);
        
        if( scrollView.contentOffset.y < -(88 + STATUS_BAR_HEIGHT * 2) ){
            self.adjust = NO;
            self.tfLayoutGuide.constant = 0;
            scrollView.hidden = YES;
            [self.tf.textField becomeFirstResponder];
            [self letDotPicker];
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CRListTableViewCell *hair;
    CRLIAsset *asset;
    
    if( indexPath.section == 0 )
        asset = [CRLIManager defaultManager].todoAssets[indexPath.row];
    else
        asset = [CRLIManager defaultManager].doneAssets[indexPath.row];
    
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
    
    if( indexPath.section == 0 ){
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self letDone:tableView atIndexPath:indexPath];
            
        });
    }else{

        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self letRecover:tableView atIndexPath:indexPath];
            
        });
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
                                            forRowAtIndexPath:(NSIndexPath *)indexPath{
    if( editingStyle == UITableViewCellEditingStyleDelete ){
        
        [self letDelete:tableView atIndexPath:indexPath];
        
    }
}

- (void)letDone:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath{
    CRListTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    CRLIManager *manager = [CRLIManager defaultManager];
    CRLIAsset *asset = [manager.todoAssets objectAtIndex:indexPath.row];
    
    [self letAlertActionWithTitle:@"Done this item?" msg:nil
                      actionTitle:@"Done"
                        tintColor:[UIColor colorWithIndex:[asset.color intValue]]
                          handler:^(UIAlertAction *action){
                              cell.listLabel.overline = YES;
                              
                              [asset setCheckedTime:[Craig timeString]];
                              [cell setTimeString:asset.checkedTime];
                              
                              [manager.todoAssets removeObjectAtIndex:indexPath.row];
                              [manager.doneAssets insertObject:asset atIndex:0];
                              [manager.assets removeObject:asset];
                              [manager.assets insertObject:asset atIndex:0];
                              [self letSynchronize];
                              
                              [tableView moveRowAtIndexPath:indexPath toIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
                              
                              [self updateHeaderView];
                              [tableView deselectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1] animated:NO];
                              
                          } cancel:^(UIAlertAction *action){
                              
                              [tableView deselectRowAtIndexPath:indexPath animated:NO];
                              
                          }];
}

- (void)letRecover:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath{
    CRListTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    CRLIManager *manager = [CRLIManager defaultManager];
    CRLIAsset *asset = [manager.doneAssets objectAtIndex:indexPath.row];
    
    [self letAlertActionWithTitle:@"Recover this item?" msg:nil
                      actionTitle:@"Recover"
                        tintColor:[UIColor colorWithIndex:[asset.color intValue]]
                          handler:^(UIAlertAction *action){
                              cell.listLabel.overline = NO;
                              
                              cell.timeString = asset.checkedTime = CRLIAssetCheckedTimeDefVal;
                              
                              [manager.doneAssets removeObjectAtIndex:indexPath.row];
                              [manager.todoAssets insertObject:asset atIndex:0];
                              [manager.assets removeObject:asset];
                              [manager.assets insertObject:asset atIndex:0];
                              [self letSynchronize];
                              
                              [tableView moveRowAtIndexPath:indexPath toIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
                              
                              [self updateHeaderView];
                              [tableView deselectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO];
                              
                          } cancel:^(UIAlertAction *action){
                              
                              [tableView deselectRowAtIndexPath:indexPath animated:NO];
                              
                          }];

}

- (void)letDelete:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath{
    CRLIManager *manager = [CRLIManager defaultManager];
    CRLIAsset *editingAsset = indexPath.section == 0 ? manager.todoAssets[indexPath.row] : manager.doneAssets[indexPath.row];
    
    if( indexPath.section == 0 ){
        [manager.todoAssets removeObject:editingAsset];
    }else{
        [manager.doneAssets removeObject:editingAsset];
    }
    
    [manager.assets removeObject:editingAsset];
    [self letSynchronize];
    
    [tableView deleteRowsAtIndexPaths:@[ indexPath ] withRowAnimation:UITableViewRowAnimationLeft];
    [self updateHeaderView];
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
