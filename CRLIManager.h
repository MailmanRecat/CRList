//
//  CRLIManager.h
//  CRList
//
//  Created by caine on 1/9/16.
//  Copyright © 2016 com.caine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CRLIAsset.h"

@interface CRLIManager : NSObject

@property( nonatomic, strong ) NSMutableArray *assets;
@property( nonatomic, strong ) NSMutableArray *todoAssets;
@property( nonatomic, strong ) NSMutableArray *doneAssets;

+ (instancetype)defaultManager;

@end
