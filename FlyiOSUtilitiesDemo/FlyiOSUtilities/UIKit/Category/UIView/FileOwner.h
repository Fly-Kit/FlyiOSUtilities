//
//  FileOwner.h
//  xib测试
//
//  Created by fengly on 15/11/2.
//  Copyright © 2015年 fengly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface FileOwner : NSObject
@property (nonatomic, weak) IBOutlet UIView *view;
+(id)viewFromNibNamed:(NSString*) nibName;

@end
