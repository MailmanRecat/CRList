//
//  CRLIAsset.m
//  CRList
//
//  Created by caine on 1/8/16.
//  Copyright © 2016 com.caine. All rights reserved.
//

#import "CRLIAsset.h"

@implementation CRLIAsset

- (instancetype)initFromDic:(NSDictionary *)d{
    self = [super init];
    if( self ){
        self.token              = d[CRLIAssetTokenDicKey];
        self.item               = d[CRLIAssetItemDicKey];
        self.askBeforeCheck     = d[CRLIAssetAskBeforeCheckDicKey];
        self.showBadgeNumber    = d[CRLIAssetShowBadgeNumberDicKey];
        self.checkedTime        = d[CRLIAssetCheckedTimeDicKey];
        self.alertTime          = d[CRLIAssetAlertTimeDicKey];
        self.color              = d[CRLIAssetColorDicKey];
    }
    return self;
}

+ (instancetype)defaultAsset{
    return [[CRLIAsset alloc] initFromDic:@{
                                            CRLIAssetTokenDicKey: CRLIAssetTokenDefVal,
                                            CRLIAssetItemDicKey: CRLIAssetItemDefVal,
                                            CRLIAssetAskBeforeCheckDicKey: CRLIAssetAskBeforeCheckDefVal,
                                            CRLIAssetShowBadgeNumberDicKey: CRLIAssetShowBadgeNumberDefVal,
                                            CRLIAssetCheckedTimeDicKey: CRLIAssetCheckedTimeDefVal,
                                            CRLIAssetAlertTimeDicKey: CRLIAssetAlertTimeDefVal,
                                            CRLIAssetColorDicKey: CRLIAssetColorDefVal
                                            }];
}

+ (instancetype)assetFromDic:(NSDictionary *)d{
    return [[CRLIAsset alloc] initFromDic:d];
}

@end
