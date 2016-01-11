//
//  CRLIAssetManager.m
//  CRList
//
//  Created by caine on 1/10/16.
//  Copyright © 2016 com.caine. All rights reserved.
//

#import "CRLIAssetManager.h"

static NSString *const CRLIAssetsDatabaseKey = @"CR_LIST_ITEM_ASSETS_DATABASE_KEY";

@implementation CRLIAssetManager

+ (CRLIAsset *)assetFromArray:(NSArray *)array{
    if( array.count != 7 ) return [CRLIAsset defaultAsset];
    
    return [CRLIAsset assetFromDic:@{
                                     CRLIAssetTokenDicKey: array.firstObject,
                                     CRLIAssetItemDicKey: array[1],
                                     CRLIAssetAskBeforeCheckDicKey: array[2],
                                     CRLIAssetShowBadgeNumberDicKey: array[3],
                                     CRLIAssetCheckedTimeDicKey: array[4],
                                     CRLIAssetAlertTimeDicKey: array[5],
                                     CRLIAssetColorDicKey: array[6]
                                     }];
}

+ (NSArray *)arrayFromAsset:(CRLIAsset *)asset{
    return @[
             asset.token,
             asset.item,
             asset.askBeforeCheck,
             asset.showBadgeNumber,
             asset.checkedTime,
             asset.alertTime,
             asset.color
             ];
}

