//
//  CRLIAssetManager.h
//  CRList
//
//  Created by caine on 1/10/16.
//  Copyright © 2016 com.caine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CRLIAsset.h"

@interface CRLIAssetManager : NSObject

+ (CRLIAsset *)assetFromArray:(NSArray *)array;
+ (NSArray   *)arrayFromAsset:(CRLIAsset *)asset;

+ (NSMutableArray *)fetchAssets;
+ (BOOL)updateAssets:(NSArray *)assets;
+ (BOOL)clearAllAssets:(BOOL)sure;


@end
