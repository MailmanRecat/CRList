//
//  CRPreviewController.h
//  CRList
//
//  Created by caine on 1/13/16.
//  Copyright © 2016 com.caine. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CRPreviewControllerActionDelegate <NSObject>

- (void)CRPreviewAction:(NSString *)type fromController:(UIViewController *)controller;

@end

@interface CRPreviewController : UIViewController

@property( nonatomic, weak   ) id<CRPreviewControllerActionDelegate> delegate;
@property( nonatomic, strong ) NSIndexPath *indexPath;

@end
