//
//  UIView+LoadNib.h
//  xib测试
//
//  Created by fengly on 15/11/2.
//  Copyright © 2015年 fengly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LoadNib)
+ (id)loadFromNib;
+ (id)loadFromNibNamed:(NSString*) nibName;
+ (id)loadFromNibNoOwner;
@end
