//
//  rankingCollectionViewCell.h
//  xiongTest
//
//  Created by bita on 15/12/14.
//  Copyright (c) 2015年 luxiaobin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CERankScoreModel : NSObject

@property (nonatomic,copy) NSString *carName;    //名字
@property (nonatomic,copy) NSString *carRanking; //排名

@end

@interface rankingCollectionViewCell : UICollectionViewCell

- (void)refreshDatacell:(CERankScoreModel *)mode;

@end
