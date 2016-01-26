//
//  SearchSettingViewController.m
//  CRList
//
//  Created by caine on 1/26/16.
//  Copyright © 2016 com.caine. All rights reserved.
//

#import "SearchSettingViewController.h"
#import "Craig.h"

@interface SearchSettingViewController()<UITableViewDataSource, UITableViewDelegate>

@property( nonatomic, strong ) UITableView *bear;
@property( nonatomic, strong ) UITextField *searchField;
@property( nonatomic, strong ) UIButton    *dismissButton;
@property( nonatomic, strong ) UIView      *border;

@property( nonatomic, strong ) NSArray         *headerTitles;

@property( nonatomic, strong ) UIView          *headerSettings;

@end

@implementation SearchSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.headerTitles = @[ @"settings" ];
    
    [self UI];
}

- (void)UI{
    UIVisualEffectView *visual = [[UIVisualEffectView alloc] initWithEffect:[UIVibrancyEffect effectForBlurEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]]];
    visual.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:visual];
    [visual.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
    [visual.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
    [visual.rightAnchor constraintEqualToAnchor:self.view.rightAnchor].active = YES;
    [visual.heightAnchor constraintEqualToConstant:44].active = YES;
    
    self.border = ({
        UIView *b = [UIView new];
        b.backgroundColor = [UIColor whiteColor];
        b.translatesAutoresizingMaskIntoConstraints = NO;
        [visual.contentView addSubview:b];
        [b.leftAnchor constraintEqualToAnchor:visual.contentView.leftAnchor].active = YES;
        [b.rightAnchor constraintEqualToAnchor:visual.contentView.rightAnchor].active = YES;
        [b.bottomAnchor constraintEqualToAnchor:visual.contentView.bottomAnchor].active = YES;
        [b.heightAnchor constraintEqualToConstant:0.5].active = YES;
        b;
    });
    
    self.searchField = ({
        UITextField *textfield = [[UITextField alloc] init];
        textfield.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
        textfield.layer.cornerRadius = 14.0f;
        textfield.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addSubview:textfield];
        [textfield.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:8].active = YES;
        [textfield.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:8].active = YES;
        [textfield.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:-8].active = YES;
        [textfield.heightAnchor constraintEqualToConstant:28].active = YES;
        textfield;
    });
    
    self.bear = ({
        UITableView *bear = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
        bear.translatesAutoresizingMaskIntoConstraints = NO;
        bear.showsHorizontalScrollIndicator = NO;
        bear.showsVerticalScrollIndicator = NO;
        bear.sectionFooterHeight = 0.0f;
        bear.backgroundColor = [UIColor clearColor];
        bear.separatorEffect = [UIVibrancyEffect effectForBlurEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
        bear.allowsMultipleSelectionDuringEditing = NO;
        bear.delegate = self;
        bear.dataSource = self;
        
        [self.view addSubview:bear];
        [bear.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:44].active = YES;
        [bear.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
        [bear.rightAnchor constraintEqualToAnchor:self.view.rightAnchor].active = YES;
        [bear.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
        
        bear;
    });
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.headerTitles.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if( section == 0 ){
        if( self.headerSettings == nil ){
            self.headerSettings =  [Craig headerViewWithTitle:@"Settings"];
        }
        
        return self.headerSettings;
    }
    
    return [UIView new];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FUCKIII"];
    if( cell == nil ){
        cell =  [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FUCKIII"];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.selectedBackgroundView = ({
            UIVibrancyEffect *eff = [UIVibrancyEffect effectForBlurEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
            UIVisualEffectView *visual = [[UIVisualEffectView alloc] initWithEffect:eff];
            UIView *v = [[UIView alloc] init];
            v.backgroundColor = [UIColor whiteColor];
            v.translatesAutoresizingMaskIntoConstraints = NO;
            [visual.contentView addSubview:v];
            [v.topAnchor constraintEqualToAnchor:visual.contentView.topAnchor].active = YES;
            [v.leftAnchor constraintEqualToAnchor:visual.contentView.leftAnchor].active = YES;
            [v.rightAnchor constraintEqualToAnchor:visual.contentView.rightAnchor].active = YES;
            [v.bottomAnchor constraintEqualToAnchor:visual.contentView.bottomAnchor].active = YES;
            visual;
        });
    }
    
    cell.textLabel.text = @"Change background";
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    [self presentViewController:[UIImagePickerController new] animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
