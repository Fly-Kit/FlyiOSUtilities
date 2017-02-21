//
//  FileOwner.m
//  xib测试
//
//  Created by fengly on 15/11/2.
//  Copyright © 2015年 fengly. All rights reserved.
//

#import "FileOwner.h"

@implementation FileOwner


+(id)viewFromNibNamed:(NSString*) nibName {
    
    FileOwner *owner = [[self alloc] init];
    
    [[NSBundle mainBundle] loadNibNamed:nibName owner:owner options:nil];
    
    return owner.view;
    
}

@end
