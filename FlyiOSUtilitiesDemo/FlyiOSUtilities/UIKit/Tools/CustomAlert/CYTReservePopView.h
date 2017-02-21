//
//  CYTReservePopView.h
//  CYTEasyPass
//
//  Created by bita on 15/9/2.
//  Copyright (c) 2015年 EasyPass. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "rankingCollectionView.h"

//预定弹框
@interface CYTReservePopView : UIView

- (instancetype)initWithPopViewTitle:(NSString *)title message:(NSMutableArray *)message okButtonTitle:(NSString *)okButtonTitle;

//展示界面
- (void)show;

//消失界面
- (void)dismiss;

@end


