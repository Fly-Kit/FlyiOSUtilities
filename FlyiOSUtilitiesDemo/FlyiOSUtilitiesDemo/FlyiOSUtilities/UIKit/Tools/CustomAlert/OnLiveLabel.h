//
//  OnLiveLabel.h
//  HKS_LCT
//
//  Created by luxiaobin on 13-12-27.
//  Copyright (c) 2013年 ZhengQI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OnLiveLabel : UILabel


@property (nonatomic,assign) BOOL selected_On;

- (void)addTarget:( id)target withSelector:(SEL)action;

-(void)selectedLive;

-(void)noSelectedLive;

@end
