//
//  CRLIManager.m
//  CRList
//
//  Created by caine on 1/9/16.
//  Copyright © 2016 com.caine. All rights reserved.
//

#import "CRLIManager.h"
#import "CRLIAssetManager.h"

@implementation CRLIManager

+ (instancetype)defaultManager{
    static CRLIManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[CRLIManager alloc] init];
    });
    return manager;
}

- (instancetype)init{
    self = [super init];
    if( self ){
        self.assets = [CRLIAssetManager fetchAssets];
    }
    return self;
}

- (void)setAssets:(NSMutableArray *)assets{
    _assets = assets;
    
    if( self.todoAssets == nil )
        self.todoAssets = [[NSMutableArray alloc] init];
    else
        [self.todoAssets removeAllObjects];
    
    if( self.doneAssets == nil )
        self.doneAssets = [[NSMutableArray alloc] init];
    else
        [self.doneAssets removeAllObjects];
    
    [assets enumerateObjectsUsingBlock:^(CRLIAsset *asset, NSUInteger index, BOOL *sS){
        if( [asset.checkedTime isEqualToString:CRLIAssetCheckedTimeDefVal] ){
            [self.todoAssets addObject:asset];
        }else{
            [self.doneAssets addObject:asset];
        }
    }];
}

@end
