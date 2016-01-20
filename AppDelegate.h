//
//  AppDelegate.h
//  CRList
//
//  Created by caine on 1/8/16.
//  Copyright © 2016 com.caine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CRLIManager.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property( strong, nonatomic ) UIWindow *window;
@property( strong, nonatomic ) CRLIManager *listManager;

@end

