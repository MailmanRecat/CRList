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

+ (NSArray<CRLIAsset *> *)fetchItemAssets;

@end
