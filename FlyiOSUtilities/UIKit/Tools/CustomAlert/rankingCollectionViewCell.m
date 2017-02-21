//
//  rankingCollectionViewCell.m
//  xiongTest
//
//  Created by bita on 15/12/14.
//  Copyright (c) 2015年 luxiaobin. All rights reserved.
//

#import "rankingCollectionViewCell.h"

@implementation CERankScoreModel
@end

@interface rankingCollectionViewCell()

@property (nonatomic,strong) UILabel *labelText;
@property (nonatomic,strong) UILabel *labelNumber;

@end

@implementation rankingCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self cotentAddView:frame];
        self.backgroundColor = [UIColor redColor];
        
    }
    return self;
}

#define collectionCellH 20.f
#define collectionCellW 40.f

- (void)cotentAddView:(CGRect)frame
{
    self.labelText = [[UILabel alloc] initWithFrame:CGRectMake(0.f, 0.f, self.frame.size.width-collectionCellW, collectionCellH)];
    
    self.labelText.font = [UIFont systemFontOfSize:12.f];
    self.labelText.textAlignment = NSTextAlignmentLeft;
    self.labelText.textColor = [UIColor blackColor];

    self.labelText.clipsToBounds = YES;
    
    [self.contentView addSubview:self.labelText];
    
    self.labelNumber = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width-collectionCellW, 0.f, collectionCellW, collectionCellH)];
    
    self.labelNumber.font = [UIFont systemFontOfSize:12.f];
    self.labelNumber.textAlignment = NSTextAlignmentRight;
    self.labelNumber.textColor = [UIColor blackColor];
    
    self.labelNumber.clipsToBounds = YES;
    
    [self.contentView addSubview:self.labelNumber];
}

- (void)refreshDatacell:(CERankScoreModel *)mode
{
    self.labelText.text = mode.carName;
    self.labelNumber.text = mode.carRanking;
}

@end