+ (NSMutableArray *)fetchAssets{
    NSArray *res = [[NSUserDefaults standardUserDefaults] arrayForKey:CRLIAssetsDatabaseKey];
    
    NSMutableArray *ass = [[NSMutableArray alloc] init];
    
    if( res ){
        [res enumerateObjectsUsingBlock:^(NSArray *assetArray, NSUInteger ind, BOOL *sS){
            [ass addObject:[self assetFromArray:assetArray]];
        }];
    }else{
        [ass addObject:({
            CRLIAsset *asset = [CRLIAsset defaultAsset];
            asset.item  = @"Pull-down to add";
            asset.color = @"5";
            asset;
        })];
        [self updateAssets:ass];
    }
    
    return ass;
//    return @[
//             [[CRLIAsset assetFromDic:@{
//                                              CRLIAssetTokenDicKey: CRLIAssetTokenDefVal,
//                                              CRLIAssetItemDicKey: @"Check Email",
//                                              CRLIAssetAskBeforeCheckDicKey: CRLIAssetAskBeforeCheckDefVal,
//                                              CRLIAssetShowBadgeNumberDicKey: CRLIAssetShowBadgeNumberDefVal,
//                                              CRLIAssetCheckedTimeDicKey: CRLIAssetCheckedTimeDefVal,
//                                              CRLIAssetAlertTimeDicKey: CRLIAssetAlertTimeDefVal,
//                                              CRLIAssetColorDicKey: CRLIAssetColorDefVal
//                                              }],
//              [[CRLIAsset assetFromDic:@{
//                                         CRLIAssetTokenDicKey: CRLIAssetTokenDefVal,
//                                         CRLIAssetItemDicKey: @"",
//                                         CRLIAssetAskBeforeCheckDicKey: CRLIAssetAskBeforeCheckDefVal,
//                                         CRLIAssetShowBadgeNumberDicKey: CRLIAssetShowBadgeNumberDefVal,
//                                         CRLIAssetCheckedTimeDicKey: CRLIAssetCheckedTimeDefVal,
//                                         CRLIAssetAlertTimeDicKey: CRLIAssetAlertTimeDefVal,
//                                         CRLIAssetColorDicKey: CRLIAssetColorDefVal
//                                         }],
//               [[CRLIAsset assetFromDic:@{
//                                          CRLIAssetTokenDicKey: CRLIAssetTokenDefVal,
//                                          CRLIAssetItemDicKey: CRLIAssetItemDefVal,
//                                          CRLIAssetAskBeforeCheckDicKey: CRLIAssetAskBeforeCheckDefVal,
//                                          CRLIAssetShowBadgeNumberDicKey: CRLIAssetShowBadgeNumberDefVal,
//                                          CRLIAssetCheckedTimeDicKey: CRLIAssetCheckedTimeDefVal,
//                                          CRLIAssetAlertTimeDicKey: CRLIAssetAlertTimeDefVal,
//                                          CRLIAssetColorDicKey: CRLIAssetColorDefVal
//                                          }],
//                [[CRLIAsset assetFromDic:@{
//                                           CRLIAssetTokenDicKey: CRLIAssetTokenDefVal,
//                                           CRLIAssetItemDicKey: CRLIAssetItemDefVal,
//                                           CRLIAssetAskBeforeCheckDicKey: CRLIAssetAskBeforeCheckDefVal,
//                                           CRLIAssetShowBadgeNumberDicKey: CRLIAssetShowBadgeNumberDefVal,
//                                           CRLIAssetCheckedTimeDicKey: CRLIAssetCheckedTimeDefVal,
//                                           CRLIAssetAlertTimeDicKey: CRLIAssetAlertTimeDefVal,
//                                           CRLIAssetColorDicKey: CRLIAssetColorDefVal
//                                           }],
//                 [[CRLIAsset assetFromDic:@{
//                                            CRLIAssetTokenDicKey: CRLIAssetTokenDefVal,
//                                            CRLIAssetItemDicKey: CRLIAssetItemDefVal,
//                                            CRLIAssetAskBeforeCheckDicKey: CRLIAssetAskBeforeCheckDefVal,
//                                            CRLIAssetShowBadgeNumberDicKey: CRLIAssetShowBadgeNumberDefVal,
//                                            CRLIAssetCheckedTimeDicKey: CRLIAssetCheckedTimeDefVal,
//                                            CRLIAssetAlertTimeDicKey: CRLIAssetAlertTimeDefVal,
//                                            CRLIAssetColorDicKey: CRLIAssetColorDefVal
//                                            }],
//                  [[CRLIAsset assetFromDic:@{
//                                             CRLIAssetTokenDicKey: CRLIAssetTokenDefVal,
//                                             CRLIAssetItemDicKey: CRLIAssetItemDefVal,
//                                             CRLIAssetAskBeforeCheckDicKey: CRLIAssetAskBeforeCheckDefVal,
//                                             CRLIAssetShowBadgeNumberDicKey: CRLIAssetShowBadgeNumberDefVal,
//                                             CRLIAssetCheckedTimeDicKey: CRLIAssetCheckedTimeDefVal,
//                                             CRLIAssetAlertTimeDicKey: CRLIAssetAlertTimeDefVal,
//                                             CRLIAssetColorDicKey: CRLIAssetColorDefVal
//                                             }],
//                   [[CRLIAsset assetFromDic:@{
//                                              CRLIAssetTokenDicKey: CRLIAssetTokenDefVal,
//                                              CRLIAssetItemDicKey: CRLIAssetItemDefVal,
//                                              CRLIAssetAskBeforeCheckDicKey: CRLIAssetAskBeforeCheckDefVal,
//                                              CRLIAssetShowBadgeNumberDicKey: CRLIAssetShowBadgeNumberDefVal,
//                                              CRLIAssetCheckedTimeDicKey: CRLIAssetCheckedTimeDefVal,
//                                              CRLIAssetAlertTimeDicKey: CRLIAssetAlertTimeDefVal,
//                                              CRLIAssetColorDicKey: CRLIAssetColorDefVal
//                                              }],
//                    [[CRLIAsset assetFromDic:@{
//                                               CRLIAssetTokenDicKey: CRLIAssetTokenDefVal,
//                                               CRLIAssetItemDicKey: CRLIAssetItemDefVal,
//                                               CRLIAssetAskBeforeCheckDicKey: CRLIAssetAskBeforeCheckDefVal,
//                                               CRLIAssetShowBadgeNumberDicKey: CRLIAssetShowBadgeNumberDefVal,
//                                               CRLIAssetCheckedTimeDicKey: CRLIAssetCheckedTimeDefVal,
//                                               CRLIAssetAlertTimeDicKey: CRLIAssetAlertTimeDefVal,
//                                               CRLIAssetColorDicKey: CRLIAssetColorDefVal
//                                               }],
//                     [[CRLIAsset assetFromDic:@{
//                                                CRLIAssetTokenDicKey: CRLIAssetTokenDefVal,
//                                                CRLIAssetItemDicKey: CRLIAssetItemDefVal,
//                                                CRLIAssetAskBeforeCheckDicKey: CRLIAssetAskBeforeCheckDefVal,
//                                                CRLIAssetShowBadgeNumberDicKey: CRLIAssetShowBadgeNumberDefVal,
//                                                CRLIAssetCheckedTimeDicKey: CRLIAssetCheckedTimeDefVal,
//                                                CRLIAssetAlertTimeDicKey: CRLIAssetAlertTimeDefVal,
//                                                CRLIAssetColorDicKey: CRLIAssetColorDefVal
//                                                }],
//                      [[CRLIAsset assetFromDic:@{
//                                                 CRLIAssetTokenDicKey: CRLIAssetTokenDefVal,
//                                                 CRLIAssetItemDicKey: CRLIAssetItemDefVal,
//                                                 CRLIAssetAskBeforeCheckDicKey: CRLIAssetAskBeforeCheckDefVal,
//                                                 CRLIAssetShowBadgeNumberDicKey: CRLIAssetShowBadgeNumberDefVal,
//                                                 CRLIAssetCheckedTimeDicKey: CRLIAssetCheckedTimeDefVal,
//                                                 CRLIAssetAlertTimeDicKey: CRLIAssetAlertTimeDefVal,
//                                                 CRLIAssetColorDicKey: CRLIAssetColorDefVal
//                                                 }],
//             ];
}

+ (BOOL)updateAssets:(NSMutableArray *)assets{
    NSMutableArray *copy = [[NSMutableArray alloc] initWithArray:assets];
    [copy enumerateObjectsUsingBlock:^(CRLIAsset *ass, NSUInteger ind, BOOL *sS){
        [copy replaceObjectAtIndex:ind withObject:[self arrayFromAsset:ass]];
    }];
    
    [[NSUserDefaults standardUserDefaults] setObject:copy forKey:CRLIAssetsDatabaseKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    return YES;
}

+ (BOOL)clearAllAssets:(BOOL)sure{
    if( sure ){
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:CRLIAssetsDatabaseKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    return YES;
}

@end
