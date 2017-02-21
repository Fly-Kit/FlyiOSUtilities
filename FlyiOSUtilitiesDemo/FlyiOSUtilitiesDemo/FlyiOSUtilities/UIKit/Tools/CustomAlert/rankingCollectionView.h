//
//  rankingCollectionView.h
//  xiongTest
//
//  Created by bita on 15/12/14.
//  Copyright (c) 2015年 luxiaobin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "rankingCollectionViewCell.h"

@protocol rankingCollectionViewDeleagte <NSObject>

- (void)pageControl:(NSInteger)pageCount;

@end

@interface rankingCollectionView : UICollectionView

@property (nonatomic,weak) id<rankingCollectionViewDeleagte> pageDeleagte;

-(void)freshCollectionViewData:(NSMutableArray *)videoArray;

@end
