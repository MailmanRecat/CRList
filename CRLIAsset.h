//
//  CRLIAsset.h
//  CRList
//
//  Created by caine on 1/8/16.
//  Copyright © 2016 com.caine. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *const CRLIAssetTokenDicKey                  = @"token";
static NSString *const CRLIAssetItemDicKey                   = @"item";
static NSString *const CRLIAssetAskBeforeCheckDicKey         = @"askBeforeCheck";
static NSString *const CRLIAssetShowBadgeNumberDicKey        = @"showBadgeNumber";
static NSString *const CRLIAssetCheckedTimeDicKey            = @"CheckedTime";
static NSString *const CRLIAssetAlertTimeDicKey              = @"alertTime";
static NSString *const CRLIAssetColorDicKey                  = @"color";

static NSString *const CRLIAssetTokenDefVal                  = @"noToken";
static NSString *const CRLIAssetItemDefVal                   = @"noItem";
static NSString *const CRLIAssetAskBeforeCheckDefVal         = @"noCheck";
static NSString *const CRLIAssetShowBadgeNumberDefVal        = @"noBadgeNumber";
static NSString *const CRLIAssetCheckedTimeDefVal            = @"noChecked";
static NSString *const CRLIAssetAlertTimeDefVal              = @"noAlert";
static NSString *const CRLIAssetColorDefVal                  = @"noColor";

@interface CRLIAsset : NSObject

@property( nonatomic, strong ) NSString *token;
@property( nonatomic, strong ) NSString *item;
@property( nonatomic, strong ) NSString *askBeforeCheck;
@property( nonatomic, strong ) NSString *showBadgeNumber;
@property( nonatomic, strong ) NSString *checkedTime;
@property( nonatomic, strong ) NSString *alertTime;
@property( nonatomic, strong ) NSString *color;

+ (instancetype)defaultAsset;
+ (instancetype)assetFromDic:(NSDictionary *)d;

@end
