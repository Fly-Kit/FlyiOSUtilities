//
//  rankingCollectionView.m
//  xiongTest
//
//  Created by bita on 15/12/14.
//  Copyright (c) 2015年 luxiaobin. All rights reserved.
//

#import "rankingCollectionView.h"

@interface rankingCollectionView()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    
}

@property(nonatomic,strong) NSMutableArray * collectionViewArray;

@end

@implementation rankingCollectionView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

#pragma mark - fresh -
-(void)freshCollectionViewData:(NSMutableArray *)videoArray
{
    self.collectionViewArray = videoArray;
    
    [self reloadData];
    
}

#define collectionCellH 20.f
#define collectionCellW 40.f

-(id)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        // Initialization code
        
        [self registerClass:[rankingCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        self.alwaysBounceVertical = YES;
        self.dataSource = self;
        self.delegate = self;
        self.backgroundColor = [UIColor clearColor];
        self.pagingEnabled = YES;
        self.alwaysBounceVertical = NO;
        self.alwaysBounceHorizontal = YES;
        self.showsHorizontalScrollIndicator = NO;
    }
    return self;
}

#pragma mark - delegate -

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.frame.size.width - 20.f, collectionCellH);
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_collectionViewArray count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString * cellIdentifier = @"cell";
    rankingCollectionViewCell * cell = (rankingCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    if (cell) {
        cell.backgroundColor = [UIColor clearColor];
    }
    
    [cell refreshDatacell:[self.collectionViewArray objectAtIndex:(indexPath.row)]];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;      // called when scroll view grinds to a halt
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //NSLog(@"%f",scrollView.contentOffset.x);
    if ([self.pageDeleagte respondsToSelector:@selector(pageControl:)]) {
        [self.pageDeleagte pageControl:(NSInteger)((scrollView.contentOffset.x+10.f)/self.frame.size.width)];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
