//
//  CRPreviewController.m
//  CRList
//
//  Created by caine on 1/13/16.
//  Copyright © 2016 com.caine. All rights reserved.
//

#import "CRPreviewController.h"
#import "UIColor+Theme.h"

@implementation CRPreviewController

- (NSArray<id<UIPreviewActionItem>> *)previewActionItems {
    
    UIPreviewAction *deleteAction = [UIPreviewAction actionWithTitle:@"Delete" style:UIPreviewActionStyleDestructive handler:
                                     ^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
                                         
                                         if( self.delegate && [self.delegate respondsToSelector:@selector(CRPreviewAction:fromController:)] ){
                                             [self.delegate CRPreviewAction:action.title fromController:previewViewController];
                                         }
                                         
                                     }];
    
    UIPreviewAction *operaAction  = [UIPreviewAction actionWithTitle:self.indexPath.section == 0 ? @"Done" : @"Recover"
                                                               style:UIPreviewActionStyleDefault handler:
                                     ^(UIPreviewAction *action, UIViewController *previewViewController){
                                         
                                         if( self.delegate && [self.delegate respondsToSelector:@selector(CRPreviewAction:fromController:)] ){
                                             [self.delegate CRPreviewAction:action.title fromController:previewViewController];
                                         }
                                         
                                     }];
    
    return @[ operaAction, deleteAction ];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    UIVisualEffectView *visual = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight]];
    visual.frame = self.view.frame;
    visual.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [self.view addSubview:visual];
    
    UIVisualEffectView *vibual = [[UIVisualEffectView alloc] initWithEffect:[UIVibrancyEffect effectForBlurEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight]]];
    vibual.frame = self.view.frame;
    vibual.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:vibual];
    
    UILabel *text = [[UILabel alloc] initWithFrame:({
        CGRect rect = self.view.frame;
        rect.origin.x     = 16;
        rect.origin.y     = 16;
        rect.size.width  -= 32;
        rect.size.height -=32;
        rect;
    })];
    text.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [vibual.contentView addSubview:text];
    
    text.text = self.title;
    text.font = [UIFont systemFontOfSize:64 weight:UIFontWeightThin];
    text.textAlignment = NSTextAlignmentCenter;
    text.textColor = [UIColor whiteColor];
    text.adjustsFontSizeToFitWidth = YES;
    text.numberOfLines = 0;
}

@end
