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
//    NSArray *test = @[
//             [CRLIAsset assetFromDic:@{
//                                              CRLIAssetTokenDicKey: CRLIAssetTokenDefVal,
//                                              CRLIAssetItemDicKey: @"Check Email",
//                                              CRLIAssetAskBeforeCheckDicKey: CRLIAssetAskBeforeCheckDefVal,
//                                              CRLIAssetShowBadgeNumberDicKey: CRLIAssetShowBadgeNumberDefVal,
//                                              CRLIAssetCheckedTimeDicKey: CRLIAssetCheckedTimeDefVal,
//                                              CRLIAssetAlertTimeDicKey: CRLIAssetAlertTimeDefVal,
//                                              CRLIAssetColorDicKey: CRLIAssetColorDefVal
//                                              }],
//              [CRLIAsset assetFromDic:@{
//                                         CRLIAssetTokenDicKey: CRLIAssetTokenDefVal,
//                                         CRLIAssetItemDicKey: @"Make video film",
//                                         CRLIAssetAskBeforeCheckDicKey: CRLIAssetAskBeforeCheckDefVal,
//                                         CRLIAssetShowBadgeNumberDicKey: CRLIAssetShowBadgeNumberDefVal,
//                                         CRLIAssetCheckedTimeDicKey: CRLIAssetCheckedTimeDefVal,
//                                         CRLIAssetAlertTimeDicKey: CRLIAssetAlertTimeDefVal,
//                                         CRLIAssetColorDicKey: @"1"
//                                         }],
//               [CRLIAsset assetFromDic:@{
//                                          CRLIAssetTokenDicKey: CRLIAssetTokenDefVal,
//                                          CRLIAssetItemDicKey: @"Pick up steven at 3:00pm",
//                                          CRLIAssetAskBeforeCheckDicKey: CRLIAssetAskBeforeCheckDefVal,
//                                          CRLIAssetShowBadgeNumberDicKey: CRLIAssetShowBadgeNumberDefVal,
//                                          CRLIAssetCheckedTimeDicKey: CRLIAssetCheckedTimeDefVal,
//                                          CRLIAssetAlertTimeDicKey: CRLIAssetAlertTimeDefVal,
//                                          CRLIAssetColorDicKey: @"2"
//                                          }],
//                [CRLIAsset assetFromDic:@{
//                                           CRLIAssetTokenDicKey: CRLIAssetTokenDefVal,
//                                           CRLIAssetItemDicKey: @"Send msg to chen",
//                                           CRLIAssetAskBeforeCheckDicKey: CRLIAssetAskBeforeCheckDefVal,
//                                           CRLIAssetShowBadgeNumberDicKey: CRLIAssetShowBadgeNumberDefVal,
//                                           CRLIAssetCheckedTimeDicKey: CRLIAssetCheckedTimeDefVal,
//                                           CRLIAssetAlertTimeDicKey: CRLIAssetAlertTimeDefVal,
//                                           CRLIAssetColorDicKey: @"3"
//                                           }],
//                 [CRLIAsset assetFromDic:@{
//                                            CRLIAssetTokenDicKey: CRLIAssetTokenDefVal,
//                                            CRLIAssetItemDicKey: @"Prepare new year gift",
//                                            CRLIAssetAskBeforeCheckDicKey: CRLIAssetAskBeforeCheckDefVal,
//                                            CRLIAssetShowBadgeNumberDicKey: CRLIAssetShowBadgeNumberDefVal,
//                                            CRLIAssetCheckedTimeDicKey: CRLIAssetCheckedTimeDefVal,
//                                            CRLIAssetAlertTimeDicKey: CRLIAssetAlertTimeDefVal,
//                                            CRLIAssetColorDicKey: @"4"
//                                            }],
//                  [CRLIAsset assetFromDic:@{
//                                             CRLIAssetTokenDicKey: CRLIAssetTokenDefVal,
//                                             CRLIAssetItemDicKey: @"Prepare for meetting",
//                                             CRLIAssetAskBeforeCheckDicKey: CRLIAssetAskBeforeCheckDefVal,
//                                             CRLIAssetShowBadgeNumberDicKey: CRLIAssetShowBadgeNumberDefVal,
//                                             CRLIAssetCheckedTimeDicKey: CRLIAssetCheckedTimeDefVal,
//                                             CRLIAssetAlertTimeDicKey: CRLIAssetAlertTimeDefVal,
//                                             CRLIAssetColorDicKey: @"5"
//                                             }],
//                   [CRLIAsset assetFromDic:@{
//                                              CRLIAssetTokenDicKey: CRLIAssetTokenDefVal,
//                                              CRLIAssetItemDicKey: @"contact Lily",
//                                              CRLIAssetAskBeforeCheckDicKey: CRLIAssetAskBeforeCheckDefVal,
//                                              CRLIAssetShowBadgeNumberDicKey: CRLIAssetShowBadgeNumberDefVal,
//                                              CRLIAssetCheckedTimeDicKey: CRLIAssetCheckedTimeDefVal,
//                                              CRLIAssetAlertTimeDicKey: CRLIAssetAlertTimeDefVal,
//                                              CRLIAssetColorDicKey: @"6"
//                                              }],
//                    [CRLIAsset assetFromDic:@{
//                                               CRLIAssetTokenDicKey: CRLIAssetTokenDefVal,
//                                               CRLIAssetItemDicKey: @"Fix bike",
//                                               CRLIAssetAskBeforeCheckDicKey: CRLIAssetAskBeforeCheckDefVal,
//                                               CRLIAssetShowBadgeNumberDicKey: CRLIAssetShowBadgeNumberDefVal,
//                                               CRLIAssetCheckedTimeDicKey: CRLIAssetCheckedTimeDefVal,
//                                               CRLIAssetAlertTimeDicKey: CRLIAssetAlertTimeDefVal,
//                                               CRLIAssetColorDicKey: @"7"
//                                               }],
//                     [CRLIAsset assetFromDic:@{
//                                                CRLIAssetTokenDicKey: CRLIAssetTokenDefVal,
//                                                CRLIAssetItemDicKey: @"Meeting with craig",
//                                                CRLIAssetAskBeforeCheckDicKey: CRLIAssetAskBeforeCheckDefVal,
//                                                CRLIAssetShowBadgeNumberDicKey: CRLIAssetShowBadgeNumberDefVal,
//                                                CRLIAssetCheckedTimeDicKey: @"January 11, 2016 13:45",
//                                                CRLIAssetAlertTimeDicKey: CRLIAssetAlertTimeDefVal,
//                                                CRLIAssetColorDicKey: @"7"
//                                                }],
//                      [CRLIAsset assetFromDic:@{
//                                                 CRLIAssetTokenDicKey: CRLIAssetTokenDefVal,
//                                                 CRLIAssetItemDicKey: @"Write news page",
//                                                 CRLIAssetAskBeforeCheckDicKey: CRLIAssetAskBeforeCheckDefVal,
//                                                 CRLIAssetShowBadgeNumberDicKey: CRLIAssetShowBadgeNumberDefVal,
//                                                 CRLIAssetCheckedTimeDicKey: @"January 11, 2016 9:51",
//                                                 CRLIAssetAlertTimeDicKey: CRLIAssetAlertTimeDefVal,
//                                                 CRLIAssetColorDicKey: @"6"
//                                                 }],
//             [CRLIAsset assetFromDic:@{
//                                       CRLIAssetTokenDicKey: CRLIAssetTokenDefVal,
//                                       CRLIAssetItemDicKey: @"Art class",
//                                       CRLIAssetAskBeforeCheckDicKey: CRLIAssetAskBeforeCheckDefVal,
//                                       CRLIAssetShowBadgeNumberDicKey: CRLIAssetShowBadgeNumberDefVal,
//                                       CRLIAssetCheckedTimeDicKey: @"January 9, 2016 15:35",
//                                       CRLIAssetAlertTimeDicKey: CRLIAssetAlertTimeDefVal,
//                                       CRLIAssetColorDicKey: @"5"
//                                       }],
//             [CRLIAsset assetFromDic:@{
//                                       CRLIAssetTokenDicKey: CRLIAssetTokenDefVal,
//                                       CRLIAssetItemDicKey: @"Teach mike how to use snapshot",
//                                       CRLIAssetAskBeforeCheckDicKey: CRLIAssetAskBeforeCheckDefVal,
//                                       CRLIAssetShowBadgeNumberDicKey: CRLIAssetShowBadgeNumberDefVal,
//                                       CRLIAssetCheckedTimeDicKey: @"January 9, 2016 9:51",
//                                       CRLIAssetAlertTimeDicKey: CRLIAssetAlertTimeDefVal,
//                                       CRLIAssetColorDicKey: @"4"
//                                       }],
//             [CRLIAsset assetFromDic:@{
//                                       CRLIAssetTokenDicKey: CRLIAssetTokenDefVal,
//                                       CRLIAssetItemDicKey: @"Go runing",
//                                       CRLIAssetAskBeforeCheckDicKey: CRLIAssetAskBeforeCheckDefVal,
//                                       CRLIAssetShowBadgeNumberDicKey: CRLIAssetShowBadgeNumberDefVal,
//                                       CRLIAssetCheckedTimeDicKey: @"January 8, 2016 15:00",
//                                       CRLIAssetAlertTimeDicKey: CRLIAssetAlertTimeDefVal,
//                                       CRLIAssetColorDicKey: @"3"
//                                       }],
//             [CRLIAsset assetFromDic:@{
//                                       CRLIAssetTokenDicKey: CRLIAssetTokenDefVal,
//                                       CRLIAssetItemDicKey: @"Meeting with craig",
//                                       CRLIAssetAskBeforeCheckDicKey: CRLIAssetAskBeforeCheckDefVal,
//                                       CRLIAssetShowBadgeNumberDicKey: CRLIAssetShowBadgeNumberDefVal,
//                                       CRLIAssetCheckedTimeDicKey: @"January 8, 2016 10:20",
//                                       CRLIAssetAlertTimeDicKey: CRLIAssetAlertTimeDefVal,
//                                       CRLIAssetColorDicKey: @"0"
//                                       }],
//             [CRLIAsset assetFromDic:@{
//                                       CRLIAssetTokenDicKey: CRLIAssetTokenDefVal,
//                                       CRLIAssetItemDicKey: @"Try Mexico food",
//                                       CRLIAssetAskBeforeCheckDicKey: CRLIAssetAskBeforeCheckDefVal,
//                                       CRLIAssetShowBadgeNumberDicKey: CRLIAssetShowBadgeNumberDefVal,
//                                       CRLIAssetCheckedTimeDicKey: @"January 7, 2016 20:10",
//                                       CRLIAssetAlertTimeDicKey: CRLIAssetAlertTimeDefVal,
//                                       CRLIAssetColorDicKey: @"1"
//                                       }],
//             [CRLIAsset assetFromDic:@{
//                                       CRLIAssetTokenDicKey: CRLIAssetTokenDefVal,
//                                       CRLIAssetItemDicKey: @"Meeting with craig",
//                                       CRLIAssetAskBeforeCheckDicKey: CRLIAssetAskBeforeCheckDefVal,
//                                       CRLIAssetShowBadgeNumberDicKey: CRLIAssetShowBadgeNumberDefVal,
//                                       CRLIAssetCheckedTimeDicKey: @"January 6, 2016 10:40",
//                                       CRLIAssetAlertTimeDicKey: CRLIAssetAlertTimeDefVal,
//                                       CRLIAssetColorDicKey: @"0"
//                                       }]
//             ];
//    
//    return [[NSMutableArray alloc] initWithArray:test];
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
